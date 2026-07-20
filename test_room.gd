extends Node3D

func _process(delta: float) -> void:
	return
	$Rotator.apply_central_force(Vector3(-250,0,0))

var vehicular_manslaughter_flavortext = [
	"FATALITY",
	"OUCH!",
	"WATCH IT!",
	"GET REKT",
	"OH THE HUMANITY!"
]

@export var car_root: RigidBody3D

func _ready():
	car_root.hit_a_civillian.connect(hit_a_civillian)

func hit_a_civillian():
	$Fatality.text = vehicular_manslaughter_flavortext.pick_random() + "\n+10 PTS"
	$AnimationPlayer.play("hit_a_civillian")
