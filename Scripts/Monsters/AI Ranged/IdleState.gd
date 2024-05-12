extends Node


var AIController

func _ready():
	AIController = get_parent().get_parent()
	if AIController.Screaming:
		await AIController.get_node("AnimationTree").animation_finished
	AIController.get_node("AnimationTree").get("parameters/playback").travel("Idle")
	


func _process(delta):
	if AIController:
		AIController.velocity.x = 0
		AIController.velocity.z = 0
	
