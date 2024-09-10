extends CharacterBody2D
class_name playerr

@export var invulnerability_time: float = 2.0 # Tiempo de invulnerabilidad en segundos
@onready var sprite = $D2VistaAerea
@onready var invulnerability_timer = $InvulnerabilityTimer
@onready var death_animation_timer = $DeathAnimationTimer

var invulnerable: bool = false
var is_dead: bool = false # Nueva variable para controlar si el jugador está en la animación de muerte

@export var speed: float = 300.0
@export var forward_speed: float = 600.0
@export var reverse_speed: float = 200.0
@export var drift_factor: float = 0.1
@export var acceleration: float = 6.0
@export var max_steer_angle: float = 10.0
@export var steering_sensitivity: float = 0.1
@export var turn_speed: float = 0.2
@onready var monedasLabel = $PlayerGUI/Monedas/MonedasLabel
@onready var collision_shape = $CollisionShape2D

var current_velocity: Vector2 = Vector2.ZERO
var steering_angle: float = 0.0
var target_angle: float = 0.0
var lifes = 3
var corazon1
var corazon2
var corazon3
var original_speed: float = 600.0 # Velocidad original para restaurarla después del aumento
var speed_boost_time: float = 0.0 # Tiempo restante de la mejora de velocidad

func _ready():
	Global.Playerr = self
	self.name = "playerFinal"
	corazon1 = get_node("PlayerGUI/Vidas/Vida1")
	corazon2 = get_node("PlayerGUI/Vidas/Vida2")
	corazon3 = get_node("PlayerGUI/Vidas/Vida3")
	
	# Configuración del temporizador de invulnerabilidad
	if invulnerability_timer:
		invulnerability_timer.connect("timeout", Callable(self, "_on_invulnerability_timeout"))
	else:
		print("InvulnerabilityTimer no está instanciado.")
	
	# Configuración del temporizador de animación de muerte
	if death_animation_timer:
		death_animation_timer.wait_time = 3.0
		death_animation_timer.one_shot = true
		death_animation_timer.connect("timeout", Callable(self, "_on_death_animation_timeout"))
	else:
		print("DeathAnimationTimer no está instanciado.")

func _process(_delta: float) -> void:
	# Si el jugador está en la animación de muerte, no se mueve
	if is_dead:
		return

	# Reducir el tiempo restante de la mejora de velocidad
	if speed_boost_time > 0:
		speed_boost_time -= _delta
		if speed_boost_time <= 0:
			# Restaurar la velocidad original
			forward_speed = original_speed

	var input_direction = Vector2.ZERO
	
	# Captura la entrada del teclado
	if Input.is_action_pressed("move_up"):
		input_direction.y -= 1.0
	if Input.is_action_pressed("move_down"):
		input_direction.y += 1.0
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1.0
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1.0

	# Normaliza la dirección para evitar movimiento diagonal más rápido
	input_direction = input_direction.normalized()

	# Calcula el ángulo objetivo basado en la entrada horizontal
	if input_direction.x != 0:
		target_angle = clamp(input_direction.x * max_steer_angle, -max_steer_angle, max_steer_angle)
	else:
		# Suaviza la transición de giro hacia la dirección recta
		target_angle = lerp(steering_angle, 0.0, steering_sensitivity * _delta)

	# Ajusta la rotación del carro con una velocidad de giro para control más suave
	steering_angle = lerp(steering_angle, target_angle, turn_speed * _delta)

	# Aplica el ángulo de giro al sprite del carro
	rotation = steering_angle

	# Calcula la dirección del movimiento basada en el ángulo de rotación
	var movement_direction = Vector2(0, -1).rotated(rotation)
	
	# Determina la velocidad objetivo en función de la entrada de retroceso y avance
	var target_velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		target_velocity = movement_direction * -reverse_speed
	elif Input.is_action_pressed("move_up"):
		target_velocity = movement_direction * forward_speed
	
	# Suaviza el cambio de velocidad hacia la velocidad objetivo con aceleración
	if input_direction.length() > 0 or Input.is_action_pressed("move_down"):
		current_velocity = current_velocity.lerp(target_velocity, acceleration * _delta)
	else:
		# Aplica un factor de derrape para suavizar la detención
		current_velocity = current_velocity.lerp(Vector2.ZERO, drift_factor * _delta)
	
	# Actualiza la dirección del carro
	velocity = current_velocity
	move_and_slide()

# Función que aumenta la velocidad del jugador
func increase_speed_for_duration(new_speed: float, duration: float) -> void:
	original_speed = forward_speed
	forward_speed = new_speed
	speed_boost_time = duration

func actualizaInterfazMonedas():
	monedasLabel.text = str(Global.monedas)

func _loseLife():
	if invulnerable or is_dead:
		return
	lifes -= 1
	
	if lifes > 0:		
		_start_invulnerability()
	
	if lifes == 2:
		corazon3.visible = false
	elif lifes == 1:
		corazon2.visible = false
	elif lifes == 0:
		Global.monedas = 0 # Reiniciar monedas
		actualizaInterfazMonedas()
		corazon1.visible = false
		$D2VistaAerea.visible = false
		$MuerteAnimacion.visible = true
		is_dead = true
		
		if death_animation_timer:
			death_animation_timer.start()
		else:
			print("DeathAnimationTimer no está instanciado.")

func _on_death_animation_timeout() -> void:
	_change_to_game_over_scene()

func _change_to_game_over_scene():
	get_tree().change_scene_to_file("res://Nivel2/game_overNivel2.tscn")

func _start_invulnerability() -> void:
	if not is_instance_valid(self):
		return
	invulnerable = true
	sprite.modulate.a = 0.5 # Hacer semitransparente al jugador para indicar invulnerabilidad

	if invulnerability_timer.is_inside_tree():
		invulnerability_timer.wait_time = invulnerability_time
		invulnerability_timer.start()
	else:
		print("El temporizador de invulnerabilidad no está dentro del SceneTree.")

func _on_invulnerability_timeout() -> void:
	sprite.modulate.a = 1.0
	invulnerable = false
