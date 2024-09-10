extends Control

@onready var anime = $AnimationPlayer
@onready var tiempo = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	anime.play()
	tiempo.start()
	pass

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Nivel1/nivel1.tscn")
	pass # Replace with function body.
