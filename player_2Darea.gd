extends CharacterBody2D


@export var speed = 100 #How fast player moves?
@export var jump_length = 150
var jump_count : int = 0
@export var max_jump_count = 3
@export var gravity = 150
var screen_size # Size of the game window
var falling : bool = false
var jump : bool = false
@export var max_health = 10
var health


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity = Vector2.ZERO
	if !falling and !jump:
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
	if Input.is_action_just_pressed("jump"):
		_jump()
	if Input.is_action_just_released("jump"):
		#falling = false
		pass

	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	if jump:
		$AnimatedSprite2D.animation = "dash_forward"
	elif velocity.x != 0 || velocity.y != 0 && jump == false:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif falling:
		$AnimatedSprite2D.animation = "fall"
	else:
		$AnimatedSprite2D.animation = "idle"
		
	_on_main_screen_walkable()

func start(pos):
	position = pos
	show()
	$HitCollider.disabled = false
	
func _jump():
	if jump_count < max_jump_count and velocity:
		jump = true
		jump_count += 1
		var jump_dir: Vector2 = get_last_motion()
		print("jumping")
		velocity = jump_dir.normalized() * jump_length
	if jump_count >= max_jump_count && !falling:
		$JumpCooldown.start()

func _on_main_screen_walkable():
	var player_pos : Vector2 = position
	var tile_map = get_parent().get_node("TileMap")
	var player_tile_pos : Vector2i = tile_map.local_to_map(player_pos)
	var tile_data = tile_map.get_cell_tile_data(0, player_tile_pos)
	if tile_data:
		var can_walk = tile_data.get_custom_data("can_walk")
		if can_walk:
			if jump:
				falling = false
	if falling:
		z_index = -6
		_death_scenario()
		print("falling")
		velocity.y += gravity
		$HitCollider.disabled = true
		$ColliderTimer.start()
	move_and_slide()
func _on_collider_timer_timeout():
	print("not ghosting")
	$HitCollider.disabled = false
	$ColliderTimer.stop()	

func _on_jump_cooldown_timeout():
	jump_count = 0
	$JumpCooldown.stop()
	print("jump reset")

func _on_animated_sprite_2d_animation_looped():
	if jump:
		jump = false
		print("looped")

func _death_scenario():
	print(health)
	if falling:
		health -= 0.1
	if health <= 0:
		health = max_health
		position = get_parent().get_node("StartPosition").position
		z_index = 0
		falling = false
		_on_main_screen_walkable()
