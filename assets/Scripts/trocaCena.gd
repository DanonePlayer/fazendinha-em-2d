extends Area2D

@export var caminho = ""


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print("entrou")
		get_tree().change_scene_to_file.bind(caminho).call_deferred()
