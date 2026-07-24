extends Path3D

@onready var path_follow = get_child(0)

func _process(delta: float):
	path_follow.progress += delta * 6.0
