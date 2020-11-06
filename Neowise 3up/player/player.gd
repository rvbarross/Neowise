extends KinematicBody2D

# "speed" -> velocidade, em pixels, do jogador.
var speed = 250
# "direction" -> Direção em que o jogador vai se mexer.
var direction = Vector2()

# Carrega a cena em "player"
var black_hole = load("res://black_hole/black_hole.tscn").instance()
# "gravity" -> Força de atração do buraco negro.
var gravity = 100
var canShoot = false
var horizontal_axis = 0
var vertical_axis = 0



# Quando o nó "player" estiver sido carregado, a animação "default" é tocada.
func _ready():
	$AnimatedSprite.play("default")
	# Conecta com o socket.
	Socket.connect("sobe", self, "onSobe")
	Socket.connect("desce", self, "onDesce")
	Socket.connect("esquerda", self, "onEsquerda")
	Socket.connect("direita", self, "onDireita")
	Socket.connect("attack", self, "onAttack")
# Função executada a cada frame.
func _physics_process(delta):	
	# Instanceia "bullet.tscn" sempre que "shoot" for pressionado.
	if canShoot:
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
		canShoot = false
	
	# "horiontal_axis" -> Direção X que o jogador está se mexendo, entre 1 e -1.
	#var horizontal_axis = Input.get_action_strength("right") - Input.get_action_strength("left")
	if horizontal_axis != 0:
		direction.x = horizontal_axis * speed
	else:
		if position.x > black_hole.position.x:
			direction.x = -gravity
		elif position.x < black_hole.position.x:
			direction.x = gravity
	
	# "vertical_axis" -> Direção X que o jogador está se mexendo, entre 1 e -1.
	#var vertical_axis = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction.y = vertical_axis * speed if vertical_axis != 0 else gravity

	move_and_slide(direction)

	# Verifica se há colisão com o jogador.
	if get_slide_count():
		# Pega o primeiro colisor.
		var collider = get_slide_collision(get_slide_count() - 1).collider
		
		# Verifica se o grupo do colisor é "bullet", se sim, a animação de morte é tocada.
		if "bullet" in collider.get_groups() or "hole" in collider.get_groups():
			$AnimatedSprite.play("death")
			

# Remove "player.tscn" de "main.tscn" quando a animação "death" termina.
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		# Toca o som de morte.
		$Death.play()
		$AnimatedSprite.visible = false
		get_parent().get_node("Death_Title").visible = true


func _on_Death_finished():
	$AnimatedSprite.get_parent().queue_free()

func onSobe(player):
	print("chamando função de subir")
	vertical_axis = -1
func onDesce(player):
	print("chamando função de descer")
	vertical_axis = 1
func onEsquerda(player):
	print("chamando função de esquerda")
	horizontal_axis = -1
func onDireita(player):
	print("chamando função de direita")
	horizontal_axis = 1
func onAttack(player):
	print("chamando função de atack")
	canShoot = true
	
	
	
	
	
	
	
	
