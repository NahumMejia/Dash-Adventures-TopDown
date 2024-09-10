extends Node2D

@export var lifes: int = 3
@onready var animation_player = $MuerteAnimacion/AnimationPlayer # Asegúrate de que este es el nodo AnimationPlayer que tienes en tu escena

func _ready():
	# Conectar la señal "animation_finished" del AnimationPlayer para saber cuándo termina la animación
	if animation_player:
		animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	else:
		print("AnimationPlayer no está instanciado.")

func _process(delta):
	if lifes == 0:
		# Reproduce la animación de "Game Over"
		if animation_player and !animation_player.is_playing():
			animation_player.play("game_over_animation") # Nombre de la animación que has creado

func _on_animation_finished(anim_name: String):
	# Verifica si la animación terminada es la de "game_over_animation"
	if anim_name == "game_over_animation":
		# Cambia de escena después de que la animación haya terminado
		get_tree().change_scene_to_file("res://Nivel1/game_overNivel1.tscn")
