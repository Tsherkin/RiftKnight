class_name Entity extends Node2D

var health = 0
@export var max_health = 0
@export var Inventory: Inv

signal entity_is_dead()

func _ready():
	health = max_health

func set_health(amount: int):
	health -= amount
	print(health)
	if health >= max_health:
		health = max_health
	elif health <= 0:
		health = 0
		emit_signal("entity_is_dead")

#Death
func death():
	print("DEAD")
	get_parent().queue_free()

#func _on_death_timer_timeout():
	#var item_data = get_parent().Inventory.drop_all()
	#var item_instance = load("res://Scenes/ItemDrop.tscn").instantiate()
	#item_instance.item = item_data
	#get_parent().get_parent().add_child(item_instance)
	#print(item_instance)
	#death()
	#$"../DeathTimer".stop()
