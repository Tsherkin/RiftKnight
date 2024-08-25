class_name ItemDrop
extends StaticBody2D

@export var item: InvItem
@onready var item_visual: Sprite2D = $Sprite2D
@export var item_drop: PackedScene
@onready var inv : Inv = preload("res://inventory/playerinv.tres")

var full = null
var entity = null

func _ready():
	item_visual.texture = item.texture
	inv.full.connect(inventory_full)

func _on_interactable_area_body_entered(body):
	if body.has_method("inventory"):
		entity = body
		entitycollect()
		await get_tree().create_timer(0.1).timeout
		if !full:
			self.queue_free()

func inventory_full():
	full = true

func entitycollect():
	entity.collect(item)
