class_name City
extends Node3D

@onready var checkpoints = [ 
	$"Checkpoints/1", $"Checkpoints/2", $"Checkpoints/3", $"Checkpoints/4", $"Checkpoints/5", $"Checkpoints/6",
	$"Checkpoints/7", $"Checkpoints/8", $"Checkpoints/9", $"Checkpoints/10", $"Checkpoints/11"
]

#IMPORTANT: INDEXES OF KEY CHECKPOINTS ARE NOT RELATED TO WHAT INDEX THE CHECKPOINT IS IN THE CHECKPOINTS ARRAY
@onready var key_checkpoints = [
	$"Checkpoints/1", $"Checkpoints/5", $"Checkpoints/7", $"Checkpoints/10", $"Checkpoints/11"
]

var lap = 0
var current_checkpoint: int = 0
@export var background_music: AudioStreamMP3
signal win_condition

func get_car_root():
	return $Car

func _ready():
	$Terrain/CollisionShape3D.shape = load("res://assets/city1/terrain.obj").create_trimesh_shape()
	for i in range(checkpoints.size()):
		checkpoints[i].body_entered.connect(checkpoint_entered.bind(i))

func _process(delta: float) -> void:
	$DebugCheckpoint.text = str(current_checkpoint)

func checkpoint_entered(body: Node3D, index: int):
	if !body is PlayerCar: return
	if current_checkpoint == index: return
	#check if checkpoint is valid:
	#ideally, only increment/decrement checkpoints by one
	#allow skipping one checkpoint maximum and no skipping key checkpoints
	if current_checkpoint - index == 1 or current_checkpoint - index == -1:
		current_checkpoint = index
		return
	#check lap condition
	if current_checkpoint == 10 and index == 0:
		current_checkpoint = 0
		check_win_condition()
		return
	#prevent laps by just going back and forth
	if current_checkpoint == 0 and index == 10:
		current_checkpoint = 10
		check_win_condition(false)
		return
	for i in range(current_checkpoint, index):
		#invalidate a skipped key checkpoint
		if key_checkpoints.has(checkpoints[i]): return
	#allow to skip exactly one normal checkpoint
	if current_checkpoint - index == 2 or current_checkpoint - index == -2:
		current_checkpoint = index

func check_win_condition(is_increment: bool = true):
	win_condition.emit()
