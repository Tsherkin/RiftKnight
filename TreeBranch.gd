extends StaticBody2D

@export var item: InvItem
var entity = null

func _on_interactable_area_body_entered(body):
	if body.has_method("player"):
		entity = body
		entitycollect()
		await get_tree().create_timer(0.1).timeout
		self.queue_free()

func entitycollect():
	entity.collect(item)
