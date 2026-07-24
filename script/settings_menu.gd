class_name SettingsMenu
extends Control

var in_deletescreen: bool = false
var in_settings: bool = false
signal return_to_menu

func _ready():
	$Panel/VolumeSlider.value = Global.volume_modifier
	$Panel/SensitivitySlider.value = Global.mouse_sensitivity
	$Panel/AntiMurderButton.toggle_mode = !Global.do_flashing
	if !SaveData.has_savedata(): $Panel/EraseSaveDataButton.disabled = true

func _on_main_menu_button_pressed() -> void:
	if !in_settings or in_deletescreen: return
	return_to_menu.emit()
	AudioManager.play_storedsfx(0)
	in_settings = false

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
	$Panel/ConfirmPanel.show()

##Delete save data buttons
func _on_yes_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	SaveData.clear_savedata()
	$Panel/ConfirmPanel.hide()
	$Panel/DeletedPanel.show()

func _on_no_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	kill_deletescreen()

func kill_deletescreen():
	in_deletescreen = false
	$Panel/DeletedPanel.hide()
	$Panel/ConfirmPanel.hide()

func _on_exit_deleted_button_pressed() -> void:
	if !in_settings or !in_deletescreen: return
	AudioManager.play_storedsfx(0)
	kill_deletescreen()
