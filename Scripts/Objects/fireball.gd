extends Area3D


var direction: Vector3 = Vector3(0, 0, 0)
var speed: int = 1
var damage: int = 1
var owner_name: String = "player"
var exploding = false

func _physics_process(delta: float) -> void:
	if !exploding:
		self.position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if owner_name == "monster":
		if body.is_in_group("player"):
			body.hit(damage)
			exploding = true
			get_node("GPUParticles3D").hide()
			get_node("CPUParticles3D").emitting = true
			


func _on_cpu_particles_3d_finished() -> void:
	self.queue_free()
