class_name Player
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 300
@export var acceleration := 125
@export var rotation_speed := 10
@export var jump_impulse := 60
var _gravity := -40.0

var target_velocity = Vector3.ZERO
var _last_movement_direction = Vector3.ZERO

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var forward = $Node3D.global_basis.z
	var right = $Node3D.global_basis.x
	
	var move_direction = forward * raw_input.y + right * raw_input.x
	move_direction = move_direction.normalized()

	var used_speed = speed
		
	velocity = velocity.move_toward(move_direction * used_speed, acceleration * delta)
	velocity.y += _gravity * delta
	move_and_slide()
