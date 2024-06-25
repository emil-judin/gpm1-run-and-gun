extends Node2D
class_name Gun

@export var maxFiringDegree: float = 25
@export var minFiringDegree: float = -20
@export var bulletCount: int = 1
@export var directionConeDegrees: float = 0
@export var spawnConeDegrees: float = 0
@export var bullet: PackedScene
@export var firingOffset: float

@export var cooldown: float = 0.2
var cooldownStart: float
var isGunEnabled: bool = false

signal shot_fired
	
func _process(delta):
	if !isGunEnabled:
		return
	
	var globalMousePosition = get_global_mouse_position()
	var angleTo = get_angle_to(globalMousePosition)
	var degrees = rad_to_deg(angleTo)
	var resultingDegrees = clamp(rotation_degrees + degrees, minFiringDegree, maxFiringDegree)
	var resultingAngle = deg_to_rad(resultingDegrees)
	rotation = resultingAngle
	
	if Input.is_action_pressed("Shoot") && Time.get_unix_time_from_system() - cooldownStart > cooldown:
		cooldownStart = Time.get_unix_time_from_system()
		var rng = RandomNumberGenerator.new()
		for i in bulletCount:
			var bulletInstance: Node2D = bullet.instantiate() as Node2D
			if bulletInstance != null:
				var randomSpawnDegree = rng.randf_range(-spawnConeDegrees / 2, spawnConeDegrees / 2)
				var randomDirectionDegree = rng.randf_range(-directionConeDegrees / 2, directionConeDegrees / 2)
				var spawnVector = Vector2.from_angle(resultingAngle + deg_to_rad(randomSpawnDegree))
				var directionVector = Vector2.from_angle(resultingAngle + deg_to_rad(randomDirectionDegree))
				var player = get_parent() as Player
				
				if player != null:
					spawnVector.x = player.facingDirectionSign * abs(spawnVector.x)
					directionVector.x = player.facingDirectionSign * abs(directionVector.x)
					
				bulletInstance.global_position = global_position + firingOffset * spawnVector.normalized()
				bulletInstance.direction = directionVector
				get_tree().current_scene.add_child(bulletInstance)
				shot_fired.emit()

func toggleGun(enabled: bool):
	isGunEnabled = enabled
	visible = isGunEnabled
