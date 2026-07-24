class_name RaceUI
extends Control

var cum_time: int = 0
var minutes: int = 0
var seconds: int = 0
var mseconds: int = 0

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
	$Label.text = "People killed: " + str(manslaughter)

func end_race():
	SaveData.save_race_data(Global.car, 1, cum_time, Time.get_datetime_string_from_system(true))
