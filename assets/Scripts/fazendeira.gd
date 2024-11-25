extends CharacterBody2D

@onready var tilemap_layer = $"../Cenario/TileMapLayer"  # Referência ao TileMapLayer
@onready var shadow = $"../Cenario/Shadow" # Referência ao Sprite da sombra
var cena_milho = preload("res://assets/Cenas/milho.tscn")
var contruir = false  # modo construcao

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

signal posicao_terra(position: Vector2)  # Sinal para transmitir a posição selecionada

func _ready() -> void:
	shadow.visible = false  # Inicialmente a sombra está invisível
	animacoes_cenario()
	
func animacoes_cenario():
	$"../Borboleta/AnimationPlayer".play("Voando")
	$"../Borboleta/AnimatedSprite2D".play("Borboleta")
	$"../Cenario/Flutuante".play("agua")
	$"../Cenario/Flutuante2".play("agua")
	$"../Cenario/Pedra_Flutua".play("Pedra_agua")
	$"../Cenario/Pedra_Flutua2".play("Pedra_agua")
	$"../Cenario/Planta_Flutua".play("Planta_agua")
	$"../Cenario/Planta_Flutua2".play("Planta_agua")
	$"../Cenario/Rio/canto_es_rio".play("default")
	$"../Cenario/Rio/canto_dir_rio".play("default")
	
	$"../Cenario/Rio/canto_rio".play("canto_rio")
	$"../Cenario/Rio/canto_rio2".play("canto_rio")
	$"../Cenario/Rio/canto_rio3".play("canto_rio")
	$"../Cenario/Rio/canto_rio4".play("canto_rio")
	$"../Cenario/Rio/canto_rio5".play("canto_rio")
	$"../Cenario/Rio/canto_rio6".play("canto_rio")
	$"../Cenario/Rio/canto_rio7".play("canto_rio")
	$"../Cenario/Rio/canto_rio8".play("canto_rio")
	$"../Cenario/Rio/canto_rio9".play("canto_rio")
	
func _physics_process(_delta: float) -> void:
	moviment_person()
	construcao_metod()
	
func moviment_person():
	var direction = Input.get_vector("esquerda", "direita", "Up", "Down")
	if direction:
		direction = direction.normalized()
		velocity = (direction * SPEED)
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		$AnimatedSprite2D.play("Idle")
	move_and_slide()
	
	if Input.is_action_just_pressed("Up") and direction.x == 0:
		$AnimatedSprite2D.play("Walk_up")
	if Input.is_action_just_pressed("esquerda") or Input.is_action_just_pressed("direita"):
		$AnimatedSprite2D.play("Walk")
	if Input.is_action_just_released("esquerda") or Input.is_action_just_released("direita"):
		$AnimatedSprite2D.play("Walk")
	
func construcao_metod():
	if Input.is_action_just_pressed("construcao"):
		contruir = !contruir
	if contruir == true:
		# Calcula a posição da célula com base na posição do mouse
		var mouse_position = get_global_mouse_position()
		var cell_position = tilemap_layer.local_to_map(tilemap_layer.to_local(mouse_position))  # Usa local_to_map para alinhar ao grid
		var shadow_position = tilemap_layer.map_to_local(cell_position)  # Converte de grid para posição local
		shadow.position = shadow_position  # Ajusta a posição da sombra
		shadow.visible = true  # Mostra a sombra

		# Colocar o item no grid ao pressionar o botão
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("posicao_terra", shadow_position)  # Emite a posição da sombra
	else:
		shadow.visible = false  # Esconde a sombra
