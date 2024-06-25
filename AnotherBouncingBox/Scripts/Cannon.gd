extends Node2D

@export var cannonBall: PackedScene
@export var firingOffset: float = -32
@export var cooldown: float = 10
var cooldownStart: float
var direction: Vector2

signal cannon_fired

func _process(delta):
	if Time.get_unix_time_from_system() - cooldownStart > cooldown:
		cooldownStart = Time.get_unix_time_from_system()
		var cannonBallInstance: CannonBall = cannonBall.instantiate() as CannonBall
		if cannonBallInstance != null:
			var directionVector = Vector2.from_angle(rotation)

			cannonBallInstance.global_position = global_position + firingOffset * directionVector.normalized()
			cannonBallInstance.direction = directionVector
			get_tree().current_scene.add_child(cannonBallInstance)
			cannon_fired.emit()
