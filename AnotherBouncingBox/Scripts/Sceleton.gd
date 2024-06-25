extends CharacterBody2D
class_name Sceleton

@export var brokenSceleton: PackedScene
@export var fallSpeed: int
var wanderController: WanderController = null
var isDead: bool = false

func _ready():
	wanderController = $WanderController as WanderController
	if wanderController != null:
		wanderController.myBody = self
		
func _process(delta):
	# gravity
	velocity.y += fallSpeed
	
	if wanderController != null:
		if wanderController.isChasing == false:
			$AnimationPlayer.play("idle")
		else:
			$AnimationPlayer.play("walk")
		
		if velocity.x > 0:
			# walk right
			$Sprite2D.flip_h = false
		else:
			# walk left
			$Sprite2D.flip_h = true
		
	move_and_slide()

func damage_body(body):
	var damageManager = $DamageManager as DamageManager
	damageManager.apply_damage(body)
		
func receive_damage(damage):
	var healthManager = $HealthManager as HealthManager
	healthManager.receive_damage(self, damage)
	
func die():
	if !isDead:
		# animation
		queue_free()
		# remove collision?
		var brokenSceletonInstance: BrokenSceleton = brokenSceleton.instantiate() as BrokenSceleton
		if brokenSceletonInstance != null:
			get_tree().current_scene.add_child(brokenSceletonInstance)
			brokenSceletonInstance.global_position = global_position
			brokenSceletonInstance.set_velocity(velocity)
			brokenSceletonInstance.set_flip_h($Sprite2D.flip_h)
		isDead = true
