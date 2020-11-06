extends Control

# Executa a animação "MenuFadeIn" quando a cena é carregada.
func _ready():
	Socket.connect_to_server()
	$AnimationPlayer.play("MenuFadeIn")




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "MenuFadeIn":
		$ColorRect.visible = false


func _on_Play_pressed():

	get_tree().change_scene("res://game.tscn")


func _on_Options_pressed():
	pass # Replace with function body.


# Quando o botão "Exit" é pressionado, a aplicação termina.
func _on_Exit_pressed():
	get_tree().quit()
