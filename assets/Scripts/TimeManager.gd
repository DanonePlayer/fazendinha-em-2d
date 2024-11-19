extends Node

# Tempo em minutos
var minute = 0
var hour = 6  # Começa às 6h da manhã
var day = 0

# Configuração de velocidade do tempo
const DAY_DURATION = 3600.0  # Duração total de um dia em segundos
const TOTAL_MINUTES = 24 * 60  # Total de minutos em um dia
var minute_duration = DAY_DURATION / TOTAL_MINUTES  # Duração de cada minuto

signal time_updated(day: int, hour: int, minute: int)

func _ready():
	print(time_updated)
	emit_signal("time_updated", day, hour, minute)
	# Configura o temporizador para simular o tempo
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(minute_duration)  # Define o tempo para cada "minuto"
	timer.set_one_shot(false)
	timer.connect("timeout", Callable(self, "_update_time"))
	timer.start()

func _update_time():
	minute += 1
	if minute >= 60:
		minute = 0
		hour += 1
	if hour >= 24:
		hour = 0
		day += 1
	emit_signal("time_updated", day, hour, minute)
