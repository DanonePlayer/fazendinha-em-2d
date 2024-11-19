extends Area2D

var tocouNoColider = false
var espacoCheio = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"../CanvasLayer/Semente_Tomate".text =  str(Dados.semente)
	
	if tocouNoColider and Input.is_action_just_pressed("ui_accept"):
		if Dados.semente >= 1 and espacoCheio == false:
			Dados.semente -= 1
			espacoCheio = true
			show()
			$AnimatedSprite2D.frame = 0
			await get_tree().create_timer(4.0).timeout
			$AnimatedSprite2D.frame = 2
			await get_tree().create_timer(8.0).timeout
			$AnimatedSprite2D.frame = 3
			await get_tree().create_timer(16.0).timeout
			$AnimatedSprite2D.frame = 4
			await get_tree().create_timer(32.0).timeout
			$AnimatedSprite2D.frame = 5
			espacoCheio = false


func _on_body_entered(_body: Node2D) -> void:
	tocouNoColider = true

func _on_body_exited(_body: Node2D) -> void:
	tocouNoColider = false
