extends RigidBody2D
class_name Bullet

@export var speed = 750
@export var damage = 1
var maxLifeTime: float = 5
var timer = 0
var direction: Vector2

func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	linear_velocity = direction * speed
	rotation = direction.angle()
	
func _process(delta):
	timer += delta
	if timer > maxLifeTime:
		remove_bullet(null)

func damageBody(body):
	print("[bullet hit] " + body.name)
	
	if body is Player:
		# bullet hit player: do nothing
		return
	if body is Bullet:
		# bullet hit bullet: should not happen, but do nothing
		return
	if body is Sceleton:
		# bullet hit enemy: apply damage, despawn
		var sceleton = body as Sceleton
		sceleton.receive_damage(damage)
	if body is SceletonBird:
		var sceletonBird = body as SceletonBird
		sceletonBird.receive_damage(damage)
	if body is SceletonPart:
		var sceletonPart = body as SceletonPart
		sceletonPart.receive_damage(damage)

func remove_bullet(body):
	queue_free()
