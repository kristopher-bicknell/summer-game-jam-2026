class_name PersonModifier
extends RigidBody3D

var is_hit: bool = false
@export var is_still: bool = false
@export var is_person: bool = true
var stay_at: Vector3
var stay_rotated_at: Vector3

func _ready():
	if is_still: 
		stay_at = global_position
		stay_rotated_at = global_rotation

func _physics_process(delta: float) -> void:
	if is_still and !is_hit:
		global_position = stay_at
		global_rotation = stay_rotated_at
