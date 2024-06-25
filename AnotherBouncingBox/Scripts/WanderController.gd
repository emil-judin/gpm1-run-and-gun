extends Node
class_name WanderController

# stand
# player entered detection zone?
# walk to player
@export var chaseSpeed: int = 100
@export var jumpSpeed: int = 10
var isChasing: bool = false
var stuckTimer: float = 0.1
var stuckDistance: float = 2
var lastStuckPosition: Vector2
var player: Player = null
var myBody: CharacterBody2D
var timer: float

func body_entered_detection_zone(body):
	if body is Player:
		# set player
		player = body as Player
		isChasing = true
	
func _process(delta):
	# chasing
	if isChasing:
		timer += delta
		
		if timer > stuckTimer:
			timer = 0
			var distance = (myBody.global_position - lastStuckPosition).length()
			lastStuckPosition = myBody.global_position
			# test if stuck
			if myBody.is_on_floor() && distance <= stuckDistance:
				# body is stuck: jump
				myBody.velocity.y = -1 * jumpSpeed
				myBody.move_and_slide()
				return

		myBody.velocity.x = chaseSpeed * sign(player.global_position.x - myBody.global_position.x)
		myBody.move_and_slide()
