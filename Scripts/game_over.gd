extends Control
var change_scene = load("res://Nivel1/nivel1.tscn")
func _on_reintentar_btn_pressed():
	get_tree().change_scene_to_packed(change_scene)

func _on_salir_btn_pressed():
	get_tree().quit()


