extends Camera

# Reference to the player node
onready var player = get_node("/root/YourSceneName/Player")

# Camera offset from the player
var offset = Vector3(0, 10, -10)

func _process(delta):
    # Calculate the new position for the camera
    var new_position = player.global_transform.origin + offset
    
    # Smoothly interpolate the camera's position to the new position
    global_transform.origin = global_transform.origin.linear_interpolate(new_position, 0.1)
    
    # Ensure the camera always looks at the player
    look_at(player.global_transform.origin, Vector3.UP)
