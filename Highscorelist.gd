extends Area2D

onready var camera = $Camera2D
signal player_entered_highscorelist(camera)
signal player_exited_highscorelist(camera)

func _on_highscorelist_body_entered(body):
	emit_signal("player_entered_highscorelist", camera)
	
func _on_highscorelist_body_exited(body):
	emit_signal("player_exited_highscorelist", camera)
