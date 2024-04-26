class_name InvItem
extends Resource

enum Type {HEAD, CHEST, LEGS, FEET, WEAPON, ACCESSORY, MAIN, FOOD}

@export var type: Type
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D
