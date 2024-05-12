extends Node


var AIController

func _ready():
	AIController = get_parent().get_parent()
	AIController.get_node("AnimationTree").get("parameters/playback").travel("Death")

	
func _process(delta):
	AIController.velocity.x = 0
	AIController.velocity.z = 0
	
