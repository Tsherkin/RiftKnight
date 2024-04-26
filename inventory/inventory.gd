extends Resource

class_name Inv

signal update

@export var slots: Array[InvSlot]


func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item )
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func drop_all():
	var itemslots = slots.filter(func(slot): return slot.item != null)
	var item_drop
	if !itemslots.is_empty():
		itemslots[0].amount -= 1
		item_drop = itemslots[0].item
	return item_drop

#func spawn_item():
	#var item_drop_instance : ItemDrop = item_drop.instantiate() as ItemDrop
	#var item = preload("res://inventory/Items/Resources/Apple.tres")
	#level_parent.add_child(item_drop_instance)
	#item_drop_instance.item = item
	#
