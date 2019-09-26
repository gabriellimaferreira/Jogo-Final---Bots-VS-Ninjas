extends Area2D

func _ready():
	pass

var movTiro = Vector2(0,0)
func _physics_process(delta):
	movTiro.x = -20
	translate(movTiro)

func _on_tirol_body_entered(body):
	if "inimigo" in body.name:
		body.morrer()
		queue_free()
