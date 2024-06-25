extends Node

@export var bombTimer: float = 3
var triggered: bool = false
var timer: float = 0

func _process(delta):
	$AnimationPlayer.play("idle")
		
	if triggered:
		timer += delta
		if timer >= bombTimer:
			detonate()
		
func detonate():
	queue_free()
	for body in $PlayerDetectionZone.get_overlapping_bodies():
		if body is Player:
			$DamageManager.apply_damage(body)

func body_entered_detection_zone(body):
	if body is Player:
		triggered = true
