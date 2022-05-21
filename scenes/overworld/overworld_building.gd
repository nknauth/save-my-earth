extends Area2D
class_name OverworldBuilding

# SIGNALS

# ENUMS

# CONSTANTS

# EXPORTS

export var stretch_factor : float = 1.3
export var stretch_duration : float = 0.5

export var next_scene : PackedScene


# PUBLIC VARIABLES

var can_accept_input = false setget _allow_input
var hovered : bool = false


# PRIVATE VARIABLES

# ONREADY VARIABLES

onready var sprite := $Sprite
onready var tween := $Tween
onready var open_sfx := $AudioStreamPlayer

onready var original_scale : Vector2 = sprite.scale
onready var stretched_scale : Vector2 = original_scale * stretch_factor


#func _init() -> void:
#	pass


func _ready() -> void:
	#warning-ignore:return_value_discarded
	EventBus.connect("building_input_allowed", self, "_allow_input")


# GODOT BUILTIN VIRTUAL METHODS

# PUBLIC METHODS

# PRIVATE METHODS

func _allow_input(is_input_allowed : bool) -> void:
	can_accept_input = is_input_allowed


func _on_Building_mouse_entered() -> void:
	if not can_accept_input:
		return
	
	hovered = true
	
	# stretch
	tween.remove_all()
	tween.interpolate_property(
		sprite,
		"scale",
		null,
		stretched_scale,
		stretch_duration,
		Tween.TRANS_ELASTIC,
		Tween.EASE_OUT
	)
	tween.start()
	
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	open_sfx.play()


func _on_Building_mouse_exited() -> void:
	if not can_accept_input:
		return
	hovered = false
	
	# unstretch
	tween.remove_all()
	tween.interpolate_property(
		sprite,
		"scale",
		null,
		original_scale,
		stretch_duration,
		Tween.TRANS_ELASTIC,
		Tween.EASE_OUT
	)
	tween.start()
	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_Building_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not can_accept_input:
		return
	if not hovered:
		return
	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		# If the next scene is defined, switch scenes.
		# Otherwise, create a Dialogic instance to explain the building isn't ready yet.
		
		if next_scene:
			SceneSwitcher.transition(next_scene)
		else:
			var new_dialog = Dialogic.start("building_not_ready")
			get_parent().add_child(new_dialog)
