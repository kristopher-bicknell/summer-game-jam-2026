class_name RaceUI
extends Control

var cum_time: int = 0
var minutes: int = 0
var seconds: int = 0
var mseconds: int = 0
@onready var ending_music = preload("res://assets/resource/audio/copyrighted_mario_kart_64_ending_music.mp3")
signal return_to(screen: int)
signal paused(state: bool)

var manslaughter: int = 0

func _ready():
	$SettingsMenu.return_to_menu.connect(return_to_paused)

func _process(delta: float) -> void:
	if !Global.is_racing: return
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

func _input(event: InputEvent):
	if event.is_action_pressed("middle_click"):
		end_race()
	if event.is_action_pressed("ui_cancel"):
		$PauseWindow.visible = Global.is_racing
		Global.is_racing = !Global.is_racing
		paused.emit(!Global.is_racing)
		if Global.is_racing:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#this is defunct from testing the functionality of only counting hitting a person once (for the sake of VFX)
#it isnt used anywhere
func increment_manslaughter():
	manslaughter += 1

func bad_end_race():
	Global.is_racing = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.start_bgm(ending_music)
	$MSecondsTimer.stop()
	$AnimationPlayer.play("you_died")
	await get_tree().create_timer(0.5).timeout 
	var text = %Stopwatch.text
	%Stopwatch.text = "[color=#b50000]" + str(text)

func end_race():
	Global.is_racing = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	AudioManager.start_bgm(ending_music)
	$MSecondsTimer.stop()
	SaveData.save_race_data(Global.car, 1, cum_time, Time.get_datetime_string_from_system(true))
	$AnimationPlayer.play("end_race")
	await get_tree().create_timer(0.5).timeout #should roughly align with the "level clear" text
	var text = %Stopwatch.text
	%Stopwatch.text = "[rainbow][wave]" + str(text)

func _on_track_select_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	return_to.emit(2)

func _on_title_screen_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	return_to.emit(0)

func _on_vehicle_select_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	return_to.emit(1)

func _on_replay_track_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	return_to.emit(3)

func _on_settings_button_pressed() -> void:
	AudioManager.play_storedsfx(0)
	$AnimationPlayer.play("to_settings")

func _on_exit_button_pressed() -> void:
	AudioManager.play_storedsfx(0)
	return_to.emit(2)

func _on_resume_button_pressed() -> void:
	AudioManager.play_storedsfx(0)
	$PauseWindow.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.is_racing = true
	paused.emit(false)

func return_to_paused():
	$AnimationPlayer.play("to_pausescreen")
