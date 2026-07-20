
extends SoftBody3D

var max_wind_speed := 2.0

@onready var pivot = $WindPivot as Node3D
@onready var wind = $RigidBody3D/windarea as Area3D

func _physics_process(delta: float) -> void:
	return
	if Input.get_vector("move_left", "move_right", "move_forward", "move_back") != Vector2.ZERO:
		wind.wind_force_magnitude = 3.0
	else:
		wind.wind_force_magnitude = 0.0
	var raw_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var forward = pivot.global_basis.z
	var right = pivot.global_basis.x
	
	var move_direction = forward * raw_input.y + right * raw_input.x
	move_direction = move_direction.normalized()
	pivot.rotation = move_direction
	$Label.text = str(pivot.rotation)
	
