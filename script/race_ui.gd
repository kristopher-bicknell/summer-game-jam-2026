class_name RaceUI
extends Control

var cum_time: int = 0
var minutes: int = 0
var seconds: int = 0
var mseconds: int = 0
@onready var ending_music = preload("res://assets/resource/audio/copyrighted_mario_kart_64_ending_music.mp3")

var manslaughter: int = 0

func _process(delta: float) -> void:
	%Stopwatch.text = str("%02d:%02d.%01d" % [minutes, seconds, mseconds])
	%Spedometer.text = str("%.0f" % Global.player_speed) + " MPH"

func _on_m_seconds_timer_timeout() -> void:
	mseconds += 1
	cum_time += 1
	fix_time()

func fix_time():
	if mseconds > 9:
		mseconds = 0
		seconds += 1
	if seconds > 59:
		seconds = 0
		minutes += 1

func increment_manslaughter():
	manslaughter += 1

func end_race():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.start_bgm(ending_music)
	$MSecondsTimer.stop()
	SaveData.save_race_data(Global.car, 1, cum_time, Time.get_datetime_string_from_system(true))
	$AnimationPlayer.play("end_race")
	await get_tree().create_timer(0.5).timeout #should roughly align with the "level clear" text
	var text = %Stopwatch.text
	%Stopwatch.text = "[rainbow][wave]" + str(text)
