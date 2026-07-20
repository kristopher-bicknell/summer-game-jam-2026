class_name Main
extends Node3D

@export var car_root: RigidBody3D

func _ready():
	car_root.hit_a_civillian.connect(hit_a_civillian)

func hit_a_civillian():
	$ScreenFX.call_effect()
	$RaceUI.increment_manslaughter()
