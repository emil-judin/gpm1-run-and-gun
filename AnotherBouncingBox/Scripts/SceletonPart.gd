extends RigidBody2D
class_name SceletonPart
@export var boneDestroyParticles: PackedScene

func _ready():
	continuous_cd = RigidBody2D.CCD_MODE_CAST_SHAPE

func receive_damage(damage):
	$HealthManager.receive_damage(self, damage)

func die():
	var particles: CPUParticles2D = boneDestroyParticles.instantiate() as CPUParticles2D
	get_tree().current_scene.add_child(particles)
	particles.global_position = global_position
	queue_free()
