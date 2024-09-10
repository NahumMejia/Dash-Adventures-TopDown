extends Node2D

func _on_body_entered(body):
	if body.get_name() == "playerFinal":
		get_tree().change_scene_to_file("res://Nivel3/nivel3.tscn")
		pass
