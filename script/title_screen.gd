class_name TitleScreen
extends Node3D

var in_settings: bool = false
var in_deletescreen: bool = false
signal start_game

func _ready():
	if !SaveData.has_savedata(): $SettingsScreen/Panel/EraseSaveDataButton.disabled = true

func _on_start_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	start_game.emit()

func _on_settings_button_pressed() -> void:
	if in_settings: return
	AudioManager.play_storedsfx(0)
	in_settings = true
	$AnimationPlayer.play("to_settings")

func _on_main_menu_button_pressed() -> void:
	if !in_settings or in_deletescreen: return
	AudioManager.play_storedsfx(0)
	in_settings = false
	$AnimationPlayer.play("to_main")

##Settings buttons
func _on_volume_slider_value_changed(value: float) -> void:
	if !in_settings or in_deletescreen: return
	AudioManager.play_storedsfx(0)
	Global.volume_modifier = value

func _on_sensitivity_slider_value_changed(value: float) -> void:
	if !in_settings or in_deletescreen: return
	AudioManager.play_storedsfx(0)
	Global.mouse_sensitivity = value

func _on_anti_murder_button_toggled(toggled_on: bool) -> void:
	if !in_settings or in_deletescreen: return
	AudioManager.play_storedsfx(0)
	#I fucked it up so its backwards, true means disabled flashing lights
	Global.do_flashing = !toggled_on

func _on_erase_save_data_button_pressed() -> void:
	if !in_settings or in_deletescreen: return
	if !SaveData.has_savedata(): return
	AudioManager.play_storedsfx(0)
	$SettingsScreen/Panel/ConfirmPanel.show()

##Delete save data buttons
func _on_yes_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	SaveData.clear_savedata()
	$SettingsScreen/Panel/ConfirmPanel.hide()
	$SettingsScreen/Panel/DeletedPanel.show()

func _on_no_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	kill_deletescreen()

func kill_deletescreen():
	in_deletescreen = false
	$SettingsScreen/Panel/DeletedPanel.hide()
	$SettingsScreen/Panel/ConfirmPanel.hide()

func _on_exit_deleted_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	kill_deletescreen()
