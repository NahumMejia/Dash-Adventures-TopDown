extends Control

var coleccionables
var instrucciones
var pantalla_actual = 0

func _ready():
	# Inicializar los nodos
	coleccionables = get_node("ColeccionablesR")
	instrucciones = get_node("ControlesR")
	
	# Asegurarse de que solo la primera pantalla sea visible al inicio
	instrucciones.visible = true
	coleccionables.visible = false

func _input(event):
	if event.is_action_pressed("entrada"):
		if pantalla_actual == 0:
			# Primero, ocultar el menú de instrucciones y mostrar los coleccionables
			instrucciones.visible = false
			coleccionables.visible = true
			pantalla_actual += 1
		elif pantalla_actual == 1:
			# Si ya se ha mostrado la segunda pantalla, cerrar la escena
			queue_free()



