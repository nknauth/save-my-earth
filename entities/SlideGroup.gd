extends Control
#class_name what

# SIGNALS

# ENUMS

# CONSTANTS

# EXPORTS

# PUBLIC VARIABLES

var slides = []
var active_slide : int

# PRIVATE VARIABLES

# ONREADY VARIABLES

#func _init() -> void:
#	pass

func _ready() -> void:
	
	active_slide = 0
	
	# Set up slides, hiding all but the first child:
	slides = get_children()
	
	for slide in slides:
		slide.visible = false
	
	slides[0].visible = true
	
	# Connect any button in the group NextSlideButton with the show_next_slide function:
	var buttons = get_tree().get_nodes_in_group("NextSlideButton")
	for button in buttons:
		button.connect("pressed", self, "show_next_slide")

# GODOT BUILTIN VIRTUAL METHODS

# PUBLIC METHODS

func show_next_slide() -> void:
	if active_slide + 1 >= slides.size():
		return
	
	slides[active_slide].visible = false
	
	active_slide += 1
	
	slides[active_slide].visible = true

# PRIVATE METHODS


# This assumes RichTextLabel's `meta_clicked` signal was connected to
# the function below using the signal connection dialog.
func _richtextlabel_on_meta_clicked(meta):
	# `meta` is not guaranteed to be a String, so convert it to a String
	# to avoid script errors at run-time.
	OS.shell_open(str(meta))
