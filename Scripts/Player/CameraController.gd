extends Node3D

# Allows to select the player mesh from the inspector
#@export_node_path(Node3D) var PlayerCharacterMesh: NodePath
#@onready var player_mesh = get_node(PlayerCharacterMesh)

var camrot_h = 0
var camrot_v = 0
@export var cam_v_max = 75 # 75 recommended
@export var cam_v_min = -55 # -55 recommended
var h_sensitivity = .01
var v_sensitivity = .01
var h_acceleration = 10
var v_acceleration = 10

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity

func _physics_process(delta):
	camrot_v = clamp(camrot_v, deg_to_rad(cam_v_min), deg_to_rad(cam_v_max))
	$h.rotation.y = lerpf($h.rotation.y, camrot_h, delta * h_acceleration)
	$h/v.rotation.x = lerpf($h/v.rotation.x, camrot_v, delta * v_acceleration)
	
