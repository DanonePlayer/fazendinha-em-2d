extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var tempo = Time.get_datetime_dict_from_system()
	
	var hora = "%02d"% tempo.hour
	var minutos = "%02d"% tempo.minute
	var segundos = "%02d"%  tempo.second
	
	text = str(hora, ":", minutos, ".", segundos)
