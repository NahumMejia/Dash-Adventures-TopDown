extends Node2D
var change_scene = load("res://Nivel3/end.tscn")
func _on_area_2d_body_entered(body):
	if body.get_name() == "playerFinal":
		if not body.is_dead: # Verificar si el jugador no está en estado de muerte
			get_tree().change_scene_to_packed(change_scene)
