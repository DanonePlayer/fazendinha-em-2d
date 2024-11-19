extends CanvasModulate

var MINUTES_PER_DAY = 1440
var MINUTES_PER_HOUR = 60
var INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minutes:int)

@export var gradiant:GradientTexture1D
var time:float = 0.0
var past_minute:float = -1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradiant.gradient.sample(value)
	
	_recalculate_time()

func _recalculate_time() -> void:
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	var day = int (total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)
	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
