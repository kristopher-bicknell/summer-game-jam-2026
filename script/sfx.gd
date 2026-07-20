class_name SFX
extends Sprite2D

var animations = ["shake", "splat", "sploot"]

func create(pos: Vector2, audio: AudioStreamMP3):
	global_position = pos
	$AudioStreamPlayer.stream = audio

func _ready():
	frame = randi_range(0,7)
	$AnimationPlayer.play(animations.pick_random())
	$AudioStreamPlayer.playing = true


func _on_animation_finished(anim_name: StringName) -> void:
	if $AudioStreamPlayer.playing:
		await $AudioStreamPlayer.finished
	queue_free()
