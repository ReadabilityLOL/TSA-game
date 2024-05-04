extends KinematicBody # or RigidBody

# Movement variables
var speed = 10
var acceleration = 20
var max_speed = 20
var turn_speed = 1.0
var tilt_amount = 5.0
var tilt_speed = 0.1
var tilt_direction = 1
var cooldown_timer = 5.0
var cooldown_time_left = 0.0

# Animation variables
var is_accelerating = false

func _ready():
    # Assuming you have an AnimationPlayer node as a child
    $AnimationPlayer.play("idle")

func _physics_process(delta):
    var direction = Vector3()
    var velocity = Vector3()
    
    # Input for movement
    if Input.is_action_pressed("move_forward"):
        direction -= transform.basis.z
    if Input.is_action_pressed("move_backward"):
        direction += transform.basis.z
    if Input.is_action_pressed("move_left"):
        direction -= transform.basis.x
    if Input.is_action_pressed("move_right"):
        direction += transform.basis.x
    
    # Input for turning
    if Input.is_action_pressed("turn_left"):
        rotate_y(deg2rad(-turn_speed * delta))
    if Input.is_action_pressed("turn_right"):
        rotate_y(deg2rad(turn_speed * delta))
    
    # Input for acceleration
    if Input.is_action_just_pressed("accelerate") and cooldown_time_left <= 0:
        is_accelerating = true
        cooldown_time_left = cooldown_timer
    
    # Apply acceleration if not in cooldown
    if is_accelerating:
        speed += acceleration * delta
        if speed > max_speed:
            speed = max_speed
        $AnimationPlayer.play("accelerating")
    else:
        speed = max_speed
        $AnimationPlayer.play("moving")
    
    # Apply movement
    velocity = direction.normalized() * speed
    move_and_slide(velocity)
    
    # Tilt for visual effect
    var tilt_angle = tilt_amount * tilt_direction
    rotate_x(deg2rad(tilt_angle * tilt_speed * delta))
    tilt_direction *= -1
    
    # Reset tilt after a full cycle
    if abs(tilt_angle) >= tilt_amount:
        tilt_direction *= -1
    
    # Cooldown for acceleration
    if cooldown_time_left > 0:
        cooldown_time_left -= delta
    else:
        is_accelerating = false
        speed = max_speed
        $AnimationPlayer.play("moving")


func take_damage(amount):
    health -= amount
    if health <= 0:
        # Handle player death
        pass

onready var player_stats = $PlayerStats

func _ready():
    # Player takes damage
    var damage = 10
    player_stats.take_damage(damage)

    # Player uses mana
    var mana_cost = 5
    player_stats.use_mana(mana_cost)

    # Player uses stamina
    var stamina_cost = 10
    player_stats.use_stamina(stamina_cost)

    # Player gains XP
    var xp_gain = 20
    player_stats.gain_xp(xp_gain)

    # Reset player stats (e.g., on respawn)
    player_stats.reset_stats()
