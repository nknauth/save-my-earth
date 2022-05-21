extends Node
# source: https://www.youtube.com/watch?v=44YpRF5FZDc


func frameFreeze(timeScale: float = 0.05, duration: float = 0.1) -> void:
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1
