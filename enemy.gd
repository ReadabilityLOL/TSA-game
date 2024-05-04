extends KinematicBody

# Reference to the player node
onready var player = get_node("/root/YourSceneName/Player")
# Reference to the singleton for shared data
onready var game_state = get_node("/root/GameState")

# Movement speed
var speed = 5.0

func _ready():
    # Add this enemy to the game state's list of enemies
    game_state.add_enemy(self)

func _physics_process(delta):
    var path = get_simple_path(global_transform.origin, player.global_transform.origin)
    if path.size() > 1:
        var direction = (path[1] - global_transform.origin).normalized()
        move_and_slide(direction * speed)
        
        # Tilt towards the player
        var tilt_angle = atan2(direction.x, direction.z)
        rotation.y = tilt_angle

func _on_Area_body_entered(body):
    if body == player:
        player.take_damage(10) # Assuming the player has a take_damage function
        # Example for moving away
        var random_position = Vector3(rand_range(-100, 100), 0, rand_range(-100, 100))
        var path = get_simple_path(global_transform.origin, random_position)
        if path.size() > 1:
            var direction = (path[1] - global_transform.origin).normalized()
            move_and_slide(direction * speed)

func get_nearest_player():
    var nearest_player = null
    var nearest_distance = INF
    for enemy in game_state.enemies:
        if enemy != self:
            var distance = global_transform.origin.distance_to(enemy.global_transform.origin)
            if distance < nearest_distance:
                nearest_distance = distance
                nearest_player = enemy
    return nearest_player

func _exit_tree():
    # Remove this enemy from the game state's list of enemies
    game_state.remove_enemy(self)
