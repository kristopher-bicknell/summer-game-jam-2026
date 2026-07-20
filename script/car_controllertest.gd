class_name PlayerCar
extends RigidBody3D

@export var _camera_pivot: RaceCamera
var _camera: Camera3D

var _is_colliding := false
var _camera_input_direction := Vector2.ZERO
signal hit_a_civillian

const TARGET_SPEED = 500

func _ready():
	_camera = _camera_pivot.get_camera()

func _physics_process(delta: float) -> void:
	if !_camera or !_camera_pivot: return
	_camera_pivot.global_position = global_position + center_of_mass
		#player movement
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var forward = _camera.global_basis.z
	var right = _camera.global_basis.x
	
	var move_direction = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	var target_velocity = move_direction * TARGET_SPEED
	apply_central_force(target_velocity)
	Global.player_speed = linear_velocity.length() * 1.5 #1.5 is arbitrary just to make it look nicer
	if Input.is_action_just_pressed("jump") and _is_colliding:
		apply_central_impulse(Vector3(0.0, 1300.0, 0.0))

func get_camera_rotation() -> float:
	return $Node3D.rotation.y

func _on_body_entered(body: Node) -> void:
	if body is StaticBody3D:
		_is_colliding = true
		return
	if body is PersonModifier:
		if body.is_hit: return
		if linear_velocity.length() * 1.5 < 20.0: return
		body.is_hit = true
		hit_a_civillian.emit()

func _on_body_exited(body: Node) -> void:
	if body is StaticBody3D:
		_is_colliding = false
