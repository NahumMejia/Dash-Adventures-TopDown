extends Area2D

@export var speed_increase: float = 1200.0 # Nueva velocidad al tocar el área (incrementada)
@export var boost_duration: float = 1.0 # Duración del aumento de velocidad en segundos

func _on_body_entered(body):
	if body is player:
		$"../spin".play()  # Reproduce el sonido de aumento
		body.increase_speed_for_duration(speed_increase, boost_duration)

