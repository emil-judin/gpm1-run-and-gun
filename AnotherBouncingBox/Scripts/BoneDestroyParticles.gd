extends CPUParticles2D
var endTime: float

func _ready():
	emitting = true
	endTime = Time.get_unix_time_from_system() + lifetime

func _process(delta):
	if Time.get_unix_time_from_system() > endTime:
		# particle animation finished: delete particle system
		queue_free()
