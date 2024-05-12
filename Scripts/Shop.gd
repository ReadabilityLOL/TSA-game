extends CanvasLayer

@onready var shop_item = preload("res://Scenes/Shop/shop_item.tscn")
var current_item: ItemData
func _ready() -> void:
	for i in Game.items:
		if i != "default":
			var shop_item_temp = shop_item.instantiate()
			shop_item_temp.item_info = Game.items[i]
			shop_item_temp.get_node("image").texture = Game.items[i].item_texture
			$Shop_items.add_child(shop_item_temp)
	$item_info.hide()


func _on_buy_pressed() -> void:
	get_node("../Container/Inventory").add_item(str(get_node("item_info/Name").text))


func _on_close_pressed() -> void:
	self.hide()
