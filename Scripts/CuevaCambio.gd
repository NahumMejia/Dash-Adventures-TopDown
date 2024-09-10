extends Node

func _ready():
	pass  # Aquí puedes inicializar cualquier cosa si es necesario


func _on_body_entered(body):
	if body.get_name() == "playerFinal":
		get_tree().change_scene_to_file("res://Nivel2/nivel2.tscn")
		pass
