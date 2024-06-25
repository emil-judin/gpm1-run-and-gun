extends Node
class_name HealthManager

@export var maxHealth: int = 6
@export var layout: Layout
var currentHealth : int

func _ready():
	currentHealth = maxHealth
	if layout != null:
		layout.playerHealthBar.max_value = maxHealth
		layout.playerHealthBar.value = maxHealth

func receive_damage(body, damage):
	currentHealth -= damage
	if layout != null:
		layout.playerHealthBar.value = currentHealth
	
	if currentHealth <= 0:
		body.die()
