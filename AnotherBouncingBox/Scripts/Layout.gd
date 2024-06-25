extends CanvasLayer
class_name Layout

static var gameStartTime = Time.get_ticks_msec()
@export var timeLabel: RichTextLabel
@export var playerHealthBar: ProgressBar

func _process(_delta):
	var currentTime = Time.get_ticks_msec() - gameStartTime
	timeLabel.text = get_time(currentTime)
	
static func reset_timer():
	gameStartTime = Time.get_ticks_msec()

static func get_time(ticksInMsec: int):
	var minutes = ticksInMsec / 1000 / 60
	var minutesOutput = str(minutes)
	var sec = ticksInMsec / 1000 % 60
	var secOutput = str(sec)
	var msec = ticksInMsec % 1000 / 10
	var msecOutput = str(msec)
	
	if minutes <= 9:
		minutesOutput = "0" + str(minutes)
		
	if sec <= 9:
		secOutput = "0" + str(sec)
		
	if msec <= 9:
		msecOutput = "0" + str(msec)
		
	return minutesOutput + ":" + secOutput + ":" + msecOutput
