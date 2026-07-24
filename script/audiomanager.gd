extends Node

var BGMplayer: AudioStreamPlayer
var UISFX: AudioStreamPlayer

@onready var stored_sfx = [
	load("res://assets/resource/audio/click.mp3"),
	load("res://assets/resource/audio/game_start.mp3")
]

func start_bgm(track: AudioStreamMP3):
	BGMplayer.stream = track
	BGMplayer.volume_linear = Global.volume_modifier
	BGMplayer.play()

func play_sfx(sound: AudioStreamMP3):
	UISFX.stream = sound
	UISFX.volume_linear = Global.volume_modifier
	UISFX.play()

func play_storedsfx(index: int):
	UISFX.stream = stored_sfx[index]
	UISFX.volume_linear = Global.volume_modifier
	UISFX.play()
