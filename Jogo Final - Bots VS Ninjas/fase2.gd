extends Node2D

func _ready():
	pass

func _on_door2_body_entered(body):
	get_tree().change_scene("res://fase3.tscn")
	