extends Control
#class_name what

# SIGNALS

# ENUMS


# CONSTANTS

# EXPORTS

# PUBLIC VARIABLES

var active_concept_button = null
var active_definition_button = null

var concept_buttons = []
var definition_buttons = []
var all_buttons = []

# PRIVATE VARIABLES

# ONREADY VARIABLES

#func _init() -> void:
#	pass

func _ready() -> void:
	# set up button arrays:
	concept_buttons = get_tree().get_nodes_in_group("ConceptButton")
	definition_buttons = get_tree().get_nodes_in_group("DefinitionButton")
	
	all_buttons = concept_buttons.duplicate()
	all_buttons.append_array(definition_buttons)
	
	for button in all_buttons:
		button.connect("pressed", self, "on_button_pressed", [button])
	

# GODOT BUILTIN VIRTUAL METHODS

# PUBLIC METHODS

# PRIVATE METHODS

func on_button_pressed(which) -> void:
	if which is ConceptButton:
		active_concept_button = which
	elif which is DefinitionButton:
		active_definition_button = which
	
	if active_concept_button and active_definition_button:
		active_concept_button.clear_line()
		active_concept_button.draw_line_to(active_definition_button)
		active_concept_button.connected_to = active_definition_button
		
		active_definition_button.connected = true
		active_definition_button.connected_to = active_concept_button
		
		active_concept_button = null
		active_definition_button = null

	if check_for_win():
		print('you win!')
	else:
		print('not a win yet')


func check_for_win() -> bool:
	for button in concept_buttons:
		if button.connected_to != button.get_node(button.correct_answer):
			return false
	return true
