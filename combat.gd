extends KinematicBody2D

signal player_hit

func _ready():
    connect("player_hit", self, "_on_player_hit")

func _on_player_hit():
    # Implement player death logic here
    print("Player has been hit and died.")

extends Node

var items : Array = []

signal item_added(item_name)
signal item_used(item_name)

func add_item(item_name : String):
    items.append(item_name)
    emit_signal("item_added", item_name)

func use_item(item_name : String):
    if items.has(item_name):
        items.erase(item_name)
        emit_signal("item_used", item_name)
