extends Button
class_name ConceptButton

# SIGNALS

# ENUMS

# CONSTANTS

# EXPORTS

export var correct_answer : NodePath

# PUBLIC VARIABLES

# PRIVATE VARIABLES

var active : bool = false
var midpoint : Vector2

var connected_to = null

# ONREADY VARIABLES

onready var line : Line2D = $Line2D


#func _init() -> void:
#	pass

func _ready() -> void:
	line.global_position = Vector2(0,0)
	midpoint = rect_global_position + (rect_size / 2)


func draw_line_to(button) -> void:
	line.add_point(midpoint)
	line.add_point(button.rect_global_position + (button.rect_size / 2))


func clear_line() -> void:
	line.clear_points()

# GODOT BUILTIN VIRTUAL METHODS
