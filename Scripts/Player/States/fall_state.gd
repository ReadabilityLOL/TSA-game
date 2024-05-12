extends Node
class_name fall_state

@onready var player: Node = get_parent().get_parent()
func reset_node() -> void:
	player.anim_tree.get("parameters/playback").travel("Jump_Land")
func _physics_process(delta: float) -> void:
	if player.current_state == "fall":
		if Input.is_action_pressed("move_right"):
			player.velocity.x = min(player.velocity.x + player.acceleration * delta, player.max_speed * delta)
		elif Input.is_action_pressed("move_left"):
			player.velocity.x = max(player.velocity.x - player.acceleration * delta, -player.max_speed * delta)
		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump_count += 1
			player.velocity.y = -player.jump_height * delta
			player.change_state("jump")
		if player.is_on_floor():
			player.change_state("idle")
func exit() -> void:
	pass
