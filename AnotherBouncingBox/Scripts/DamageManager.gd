extends Node
class_name DamageManager

@export var damage: int

func apply_damage(body):
	if body is Player:
		# receive damage
		var player = body as Player
		player.receive_damage(damage)
		pass
	
	# else: do nothing
