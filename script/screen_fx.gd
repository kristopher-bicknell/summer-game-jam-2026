class_name ScreenFX
extends Control

var x_range = Vector2(259.0, 903.0)
var y_range = Vector2(94.0, 532.0)

@onready var sfx = preload("res://scenes/sfx.tscn")
@onready var sound_effects = [
	preload("res://assets/resource/audio/bonk.mp3"),
	preload("res://assets/resource/audio/bonk2.mp3"),
	preload("res://assets/resource/audio/explode.mp3"),
	preload("res://assets/resource/audio/honkhonk.mp3")
]

func call_effect():
	if !Global.do_flashing: return
	var new_sfx = sfx.instantiate()
	new_sfx.create(Vector2(randf_range(x_range.x, x_range.y), randf_range(y_range.x, y_range.y)), sound_effects.pick_random())
	add_child(new_sfx)
