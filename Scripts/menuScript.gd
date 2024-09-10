extends Control
var change_scene = load("res://Nivel3/INICIO.tscn")

func _on_jugar_btn_pressed():
	get_tree().change_scene_to_packed(change_scene)

func _on_salir_btn_pressed():
	get_tree().quit()
