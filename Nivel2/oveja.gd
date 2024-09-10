extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body.get_name() == "playerFinal":
		if not body.is_dead: # Verificar si el jugador no está en estado de muerte
			$Area2D/damage.play()
			$Area2D/oveja.play()
			body._loseLife()
