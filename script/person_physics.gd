class_name PersonPhysics
extends PersonModifier

var base_person: Person

@export_enum("man", "woman", "child", "dog") var type
@export var head_type: int = 0
@export var path: PathFollow3D
var on_path: bool = false
var type_scenes = ["res://scenes/man.tscn", "res://scenes/woman.tscn", "res://scenes/child.tscn", "res://scenes/man.tscn"]
@export_enum("walk", "run", "exercise", "ballet", "sit", "yoga", "idle", "fight1", "fight2", "wave") var play_animation
@export_enum("business", "casual", "workout", "pajamas") var appearance

func _ready():
	$PlacementGuide.queue_free()
	base_person = load(type_scenes[type]).instantiate() as Person
	add_child(base_person)
	base_person.setup(type, play_animation, appearance, head_type)
	if path:
		on_path = true
		global_position = path.global_position
		global_rotation.y = path.global_rotation.y

func _process(delta):
	#hitting a person will knock them off their path
	if on_path and is_hit:
		on_path = false

func _physics_process(delta):
	#if they are set to move along a path, they will follow it until they are hit
	if on_path:
		global_position = path.global_position
		global_rotation.y = path.global_rotation.y
