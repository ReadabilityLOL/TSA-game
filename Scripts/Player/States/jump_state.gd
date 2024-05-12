extends Node
class_name jump_state

@onready var player: Node = get_parent().get_parent()

func reset_node() -> void:
	player.anim_tree.get("parameters/playback").travel("Jump_Start")

func _physics_process(delta: float) -> void:
	if player.current_state == "jump":
		if Input.is_action_pressed("move_right"):
			player.velocity.x = min(player.velocity.x + player.acceleration * delta, player.max_speed * delta)
		elif Input.is_action_pressed("move_left"):
			player.velocity.x = max(player.velocity.x - player.acceleration * delta, -player.max_speed * delta)
		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump_count += 1
			player.velocity.y = -player.jump_height * delta
			player.change_state("jump")
		if player.velocity.y > 0:
			player.change_state("fall")

func exit() -> void:
	pass
