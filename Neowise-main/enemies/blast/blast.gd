extends KinematicBody2D

# "clock" -> temporizador.
var clock = 6.0
# "time" -> tempo passado a cada frame em _physics_process.
var time = 0
var ladoEsquerdo = 350
var ladoDireito = 450
var flag = false

func _ready():
	$AnimatedSprite.play("default")

func _physics_process(delta):
	
	# Mover até o jogador
	$".".position.y += 0.3
	
	if flag == false:
		$".".position.x += 3
		
	if $".".position.x >= ladoDireito:
		flag = true
		
	if flag:
		$".".position.x -= 3
		
	if $".".position.x <= ladoEsquerdo:
		flag = false
	# Atirar
	# Mover até o jogador
	# Atirar
	# Sair da tela, destruir nó
	
	# Aumenta o valor de "time" por frame.
	time += delta
	
	# Gera uma "bullet" na tela e atualiza o valor de "time" para 0.
	if time > clock:
		# Carrega a cena "bullet".
		var bullet = load("res://enemies/blast/bullet/blast_bullet.tscn").instance()
		# "position_x", "position_y" -> Posição do "KinematicBody2D" de "player.tscn".
		var position_x = $AnimatedSprite.get_parent().position[0]
		var position_y = $AnimatedSprite.get_parent().position[1]
		
		# Altera a posição de "spawn" de "bullet", fazendo com que apareça 20 pixels na frente.
		bullet.global_position[0] = position_x + 0.6
		bullet.global_position[1] = position_y + 20
		
		# Adiciona a cena instanciada, "bullet", em "parent".
		get_parent().add_child(bullet)
		#toca som do tiro
		$Shoot.play()
		time = 0

# Signal, executado ao final de cada animação de "tank".
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		$AnimatedSprite.get_parent().queue_free()
