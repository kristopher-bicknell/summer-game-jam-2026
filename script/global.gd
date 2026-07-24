extends Node

static var player_speed: float = 0.0

static var car: int = 0

static var mouse_sensitivity: float = 0.25
static var volume_modifier: float = 1.0
static var do_flashing: bool = true

static var skin_shader

func _ready():
	skin_shader = load("res://assets/resource/toon.gdshader")
