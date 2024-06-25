extends CharacterBody2D
class_name SceletonBird

@export var flightTime: float
@export var position1: Vector2
@export var position2: Vector2
var target: Vector2
var time: float = 0
var distance: float

func _ready():
	# start with position 1
	global_position = position1
	target = position2
	distance = (position2 - position1).length()

func _process(delta):
	$AnimationPlayer.play("idle")
	
	$Sprite2D.flip_h = (target.x - global_position.x > 0)
	
	if target == position1:
		if time < flightTime:
			time += delta
			global_position = lerp(position2, position1, time / flightTime)
		else:
			time = 0
			target = position2
		
	if target == position2:
		if time < flightTime:
			time += delta
			global_position = lerp(position1, position2, time / flightTime)
		else:
			time = 0
			target = position1
		
	move_and_slide()

func receive_damage(damage):
	$HealthManager.receive_damage(self, damage)

func die():
	# TODO: broken sceleton bird
	queue_free()
