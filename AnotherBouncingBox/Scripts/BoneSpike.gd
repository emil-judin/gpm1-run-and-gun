extends Node2D

@export var boneSpike: Node2D
@export var targetPositionY: float = -16
@export var extendTime: float = 5
@export var retractTime: float = 1
var time: float = 0
var extending: bool = false
var retracting: bool = false

func _process(delta):
	if extending:
		if time < extendTime:
			time += delta
			boneSpike.position.y = lerp(0.0, targetPositionY, time / extendTime)
		else:
			time = 0
			extending = false
			retracting = true
		
	if retracting:
		if time < retractTime:
			time += delta
			boneSpike.position.y = lerp(targetPositionY, 0.0, time / retractTime)
		else:
			time = 0
			extending = false
			retracting = false

func body_entered(body):
	if body is Player && !extending && !retracting:
		extending = true
