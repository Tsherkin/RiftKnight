class_name Entity extends Node

#var alive = true
var step = 0
var step_size = 0.5
var health = 0
var falling = 0
var fell = false

@export var max_health = 10
@export var item: InvItem

func _ready():
	health = max_health

func _process(_delta):
	if health <= 0:
		# Increment the falling variable
		falling += step_size * _delta
		# Calculate the rotated degree based on ease_out_bounce
		var rotated_degree = ease_in_quint(falling)
		if !fell:
			get_parent().set_rotation_degrees(rotated_degree)
		print(falling)
		if falling >= 1 and !fell:
			print("timer")
			fell = true
			$"../DeathTimer".start()

func set_health(ammount: int):
	health -=ammount
	print(health)
	if health >= max_health:
		health = max_health
	elif health <= 0:
		health = 0
 
func death():
	print("DEAD")
	get_parent().queue_free()
	
func ease_in_quint(x: float) -> float:
	return (x * x * x * x * x) * 90

func _on_death_timer_timeout():
	death()
	$"../DeathTimer".stop()
