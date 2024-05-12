extends Node
class_name death_state

@onready var player: Node = get_parent().get_parent()


func reset_node() -> void:
	player.anim_tree.get("parameters/playback").travel("Death")
	
func _physics_process(delta: float) -> void:
	pass
func exit() -> void:
	pass
