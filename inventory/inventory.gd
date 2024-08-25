extends Resource

class_name Inv

signal update
signal full

@export var slots: Array[InvSlot]


func insert(item: InvItem):
	# Returns slot with the same item as picked up item
	var itemslots = slots.filter(func(slot): return slot.item == item)
	if itemslots:
		itemslots[0].amount += 1
	else:
		#Returns slot with no item inside
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if emptyslots:
			emptyslots[0].item = item
			emptyslots[0].amount = 1
		else:
			full.emit()
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
