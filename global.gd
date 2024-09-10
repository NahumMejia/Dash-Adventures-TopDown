extends Node
var Player
var monedas := 0:
	set(val):
		monedas = val
		if Player != null:
			Player.actualizaInterfazMonedas()
	get:
		return monedas
