class_name TitleScreen
extends Node3D

signal start_game

func _ready():
	$SettingsMenu.return_to_menu.connect(return_to_menu)

func _on_start_button_pressed() -> void:
	AudioManager.play_storedsfx(1)
	start_game.emit()

func _on_settings_button_pressed() -> void:
	if $SettingsMenu.in_settings: return
	$SettingsMenu.in_settings = true
	AudioManager.play_storedsfx(0)
	$AnimationPlayer.play("to_settings")

func return_to_menu():
	$AnimationPlayer.play("to_main")
