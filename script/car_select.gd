class_name CarSelect
extends Node3D

@onready var car_display_pivot = $CarDisplayPivot as Node3D
@onready var cars = [$CarDisplayPivot/Car1, $CarDisplayPivot/Car2, $CarDisplayPivot/Car3]
@onready var color_gradient = preload("res://assets/resource/colorgradient.tres")


var current_car: int = 0
var goal_rotation: float = 0
var car_data = [
	["2026 QPC NEVADA", "res://assets/car0texture.tres", 3, 4, 2],
	["2026 BEAST 411 ATV", "res://assets/car0texture.tres", 4, 2, 5],
	["2025 LEAD MONSTER", "res://assets/car0texture.tres", 1, 5, 3]
]

func _ready():
	set_displaydata()

func rotation(direction: bool):
	var rotate_direction= (2.0*PI) / 3.0
	if direction: rotate_direction *= -1
	current_car += 1 + (-2 * int(!direction))
	current_car = posmod(current_car, 3)
	goal_rotation += rotate_direction
	set_displaydata()

func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		rotation(false)
	if Input.is_action_just_pressed("move_right"):
		rotation(true)
	car_display_pivot.rotation.y = lerp_angle(car_display_pivot.rotation.y, goal_rotation, 10.0 * delta)

func set_displaydata():
	$AnimationPlayer.play("car"+str(current_car))
	var data = car_data[current_car]
	var speed = data[2]
	var weight = data[3]
	var cool = data[4]
	%CarName.text = data[0]
	%SpeedBar.value = speed
	%SpeedBar.modulate = color_gradient.colors.get(speed)
	%WeightBar.value = weight
	%WeightBar.modulate =  color_gradient.colors.get(weight)
	%CoolBar.value = cool 
	%CoolBar.modulate =  color_gradient.colors.get(cool)

func _on_right_pressed() -> void:
	rotation(true)

func _on_left_pressed() -> void:
	rotation(false)

func _on_next_button_pressed() -> void:
	$AnimationPlayer.speed_scale = 1.0
	$AnimationPlayer.play("car"+str(current_car)+"_select")
	await get_tree().create_timer(0.8).timeout
	queue_free()
