extends KinematicBody2D

# "speed" -> velocidade, em pixels, do jogador.
var speed = 250
# "direction" -> Direção em que o jogador vai se mexer.
var direction = Vector2()

# Carrega a cena em "player"
var black_hole = load("res://black_hole/black_hole.tscn").instance()
# "gravity" -> Força de atração do buraco negro.
var gravity = 100

# Quando o nó "player" estiver sido carregado, a animação "default" é tocada.
func _ready():
	$AnimatedSprite.play("default")

# Função executada a cada frame.
func _physics_process(delta):	
	# Instanceia "bullet.tscn" sempre que "shoot" for pressionado.
	if Input.is_action_just_pressed("shoot"):
		# Carrega a cena "bullet".
		var bullet = load("res://player/bullet/bullet.tscn").instance()
		# "position_x", "position_y" -> Posição do "KinematicBody2D" de "player.tscn".
		var position_x = $AnimatedSprite.get_parent().position[0]
		var position_y = $AnimatedSprite.get_parent().position[1]
		
		# Altera a posição de "spawn" de "bullet", fazendo com que apareça 40 pixels a frente do jogador.
		bullet.global_position[0] = position_x + 0.6
		bullet.global_position[1] = position_y - 30
		
		# Adiciona a cena instanciada, "bullet", em "parent".
		get_parent().add_child(bullet)
		# Toca o som do tiro.
		$Shoot.play()
	
	# "horiontal_axis" -> Direção X que o jogador está se mexendo, entre 1 e -1.
	var horizontal_axis = Input.get_action_strength("right") - Input.get_action_strength("left")
	if horizontal_axis != 0:
		direction.x = horizontal_axis * speed
	else:
		if position.x > black_hole.position.x:
			direction.x = -gravity
		elif position.x < black_hole.position.x:
			direction.x = gravity
	
	# "vertical_axis" -> Direção X que o jogador está se mexendo, entre 1 e -1.
	var vertical_axis = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.y = vertical_axis * speed if vertical_axis != 0 else gravity

	move_and_slide(direction)

	# Verifica se há colisão com o jogador.
	if get_slide_count():
		# Pega o primeiro colisor.
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Verifica se o grupo do colisor é "bullet", se sim, a animação de morte é tocada.
		if "bullet" in collider.get_groups() or "hole" in collider.get_groups():
			$AnimatedSprite.play("death")
			# Toca o som de morte.
			$Death.play()

# Remove "player.tscn" de "main.tscn" quando a animação "death" termina.
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		$AnimatedSprite.get_parent().queue_free()
		get_parent().get_node("Death_Title").visible = true
