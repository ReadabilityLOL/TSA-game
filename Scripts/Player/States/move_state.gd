extends Node
class_name move_state

@onready var player: Node = get_parent().get_parent()


func reset_node() -> void:
	player.anim_tree.get("parameters/playback").travel("Walk")

func _physics_process(delta: float) -> void:
	if player.current_state == "move":
		if Input.is_action_pressed("move_right"):
			var velocity_goal: float = min(player.velocity.x + player.acceleration * delta, player.max_speed * delta)
			player.velocity.x = lerp(player.velocity.x, velocity_goal, player.weight)
		elif Input.is_action_pressed("move_left"):
			var velocity_goal: float = max(player.velocity.x - player.acceleration * delta, -player.max_speed * delta)
			player.velocity.x = lerp(player.velocity.x, velocity_goal, player.weight)
		else:
			player.change_state("idle")
		
		
		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump_count += 1
			player.velocity.y = -player.jump_height * delta
			player.change_state("jump")


func exit() -> void:
	pass
