class_name _Tree extends StaticBody2D

var step = 0
var step_size = 0.5
var falling = 0
var fell = false
var dead: bool

@export var entity : Entity

func _ready():
	entity.connect("entity_is_dead", on_entity_is_dead)

func _process(_delta):
	if dead:
		# Increment the falling variable
		falling += step_size * _delta
		print(falling)
		# Calculate the rotated degree based on ease_out_bounce
		var rotated_degree = ease_in_quint(falling)
		if !fell:
			set_rotation_degrees(rotated_degree)
		print(falling)
		if falling >= 1 and !fell:
			fell = true
			$DeathTimer.start()

#This is a math func from easing.net. Translated by chatGPT
func ease_in_quint(x: float) -> float:
	return (x * x * x * x * x) * 90

func on_entity_is_dead():
	dead = true

func _on_death_timer_timeout():
	var item_data = entity.Inventory.drop_all()
	var item_instance = load("res://Scenes/ItemDrop.tscn").instantiate()
	item_instance.item = item_data
	item_instance.position = position
	get_parent().add_child(item_instance)
	print(item_instance)
	$DeathTimer.stop()
	queue_free()
	
	
#@export var item_drop: PackedScene
#@onready var level_parent = get_parent()
#
#
#func spawn_item():
	#var item_drop_instance : ItemDrop = item_drop.instantiate() as ItemDrop
	#var item = preload("res://inventory/Items/Resources/Apple.tres")
	#level_parent.add_child(item_drop_instance)
	#item_drop_instance.item = item
	#



