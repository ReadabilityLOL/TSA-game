extends CharacterBody3D

# Grabs the prebuilt AnimationTree 
@onready var PlayerAnimationTree = $AnimationTree
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

# Allows to pick your chracter's mesh from the inspector
@export_node_path var PlayerCharacterMesh
@onready var player_mesh = get_node(PlayerCharacterMesh)

# Gamplay mechanics and Inspector tweakables
@export var gravity = 9.8
@export var jump_force = 9
@export var walk_speed = 10
@export var run_speed = 20


# Animation node names
var idle_node_name = "Idle"
var walk_node_name = "Walk"
var run_node_name = "Run"
var jump_node_name = "Jump"
var attack1_node_name = "Attack1"
var death_node_name = "Death_A"

# Condition States
var is_attacking = bool()
var is_walking = bool()
var is_running = bool()
var is_dying = bool()

# Physics values
var direction = Vector3()
var horizontal_velocity = Vector3()
var aim_turn = float()
var movement = Vector3()
var vertical_velocity = Vector3()
var movement_speed = int()
var angular_acceleration = int()
var acceleration = int()
var just_hit: bool = false

func _ready(): # Camera based Rotation
	direction = Vector3.BACK.rotated(Vector3.UP, $Camroot/h.global_transform.basis.get_euler().y)

func _input(event): # All major mouse and button input events
	if event is InputEventMouseMotion:
		aim_turn = -event.relative.x * 0.015 # animates player with mouse movement while aiming 
	if event.is_action_pressed("aim"): # Aim button triggers a strafe walk and camera mechanic
		direction = $Camroot/h.global_transform.basis.z

func attack1(): # If not doing other things, start attack1
	if (idle_node_name in playback.get_current_node() or walk_node_name in playback.get_current_node()) and is_on_floor():
		if Input.is_action_just_pressed("attack"):
			if (is_attacking == false):
				playback.travel(attack1_node_name)

func _physics_process(delta):
	var on_floor = is_on_floor()
	if !is_dying:
		attack1()
		 # State control for is jumping/falling/landing
		var h_rot = $Camroot/h.global_transform.basis.get_euler().y
		movement_speed = 0
		angular_acceleration = 10
		acceleration = 15
		if not is_on_floor(): 
			vertical_velocity += Vector3.DOWN * gravity * 2 * delta
		else: 
			vertical_velocity = Vector3.DOWN * gravity / 10
		
		if (attack1_node_name in playback.get_current_node()): 
			is_attacking = true
		else: 
			is_attacking = false
		if Input.is_action_just_pressed("jump") and ((is_attacking != true)) and is_on_floor():
			vertical_velocity = Vector3.UP * jump_force
			
		if (Input.is_action_pressed("forward") ||  Input.is_action_pressed("backward") ||  Input.is_action_pressed("left") ||  Input.is_action_pressed("right")):
			direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
						0,
						Input.get_action_strength("forward") - Input.get_action_strength("backward"))
			direction = direction.rotated(Vector3.UP, h_rot).normalized()
			is_walking = true
			if Input.is_action_pressed("sprint") and $DashTimer.is_stopped() and (is_walking == true ):
				movement_speed = run_speed
				is_running = true
			else: # Walk State and speed
				movement_speed = walk_speed
				is_running = false
		else: 
			is_walking = false
			is_running = false
		if Input.is_action_pressed("aim"):  # Aim/Strafe input and  mechanics
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, $Camroot/h.rotation.y, delta * angular_acceleration)
		else:
			player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta * angular_acceleration)

		if (is_attacking == true): 
			horizontal_velocity = horizontal_velocity.lerp(direction.normalized() * .01 , acceleration * delta)
		else:
			horizontal_velocity = horizontal_velocity.lerp(direction.normalized() * movement_speed, acceleration * delta)

		velocity.z = horizontal_velocity.z + vertical_velocity.z
		velocity.x = horizontal_velocity.x + vertical_velocity.x
		velocity.y = vertical_velocity.y
		move_and_slide()
	animation_tree["parameters/conditions/IsOnFloor"] = on_floor
	animation_tree["parameters/conditions/IsInAir"] = !on_floor
	animation_tree["parameters/conditions/IsWalking"] = is_walking
	animation_tree["parameters/conditions/IsNotWalking"] = !is_walking
	animation_tree["parameters/conditions/IsRunning"] = is_running
	animation_tree["parameters/conditions/IsNotRunning"] = !is_running
	animation_tree["parameters/conditions/is_dying"] = is_dying
	
func hit(damage):
	if !just_hit:
		get_node("hit").play()
		get_node("just_hit").start()
		just_hit = true
		if (damage - Game.right_hand_equipped.item_defense) > 0:
			Game.player_health -= (damage - Game.right_hand_equipped.item_defense)
		if Game.player_health <= 0:
			is_dying = true
			playback.travel(death_node_name)
		#Knockback
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", global_position - (direction/1.5), 0.2)
		


func _on_damage_detector_body_entered(body):
	if is_attacking:
		if body.is_in_group("Monster"):
			body.hit(Game.right_hand_equipped.item_damage)
			get_node("damage").play()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Death_A":
		#Player death
		get_node("../Game Over Overlay").game_over()


func _on_just_hit_timeout() -> void:
	just_hit = false
