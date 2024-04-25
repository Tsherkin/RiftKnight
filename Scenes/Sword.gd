extends Area2D

@export var damage : int = 5
@export var player : Player
@export var hit_box : HitBox

func _ready():
	monitoring = false
	player.connect("player_did_damage", on_player_did_damage)
	player.connect("facing_direction_changed", on_player_facing_dir_changed)

func _on_body_entered(body):
	for child in body.get_children():
		if child is Entity:
			child.set_health(damage)
		
	print(body.name)

func on_player_did_damage(_set_mon : bool):
	set_monitoring(_set_mon)

func on_player_facing_dir_changed(_facing_direction: bool):
	if(_facing_direction):
		hit_box.position = hit_box.facing_left
	else:
		hit_box.position = hit_box.facing_right
