extends Node2D

func _ready():
	pass

func _on_door3_body_entered(body):
	get_tree().change_scene("res://vitoria.tscn")
