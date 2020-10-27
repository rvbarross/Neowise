extends Control


func _ready():
	pass 

#START
func _on_start_mouse_entered():
	$start.modulate.r = 0.7
	$start.modulate.g = 0.7
	$start.modulate.b = 0.7


func _on_start_mouse_exited():
	$start.modulate.r = 1.0
	$start.modulate.g = 1.0
	$start.modulate.b = 1.0


func _on_start_pressed():
	pass #get_tree().change_scene("nome da cena aqui")

#OPTIONS
func _on_option_mouse_entered():
	$start.modulate.r = 0.7
	$start.modulate.g = 0.7
	$start.modulate.b = 0.7


func _on_option_mouse_exited():
	$start.modulate.r = 1.0
	$start.modulate.g = 1.0
	$start.modulate.b = 1.0


func _on_option_pressed():
	pass #get_tree().change_scene("nome da cena aqui")

#EXIT
func _on_exit_mouse_entered():
	$start.modulate.r = 0.7
	$start.modulate.g = 0.7
	$start.modulate.b = 0.7

func _on_exit_mouse_exited():
	$start.modulate.r = 1.0
	$start.modulate.g = 1.0
	$start.modulate.b = 1.0


func _on_exit_pressed():
	pass #get_tree().change_scene("nome da cena aqui")
