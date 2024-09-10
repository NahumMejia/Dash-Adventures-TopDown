extends Area2D

func _on_body_entered(body):
	if body is player:
		$"../tomado".play()
		Global.monedas += 1
		print(Global.monedas)
		queue_free()
