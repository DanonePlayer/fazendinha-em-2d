extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$"../CanvasLayer/Semente_Tomate".text =  str(dadosGlobal.semente)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		dadosGlobal.semente+=1
