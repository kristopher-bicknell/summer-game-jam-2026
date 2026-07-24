class_name Main
extends Node3D

@export var car_root: RigidBody3D
var title_screen: TitleScreen
var screen_fx: ScreenFX
var race_ui: RaceUI
var car_select: CarSelect
var track_select: TrackSelect
var race_camera: RaceCamera
var current_track

func _ready():
	car_root.freeze = true
	car_root.global_position = Vector3(0,-10000,0)
	car_root.hit_a_civillian.connect(hit_a_civillian)
	chosen_track(1)
	return
	
	title_screen = load("res://scenes/title_screen.tscn").instantiate()
	title_screen.start_game.connect(start_game)
	add_child(title_screen)
	#car stays in the main scene no matter what because my life sucks ass
	#(making it its own instantiated scene broke the collisions for...some reason)
	
	save_test()

func hit_a_civillian():
	screen_fx.call_effect()
	race_ui.increment_manslaughter()

func start_game():
	title_screen.queue_free()
	car_select = load("res://scenes/car_select.tscn").instantiate()
	car_select.select_car.connect(select_car)
	add_child(car_select)

func select_car():
	car_select.queue_free()
	track_select = load("res://scenes/track_select.tscn").instantiate()
	track_select.start_game.connect(chosen_track)
	add_child(track_select)

func chosen_track(track: int):
	if track != 1: return
	#track_select.queue_free()
	current_track = load("res://scenes/city1.tscn").instantiate()
	add_child(current_track)
	car_root.global_position = Vector3(0.0,6.5,0.0)
	car_root.global_rotation.y = PI
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
	add_child(race_ui)
	car_root.freeze = false

func save_test():
	SaveData.save_race_data(0, 1, 12345, "2024-07-20 05:11:13")
	SaveData.save_race_data(1, 1, 67890, "2025-07-25 05:11:23")
	SaveData.save_race_data(2, 1, 99999, "2026-07-20 05:11:13")
