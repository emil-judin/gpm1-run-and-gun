extends RigidBody2D
class_name CannonBall

@export var speed: float
@export var damage: float
var direction: Vector2

func _ready():
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	linear_velocity = -direction * speed

func damageBody(body):
	print("[cannonball hit] " + body.name)
	
	if body is Player:
		var player = body as Player
		body.receive_damage(damage)
		return
	if body is Sceleton:
		var sceleton = body as Sceleton
		sceleton.receive_damage(damage)
	if body is SceletonBird:
		var sceletonBird = body as SceletonBird
		sceletonBird.receive_damage(damage)
	if body is SceletonPart:
		var sceletonPart = body as SceletonPart
		sceletonPart.receive_damage(damage)
	if body is TileMap:
		queue_free()
