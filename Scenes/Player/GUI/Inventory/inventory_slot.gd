class_name InventorySlot
extends PanelContainer


@export var type: ItemData.Type

# Custom init function so that it doesn't error
func init(t: ItemData.Type, cms: Vector2) -> void:
	type = t
	custom_minimum_size = cms


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
				return get_child(0).data.type == data.data.type
		else:
			return data.data.type == type
	print("invalid")
	return false


# _at_position is not used because it doesn't matter where on the panel
# the item is dropped
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		#theres an item in the slot being dropped in.
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)

func _physics_process(delta: float) -> void:
	if get_child_count() > 0:
		#theres an item in the slot being dropped in.
		var item := get_child(0)
		if type == ItemData.Type.WEAPON:
			Game.right_hand_equipped = item.data
		else:
			Game.right_hand_equipped = load("res://Scenes/Player/GUI/Inventory/resources/default_sword.tres")
	
	
func _gui_input(event):
	#use a misc item
	if event is InputEventMouseButton:
		if (event.button_index == 1) and (event.button_mask == 1):
			if get_child_count() > 0:
				if (get_child(0).data.type == ItemData.Type.MISC):
					#use misc item
					Game.player_health += get_child(0).data.item_health
					if Game.player_health > Game.player_max_health:
						Game.player_health = Game.player_max_health
					get_child(0).data.count -= 1
					get_child(0).get_child(0).text = str(get_child(0).data.count)
					if get_child(0).data.count <= 0:
						get_child(0).queue_free()
