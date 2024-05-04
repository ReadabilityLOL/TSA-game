extends Node

# Reference to the DirectionalLight node
onready var directional_light = $DirectionalLight

# Day/Night cycle settings
var day_length = 60.0 # Length of a day in seconds
var current_time = 0.0 # Current time in seconds
var rotation_speed = 2 * PI / day_length # Speed of rotation per second

# Signal to connect to other parts of the game
signal time_of_day_changed(time)

func _ready():
    # Connect the signal to a function that will handle changes in the game
    connect("time_of_day_changed", self, "_on_time_of_day_changed")

func _process(delta):
    # Update the current time
    current_time += delta
    current_time %= day_length # Keep the time within the day_length
    
    # Rotate the light based on the current time
    var rotation_angle = current_time * rotation_speed
    directional_light.rotation_degrees.y = rotation_angle * 180 / PI
    
    # Calculate the light's intensity based on the cosine function
    var intensity = (cos(current_time * rotation_speed) + 1) / 2
    directional_light.light_energy = intensity
    
    # Emit the signal with the current time
    emit_signal("time_of_day_changed", current_time)

func _on_time_of_day_changed(time):
    # Example: Change the noise player's settings based on the time
    if time < 30.0: # Example condition for night
        # Change the noise player's settings for night
        pass
    elif time < 60.0: # Example condition for dawn
        # Change the noise player's settings for dawn
        pass
    else: # Example condition for day
        # Change the noise player's settings for day
        pass
