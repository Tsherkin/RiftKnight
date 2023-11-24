extends Node
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	
func _process(_delta):
	pass
func game_over():
	$ScoreTimer.stop()
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
