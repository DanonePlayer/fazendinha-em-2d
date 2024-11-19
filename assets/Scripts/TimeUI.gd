extends CanvasLayer

@onready var day_label: Label = $DayLabel
@onready var time_label: Label = $TimeLabel

func _ready():
	# Conecta ao sinal de tempo do TimeManager
	var time_manager = get_node("/root/Principal/TimeManager")
	time_manager.connect("time_updated", Callable(self, "_update_time_ui"))

func _update_time_ui(day: int, hour: int, minute: int):
	day_label.text = "Dia " + str(day + 1)
	time_label.text = str(_format_hour(hour)) + ":" + str(_format_minute(minute)) + " " + _am_pm(hour)

func _format_hour(hour: int) -> String:
	if hour < 10:
		return "0" + str(hour)
	return str(hour)

func _format_minute(minute: int) -> String:
	if minute < 10:
		return "0" + str(minute)
	return str(minute)

func _am_pm(hour: int) -> String:
	return "AM" if hour < 12 else "PM"
