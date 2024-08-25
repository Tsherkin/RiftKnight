extends RigidBody2D


<<<<<<< Updated upstream
# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
=======
@export var entity: Entity
var player = null
var hurt = false
var player_chase = false
var speed = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	entity.connect("entity_is_dead", on_entity_is_dead)
	entity.connect("entity_took_damage", on_damage_taken)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _on_visible_on_screen_notifier_2d_screen_exited():
	#queue_free()

func on_entity_is_dead():
	entity.dead()

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play()
	if player_chase:
		if hurt:
			$AnimatedSprite2D.animation = "hurt"
		else:
			position += (player.position - position) / speed
			$AnimatedSprite2D.animation = "walk"
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.animation = "idle"

func on_damage_taken():
	print("took damage")
	hurt = true

func _on_trigger_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
func _on_trigger_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false


func _on_animated_sprite_2d_animation_looped() -> void:
	if hurt:
		hurt = false
>>>>>>> Stashed changes
