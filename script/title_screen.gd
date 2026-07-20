class_name TitleScreen
extends Node3D

var in_settings: bool = false

func _on_start_button_pressed() -> void:
	pass # Replace with function body.

func _on_settings_button_pressed() -> void:
	if in_settings: return
	in_settings = true
	$AnimationPlayer.play("to_settings")

func _on_main_menu_button_pressed() -> void:
	if !in_settings: return
	in_settings = false
	$AnimationPlayer.play("to_main")

##Settings buttons

func _on_volume_slider_value_changed(value: float) -> void:
	Global.volume_modifier = value

func _on_sensitivity_slider_value_changed(value: float) -> void:
	Global.mouse_sensitivity = value

func _on_anti_murder_button_toggled(toggled_on: bool) -> void:
	#I fucked it up so its backwards, true means disabled flashing lights
	Global.do_flashing = !toggled_on
