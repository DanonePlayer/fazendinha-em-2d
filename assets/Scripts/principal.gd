extends Node2D
var cena_milho = preload("res://assets/Cenas/milho.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Fazendeira.connect("posicao_terra", Callable(self, "_plantar_milho"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#if Input.is_action_just_released("ui_accept"):
		#var instancia = cena_milho.instantiate()
		#instancia.position = $Fazendeira.position
		#add_child(instancia)

func _plantar_milho(position):
	var instancia = cena_milho.instantiate()
	instancia.position = position  # Posiciona o milho exatamente onde foi indicado
	add_child(instancia)
