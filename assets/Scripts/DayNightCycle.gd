extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func _ready():
	color_rect.visible = true
	var time_manager = get_node("/root/Principal/TimeManager")
	time_manager.connect("time_updated", Callable(self, "_update_day_night"))

func _update_day_night(_day: int, hour: int, minute: int):
	var time_factor = hour + (minute / 60.0)  # Hora exata em formato decimal

	if time_factor >= 17.0 and time_factor < 24.0:  # Noite começa após 17h
		var alpha = (time_factor - 17.0) / 7.0  # Gradualmente escurece (17:00-24:00)
		color_rect.modulate = Color(0, 0, 0, clamp(alpha, 0, 0.8)) # Escurece até 80%
		
	elif time_factor >= 0.0 and time_factor < 7.0:  # Amanhecer entre 00:00 e 07:00
		var alpha = 1.0 - (time_factor / 7.0)  # Gradualmente clareia (00:00-07:00)
		color_rect.modulate = Color(0, 0, 0, clamp(alpha, 0, 0.8)) # Escurece até 80%
		
	else:  # Durante o dia (07:00 às 17:00)
		color_rect.modulate = Color(0, 0, 0, 0)  # Totalmente transparente
		
