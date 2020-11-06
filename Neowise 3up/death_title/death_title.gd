extends Sprite

# "clock" -> temporizador.
var clock = 0.1
# "time" -> tempo passado a cada frame em _physics_process.
var time = 0

func _ready():
	visible = false
	modulate.a = 0

func _physics_process(delta):
	if visible == true:
		time += delta
		
		if time > clock:
			if modulate.a != 1:
				modulate.a += 0.3
			time = 0
