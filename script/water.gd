extends Area3D

@onready var sploosh_scene = load("res://scenes/sploosh.tscn")



func _on_body_entered(body: Node3D) -> void:
	if body is StaticBody3D: return
	print(body)
	var pos = body.global_position
	var new_sploosh = sploosh_scene.instantiate()
	add_child(new_sploosh)
	new_sploosh.global_position = pos
