extends KinematicBody2D

# "speed" -> velocidade da bala, em pixels.
var speed = 300
# "direction" -> Direção em que a bala vai se mexer.
var direction = Vector2()

# Colisor "enemy"
var enemy = null

# Função executada a cada frame.
func _physics_process(delta):
	direction.y -= speed
	
	move_and_slide(direction)
	
	# Verifica por colisores.
	if get_slide_count():
		# Pega o primeiro colisor.
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Verifica os colisores de "collider".
		if "tank" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("tank")
		elif "blast" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("blast")
		elif "fast" in collider.get_groups():
			enemy = get_tree().get_nodes_in_group("fast")
		
		# Verifica se exite "enemy".
		if enemy:
			# Toca a animação de morte do inimigo e remove o inimigo da tela.
			enemy[0].get_node("AnimatedSprite").play("death")
			# Toca o som de morte.
			enemy[0].get_node("Death").play()
			
		# Remove "bullet" da tela.
		queue_free()
		
	direction.y = 0
