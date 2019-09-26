extends KinematicBody2D

func _ready():
	pass

const gravidade = 30
var dano = -200
const velocidade = 800
const pulo_acima = -800
const TIROR = preload("res://tiror.tscn")
const TIROL = preload("res://tirol.tscn")
const quant_pulo = 1
var pulo = 2
var vida = 3
var movimento = Vector2(0,0)

func _physics_process(delta):
	movimento.y += gravidade					# Efeito de gravidade
	
	if Input.is_action_just_pressed("ui_up"):
		if pulo >= 1:
			movimento.y = pulo_acima				# Movimento de pulo
			pulo = pulo - 1
	
	if is_on_floor():
		pulo = quant_pulo
			
		
	if Input.is_action_pressed("ui_right"):
		movimento.x = velocidade
		$asprite.flip_h = false
		if Input.is_action_pressed('ui_up'):	# Movimento à direita e sprites possíveis
			$asprite.play("jump")
		if Input.is_action_pressed('espaco'):
			$asprite.play("runshot")
			$corrida.play()
		else:
			$asprite.play("run")
			$corrida.play()
		
	elif Input.is_action_pressed("ui_left"):
		movimento.x = -velocidade
		$asprite.flip_h = true
		if Input.is_action_pressed('ui_up'):	# Movimento à esquerda e sprites possíveis
			$asprite.play("jump")
		if Input.is_action_pressed('espaco'):
			$asprite.play("runshot")
			$corrida.play()
		else:
			$asprite.play("run")
			$corrida.play()
		
	elif Input.is_action_pressed('ui_up') or not is_on_floor():
		movimento.x = 0
		$asprite.play("jump")
	elif (Input.is_action_pressed("control")):
		$asprite.play("melee")
	else:
		if is_on_floor():										# Movimento nulo e sprites possíveis
			movimento.x = 0
			$asprite.play("idle")
				
	if Input.is_action_just_pressed("espaco"):
		
		if $asprite.flip_h == false:
			var t = TIROR.instance()
			get_parent().add_child(t)
			t.position = $Position2DR.global_position
		elif $asprite.flip_h == true:			# Tiro e inversão de sprites
			var t = TIROL.instance()
			get_parent().add_child(t)
			t.position = $Position2DL.global_position
		
	if Input.is_action_pressed("espaco"):
		$asprite.play("shot")					# Sprite de tiro
	
	if Input.is_action_just_pressed("espaco"):
		$tiro.play()
		
	movimento = move_and_slide(movimento, Vector2(0,-1))

func _on_Area2D_body_entered(body):
	if "espinho" in body.name:
		vida -= 1
		movimento.y = -800
		$asprite.play("jump(dano)")
		if vida == 2:
			get_parent().get_node("CanvasLayer/Sprite3").visible = false        # Pegando nós de outras raízes
		if vida == 1:
			get_parent().get_node("CanvasLayer/Sprite2").visible = false
		if vida == 0:
			$asprite.play("dead")
			get_parent().get_node("CanvasLayer/Sprite1").visible = false
			get_tree().change_scene("res://game_over.tscn")
	
	if "inimigo" in body.name:
		vida -= 1
		movimento.y = -800
		$asprite.play("jump(dano)")
		if vida == 2:
			get_parent().get_node("CanvasLayer/Sprite3").visible = false        # Pegando nós de outras raízes
		if vida == 1:
			get_parent().get_node("CanvasLayer/Sprite2").visible = false
		if vida == 0:
			$asprite.play("dead")
			get_parent().get_node("CanvasLayer/Sprite1").visible = false
			get_tree().change_scene("res://game_over.tscn")
	
	if "chefe" in body.name:
		vida -= 1
		movimento.y = -800
		$asprite.play("jump(dano)")
		if vida == 2:
			get_parent().get_node("CanvasLayer/Sprite3").visible = false        # Pegando nós de outras raízes
		if vida == 1:
			get_parent().get_node("CanvasLayer/Sprite2").visible = false
		if vida == 0:
			$asprite.play("dead")
			get_parent().get_node("CanvasLayer/Sprite1").visible = false
			get_tree().change_scene("res://game_over.tscn")
	
	if "acido" in body.name:
		vida -= 1
		movimento.y = -800
		$asprite.play("jump(dano)")
		if vida == 2:
			get_parent().get_node("CanvasLayer/Sprite3").visible = false        # Pegando nós de outras raízes
		if vida == 1:
			get_parent().get_node("CanvasLayer/Sprite2").visible = false
		if vida == 0:
			$asprite.play("dead")
			get_parent().get_node("CanvasLayer/Sprite1").visible = false
			get_tree().change_scene("res://game_over.tscn")
	
	if "mola" in body.name:
		movimento.y = -2000

func _on_Area2D2_body_entered(body):
	if "inimigo" in body.name:
		body.queue_free()
