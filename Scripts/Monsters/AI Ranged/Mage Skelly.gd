extends CharacterBody3D

@onready var item_scene:PackedScene = preload("res://Scenes/Objects/Item_object.tscn")
@onready var fire_ball_scene: PackedScene = preload("res://Scenes/Objects/fireball.tscn")
const SPEED = 2.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var player: CharacterBody3D
var direction: Vector3
var Screaming: bool  = false
var Attacking: bool = false
var Health: int = 4
var damage: int = 2
var dying: bool = false
var just_hit: bool = false

func _ready():
	get_node("Node3D/SubViewport/ProgressBar").max_value = Health
	$StateMachine.changeState("Idle")

func _physics_process(delta):
	get_node("Node3D/SubViewport/ProgressBar").value = Health
	if not is_on_floor():
		velocity.y -= gravity * delta
	if player:
		direction = (player.global_transform.origin - self.global_transform.origin).normalized()
	move_and_slide()

func _on_chase_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		$StateMachine.changeState("Run")


func _on_chase_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		$StateMachine.changeState("Idle")

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Scream":
		Screaming = false
	elif anim_name == "Attack":
		Attacking = false
		$StateMachine.changeState("Run")
	elif anim_name == "Death_A":
		var rng = randi_range(2,5)
		for i in range(rng):
			var item_temp = item_scene.instantiate()
			item_temp.global_position = self.global_position
			get_node("../../Items").add_child(item_temp)
		self.queue_free()
	
func _on_attack_player_detection_body_entered(body):
	if body.is_in_group("player") and !dying:
		$StateMachine.changeState("Attack")

func _on_attack_player_detection_body_exited(body):
	if body.is_in_group("player") and !dying:
		$StateMachine.changeState("Run")

func hit(Damage):
	if !just_hit:
		get_node("just_hit").start()
		just_hit = true
		Health -= Damage
		if Health <= 0:
			$StateMachine.changeState("Death")
		#Knockback
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", global_position - (direction/1.5), 0.2)

func _on_damage_body_entered(body):
	if body.is_in_group("player"):
		if Attacking:
			body.hit(damage)

func _on_just_hit_timeout():
	just_hit = false

func _on_shoot_timeout() -> void:
	if is_instance_valid(player):
		if player in ($AttackPlayerDetection.get_overlapping_bodies()):
			shoot()
func shoot():
	get_node("AnimationTree").get("parameters/playback").travel("Attack")
	await get_tree().create_timer(0.3).timeout
	var target_position = (player.global_position - self.global_position).normalized()
	var fire_ball_temp = fire_ball_scene.instantiate()
	fire_ball_temp.direction = target_position
	fire_ball_temp.owner_name = "monster"
	fire_ball_temp.speed = 3
	fire_ball_temp.damage = self.damage
	fire_ball_temp.look_at(target_position)
	fire_ball_temp.global_position = $Aim.global_position
	get_node("../../Projectiles").add_child(fire_ball_temp)
	await get_node("AnimationTree").animation_finished
	get_node("AnimationTree").get("parameters/playback").travel("Idle Stand")
	if player in ($AttackPlayerDetection.get_overlapping_bodies()):
		$shoot.start()
	
