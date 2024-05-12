extends Node


var AIController
var run = false

func _ready():
	AIController = get_parent().get_parent()
	if AIController.Attacking:
		await AIController.get_node("AnimationTree").animation_finished
	else:
		AIController.get_node("AnimationTree").get("parameters/playback").travel("Scream")
		AIController.Screaming = true
		await AIController.get_node("AnimationTree").animation_finished
	run = true
	AIController.Screaming = false
	AIController.get_node("AnimationTree").get("parameters/playback").travel("Run")

func _physics_process(delta):
	if AIController and run:
		if AIController.player:
			AIController.velocity.x = AIController.direction.x * AIController.SPEED
			AIController.velocity.z = AIController.direction.z * AIController.SPEED
			AIController.look_at(AIController.global_transform.origin + AIController.direction, Vector3(0, 1, 0))
