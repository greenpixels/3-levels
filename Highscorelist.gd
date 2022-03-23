extends Area2D

onready var camera : Camera2D = $Camera2D
signal player_entered_highscorelist(camera)
signal player_exited_highscorelist(camera)

## Send out signals containing this nodes camera information when player enters the area
func _on_highscorelist_body_entered(body : Object):
	emit_signal("player_entered_highscorelist", camera)
func _on_highscorelist_body_exited(body : Object):
	emit_signal("player_exited_highscorelist", camera)
