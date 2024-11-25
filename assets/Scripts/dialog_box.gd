extends NinePatchRect

@onready var text := $Text
@onready var timer := $Timer

var msg_queue: Array = []

func _input(event):
	if event is InputEventKey and event.is_action_pressed("interagir"):
		show_msg()
		
func add_msg(_msg: Array):
	if msg_queue.size() == 0:
		show()
	msg_queue.append_array(_msg)
	show_msg()
	print("aqui")


func show_msg() -> void:
	if not timer.is_stopped():
		text.visible_characters = text.get_total_character_count()
		return
		
	if msg_queue.size() == 0:
		hide()
		return
		
	var _msg: String = msg_queue.pop_front()
	text.visible_characters = 0
	text.bbcode_text = _msg
	timer.start()


func _on_timer_timeout() -> void:
	if text.visible_characters == text.get_total_character_count():
		timer.stop()
	text.visible_characters +=1
