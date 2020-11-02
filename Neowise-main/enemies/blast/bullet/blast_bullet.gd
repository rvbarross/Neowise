extends KinematicBody2D

# "speed" -> velocidade da bala, em pixels.
var speed = 200
# "direction" -> Direção em que a bala vai se mexer.
var direction = Vector2()

# Colisor "player"
var player = null

# Função executada a cada frame.
func _physics_process(delta):
	direction.y += speed
	
	move_and_slide(direction)
	
	# Verifica por colisores.
	if get_slide_count():
		# Pega o primeiro colisor.
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		if "player" in collider.get_groups():
			# Toca a animação de morte do inimigo e remove o inimigo da tela.
			player = get_tree().get_nodes_in_group("player")
			player[0].get_node("AnimatedSprite").play("death")
			
		# Remove "bullet" da tela.
		queue_free()
		
	direction.y = 0
