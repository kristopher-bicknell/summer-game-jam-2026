class_name Person
extends Node3D

@onready var anim_player = $AnimationPlayer as AnimationPlayer

var anims = ["walk", "run", "exercise", "ballet", "sit", "yoga"]

var textures = ["res://assets/man/man_business1.png", "res://assets/man/man_business1.png", "res://assets/man/man_business1.png", "res://assets/man/man_business1.png"]

func setup(play_animation: int, appearance: int):
	anim_player.play(anims[play_animation])
	$metarig/Skeleton3D/Cube.get_surface_override_material(0).set_shader_parameter("albedo_texture", load(textures[appearance]))
