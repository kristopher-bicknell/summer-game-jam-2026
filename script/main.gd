class_name Main
extends Node3D

var car_root: RigidBody3D
var title_screen: TitleScreen
var screen_fx: ScreenFX
var race_ui: RaceUI
var car_select: CarSelect
var track_select: TrackSelect
var win_screen: WinScreen
var race_camera: RaceCamera
var current_track

func _ready():
	#car_root.global_position = Vector3(0,-10000,0)
	#car_root.set_frozen(true)
	AudioManager.BGMplayer = $BGM
	AudioManager.UISFX = $UI_SFX
	call_title_screen()
	#TODO: does the save test actually do anything
	save_test()

func call_title_screen():
	clear_track()
	title_screen = load("res://scenes/title_screen.tscn").instantiate()
	title_screen.start_game.connect(start_game)
	add_child(title_screen)

func hit_a_civillian():
	screen_fx.call_effect()
	race_ui.increment_manslaughter()

func start_game():
	clear_track()
	if is_instance_valid(title_screen):
		title_screen.queue_free()
	car_select = load("res://scenes/car_select.tscn").instantiate()
	car_select.select_car.connect(select_car)
	add_child(car_select)

func select_car():
	clear_track()
	if is_instance_valid(car_select):
		car_select.queue_free()
	track_select = load("res://scenes/track_select.tscn").instantiate()
	track_select.start_game.connect(chosen_track)
	add_child(track_select)

func clear_track():
	if is_instance_valid(current_track):
		current_track.queue_free()
		race_ui.queue_free()
		race_camera.queue_free()
		screen_fx.queue_free()

func chosen_track(track: int):
	if track != 1: return
	if is_instance_valid(track_select):
		track_select.queue_free()
	current_track = load("res://scenes/city1.tscn").instantiate()
	add_child(current_track)
	car_root = current_track.get_car_root()
	car_root.set_frozen(true)
	car_root.hit_a_civillian.connect(hit_a_civillian)
	race_camera = load("res://scenes/camera.tscn").instantiate()
	race_camera.global_rotation.y = PI
	add_child(race_camera)
	car_root._camera_pivot = race_camera #improper access of a private variable because i dont CARE
	car_root.set_camera()
	start_race()

func start_race():
	screen_fx = load("res://scenes/screen_fx.tscn").instantiate()
	add_child(screen_fx)
	$AnimationPlayer.play("countdown")
	await get_tree().create_timer(3.0).timeout
	race_ui = load("res://scenes/race_ui.tscn").instantiate()
	current_track.win_condition.connect(race_ui.end_race)
	current_track.win_condition.connect(end_of_race_adjustments)
	current_track.you_died.connect(race_ui.bad_end_race)
	current_track.you_died.connect(end_of_race_adjustments)
	race_ui.return_to.connect(return_to)
	race_ui.paused.connect(pause_handle)
	add_child(race_ui)
	car_root.set_frozen(false)
	Global.is_racing = true
	AudioManager.start_bgm(current_track.background_music)

func return_to(screen: int):
	clear_track()
	match screen:
		0:
			call_title_screen()
		1:
			start_game()
		2:
			select_car()
		3:
			chosen_track(1)

func end_of_race_adjustments():
	car_root.apply_central_impulse(Vector3(0,100000,0))
	car_root.is_control = false

func pause_handle(is_paused: bool):
	if is_instance_valid(car_root):
		car_root.set_frozen(is_paused)

func save_test():
	SaveData.save_race_data(0, 1, 12345, "2024-07-20 05:11:13")
	SaveData.save_race_data(1, 1, 67890, "2025-07-25 05:11:23")
	SaveData.save_race_data(2, 1, 99999, "2026-07-20 05:11:13")
