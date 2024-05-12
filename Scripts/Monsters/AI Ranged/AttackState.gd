extends Node

var AIController

func _ready():
	AIController = get_parent().get_parent()
	if AIController.Screaming:
		await AIController.get_node("AnimationTree").animation_finished
	AIController.Attacking = true
	AIController.look_at(AIController.global_transform.origin + AIController.direction, Vector3(0, 1, 0))
	AIController.shoot()
	

func _process(delta):
	if AIController:
		AIController.velocity.x = 0
		AIController.velocity.z = 0
