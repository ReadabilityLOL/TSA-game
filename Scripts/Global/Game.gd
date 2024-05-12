extends Node

var items = {
	"default": preload("res://Scenes/Player/GUI/Inventory/resources/default_sword.tres"),
	"sword": preload("res://Scenes/Player/GUI/Inventory/resources/sword.tres"),
	"small potion": preload("res://Scenes/Player/GUI/Inventory/resources/small_potion.tres"),
}
var right_hand_equipped: ItemData = items["default"]

var player_health: int = 10
var player_max_health: int = 10

var player_damage:int = 2
var player_defense: int = 0
