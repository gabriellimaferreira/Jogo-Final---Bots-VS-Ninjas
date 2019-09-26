extends Node2D

func _ready():
	pass

func _on_door1_body_entered(body):
	get_tree().change_scene("res://fase2.tscn")
