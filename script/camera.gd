class_name RaceCamera
extends Node3D


@export_range(0.0,1.0) var mouse_sensitivity := 0.25

var camera_input_direction := Vector2.ZERO

@onready var ball = get_parent()
@onready var offset = position

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("middle_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
			event is InputEventMouseMotion and
			Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
		) #check that event is mouse movement and mouse is in the window
	if is_camera_motion:
		camera_input_direction = event.screen_relative * mouse_sensitivity

func _physics_process(delta):
	rotation.x += camera_input_direction.y * delta
	rotation.x = clamp(rotation.x, -PI/6.0, PI/3.0) #limit rotation
	rotation.y -= camera_input_direction.x * delta
	rotation.z = 0
	camera_input_direction = Vector2.ZERO

func get_camera() -> Camera3D:
	return $SpringArm3D/Camera3D

func _exit_tree():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
