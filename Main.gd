extends Node2D

## Jitter-fix
func _ready():
	Engine.set_target_fps(Engine.get_iterations_per_second());