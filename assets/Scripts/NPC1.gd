extends Area2D

@export var interaction: Resource

func _ready() -> void:
	DialogBox.add_msg(interaction.msg_queue)
