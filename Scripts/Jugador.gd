extends CharacterBody2D

# Variables para el movimiento del jugador
var lanes = [Vector2(100, 400), Vector2(300, 400), Vector2(500, 400)]
var current_lane = 1
@export var speed = 200

# Función para manejar la entrada del jugador
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		if current_lane > 0:
			current_lane -= 1
	elif event.is_action_pressed("ui_right"):
		if current_lane < lanes.size() - 1:
			current_lane += 1

# Función para actualizar la posición del jugador
func _process(delta: float) -> void:
	var target_position = lanes[current_lane]
	position = position.lerp(target_position, speed * delta)

