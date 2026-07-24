extends GPUParticles3D

func _ready():
	emitting = true
	$AudioStreamPlayer.play()

func _on_finished() -> void:
	if $AudioStreamPlayer.playing:
		await $AudioStreamPlayer.finished
	queue_free()
