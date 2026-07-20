extends PersonModifier

var base_person: Person

@export_enum("man", "woman", "child", "dog") var type
@export var path: PathFollow3D
var on_path: bool = false
var type_scenes = ["res://scenes/man.tscn", "res://scenes/man.tscn", "res://scenes/man.tscn", "res://scenes/man.tscn"]
@export_enum("walk", "run", "exercise", "ballet", "sit", "yoga") var play_animation
@export_enum("business", "casual", "workout", "pajamas") var appearance

func _ready():
	base_person = load(type_scenes[type]).instantiate() as Person
	add_child(base_person)
	base_person.setup(play_animation, appearance)
	if path:
		on_path = true

func _physics_process(delta):
	if on_path: return
