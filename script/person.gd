class_name Person
extends Node3D

@onready var anim_player = $AnimationPlayer as AnimationPlayer

var anims = ["walk", "run", "exercise", "ballet", "sit", "yoga", "idle", "fight1", "fight2", "wave"]

var textures = {
	0: ["res://assets/man/man_business1.png", "res://assets/man/man_casual1.png", "res://assets/man/man_workout1.png", "res://assets/man/man_pajamas1.png"],
	1: ["res://assets/woman/woman_business1.png", "res://assets/woman/woman_casual1.png", "res://assets/woman/woman_workout1.png", "res://assets/woman/woman_pajamas1.png"],
	2: ["res://assets/man/man_business1.png", "res://assets/man/man_casual1.png", "res://assets/man/man_workout1.png", "res://assets/man/man_pajamas1.png"]
	}

var heads = {
	0: [null, "res://assets/man/hat.obj", "res://assets/man/headphones.obj"],
	1: [null, "res://assets/woman/hair_bob.obj", "res://assets/woman/hair_beehive.obj"]
}


func setup(gender: int, play_animation: int, appearance: int, head: int):
	anim_player.play(anims[play_animation])
	$metarig/Skeleton3D/skin.set_surface_override_material(0, set_skin(gender, appearance))
	if head > 0:
		$metarig/Skeleton3D/Head/Mesh.mesh = load(heads[gender][head])
	else:
		$metarig/Skeleton3D/Head/Mesh.hide()

func set_skin(gender: int, appearance: int) -> ShaderMaterial:
	var material = ShaderMaterial.new()
	material.shader = Global.skin_shader
	material.set_shader_parameter("albedo_texture", load(textures[gender][appearance]))
	return material
