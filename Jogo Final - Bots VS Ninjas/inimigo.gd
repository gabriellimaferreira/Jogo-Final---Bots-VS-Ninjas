extends KinematicBody2D

var inicio
var fim
var distancia = 200
var direcao = "direita"

func _ready():
	inicio = position.x
	fim = inicio + distancia

func _process(delta):
	if direcao == "direita" and position.x < fim:
		$asprite.flip_h = false
		$asprite.play("run")
		position.x += 5                           # Movimento para a direita
	else:
		direcao = "esquerda"
		
	if direcao == "esquerda" and position.x > inicio:
		$asprite.flip_h = true
		$asprite.play("run")
		position.x -= 5                             # Movimento para a esquerda
	else:
		direcao = "direita"

func morrer():
	queue_free()
