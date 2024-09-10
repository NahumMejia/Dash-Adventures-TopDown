extends Control

var change_scene = load("res://Nivel1/loading_screenNivel1.tscn")
func _on_button_pressed():
	get_tree().change_scene_to_packed(change_scene)
