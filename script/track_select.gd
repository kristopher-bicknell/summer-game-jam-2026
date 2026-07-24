class_name TrackSelect
extends Node3D

signal start_game(track: int)

var curr_track: int = -1
var car_types = [
	"'26 QPC", "'26 BEAST", "'25 LEAD"
]

func _process(delta: float) -> void:
	$Earth.rotation.y += 0.1 * delta

func display_records(track: int):
	$BestTimesPanel.show()
	var record_text = ""
	var record_data = SaveData.load_race_data(track)
	if !record_data.is_empty():
		#key = record, val = [date, car type]
		var sorted = record_data.keys()
		#TODO: this should put them in order of lowest to highest times???
		sorted.sort()
		for i in range(sorted.size()):
			record_text += "[b]#" + str(i) + ") " + str(sorted[i]) + "[/b]\n" + str(record_data[sorted[i]][0]) + " | " + car_types[record_data[sorted[i]][1]] + "\n"
	$BestTimesPanel/RichTextLabel.text = record_text

func _hide_records():
	$BestTimesPanel.hide()

func _on_big_city_button_pressed() -> void:
	$TrackPreview.show()
	$StartButton.disabled = false
	curr_track = 1
	display_records(1)

func _on_start_button_pressed() -> void:
	if curr_track == -1: return
	AudioManager.play_storedsfx(1)
	start_game.emit(curr_track)
