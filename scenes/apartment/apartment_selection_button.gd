extends TextureButton
#class_name what
#warning-ignore-all:return_value_discarded

# SIGNALS

# ENUMS

# CONSTANTS

# EXPORTS

export var stretch_factor : float = 1.03
export var stretch_duration : float = 0.5

export var next_scene : PackedScene


# PUBLIC VARIABLES

var hovered : bool = false

# PRIVATE VARIABLES

# ONREADY VARIABLES

onready var tween := $Tween
onready var open_sfx := $AudioStreamPlayer

onready var original_scale : Vector2 = self.rect_scale
onready var stretched_scale : Vector2 = original_scale * stretch_factor

#func _init() -> void:
#	pass

func _ready() -> void:
	# set rect pivot point
	rect_pivot_offset = rect_size / 2
	
	# connect signals
	self.connect("pressed", self, "_on_TextureButton_pressed")
	self.connect("mouse_entered", self, "_on_TextureButton_mouse_entered")
	self.connect("mouse_exited", self, "_on_TextureButton_mouse_exited")



# GODOT BUILTIN VIRTUAL METHODS

# PUBLIC METHODS

# PRIVATE METHODS

func _on_TextureButton_mouse_entered() -> void:
	hovered = true
	
	# stretch
	tween.remove_all()
	tween.interpolate_property(
		self,
		"rect_scale",
		null,
		stretched_scale,
		stretch_duration,
		Tween.TRANS_ELASTIC,
		Tween.EASE_OUT
	)
	tween.start()
	
	open_sfx.play()

func _on_TextureButton_mouse_exited() -> void:
	hovered = false
	
	# unstretch
	tween.remove_all()
	tween.interpolate_property(
		self,
		"rect_scale",
		null,
		original_scale,
		stretch_duration,
		Tween.TRANS_ELASTIC,
		Tween.EASE_OUT
	)
	tween.start()
	

func _on_TextureButton_pressed() -> void:
	if next_scene:
		SceneSwitcher.transition(next_scene)
