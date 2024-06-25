extends CharacterBody2D
class_name Player

@export var handgun: Gun
@export var shotgun: Gun
@export var snipergun: Gun
@export var jumpSpeed: int = 1200
@export var doubleJumpSpeed: int = 800
@export var fallSpeed: int = 15
@export var walkSpeed: int = 500
@export var doubleJumpEnabled: bool = false;
@export var pushForce: float = 0.5
var hasDoubleJumped: bool = false;
# facing right: 1, facing left: -1
var facingDirectionSign: int = 1

func _ready():
	handgun.toggleGun(true)
	shotgun.toggleGun(false)
	snipergun.toggleGun(false)

func _process(delta):
	if Input.is_action_just_pressed("PrimaryWeapon"):
		handgun.toggleGun(true)
		shotgun.toggleGun(false)
		snipergun.toggleGun(false)
	if Input.is_action_just_pressed("SecondaryWeapon"):
		handgun.toggleGun(false)
		shotgun.toggleGun(true)
		snipergun.toggleGun(false)
	if Input.is_action_just_pressed("TertiaryWeapon"):
		handgun.toggleGun(false)
		shotgun.toggleGun(false)
		snipergun.toggleGun(true)
	
	var mousePosition = get_global_mouse_position()	- global_position
	if mousePosition.x >= 0:
		# turn right
		# do not use scale.x, it translates to the following two statements
		scale.y = 1
		rotation_degrees = 0
		facingDirectionSign = 1
	else:
		# turn left		
		# do not use scale.x, it translates to the following two statements
		scale.y = -1
		rotation_degrees = 180
		facingDirectionSign = -1
	
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			hasDoubleJumped = false
			velocity.y = -1 * jumpSpeed
		elif !hasDoubleJumped && doubleJumpEnabled:
			hasDoubleJumped = true
			velocity.y = -1 * doubleJumpSpeed
	else:
		velocity.y += fallSpeed
		
	if Input.is_action_pressed("Left"):
		velocity.x = -1 * walkSpeed
		$AnimationPlayer.play("walk")
	elif Input.is_action_pressed("Right"):
		velocity.x = walkSpeed
		$AnimationPlayer.play("walk")
	else:
		velocity.x = 0
		$AnimationPlayer.play("idle")
		
	move_and_slide()
	
	# apply physics to sceleton parts
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is SceletonPart:
			c.get_collider().apply_central_impulse(-c.get_normal() * pushForce)
	
func receive_damage(damage):
	var healthManager = $HealthManager as HealthManager
	if healthManager != null:
		healthManager.receive_damage(self, damage)
	
func die():
	print("[Player] Player died.")
	get_tree().reload_current_scene()
