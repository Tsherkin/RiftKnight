class_name Mob extends RigidBody2D

@export var entity: Entity
# Called when the node enters the scene tree for the first time.
func _ready():
	entity.connect("entity_is_dead", on_entity_is_dead)
	var animation_states = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(animation_states[randi() % animation_states.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func on_entity_is_dead():
	queue_free()
