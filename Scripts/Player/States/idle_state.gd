extends Node
class_name idle_state

@onready var player: Node = get_parent().get_parent()

func reset_node() -> void:
	player.jump_count = 0
	player.anim_tree.get("parameters/playback").travel("Idle")

func _physics_process(delta: float) -> void:
	if player.current_state == "idle":
		if Input.is_action_pressed("move_right"):
			player.change_state("move")
		elif Input.is_action_pressed("move_left"):
			player.change_state("move")
		if Input.is_action_just_pressed("jump") and (player.jump_count < player.max_jumps):
			player.jump_count += 1
			player.velocity.y = -player.jump_height * delta
			player.change_state("jump")
			
		player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)


func exit() -> void:
	pass
