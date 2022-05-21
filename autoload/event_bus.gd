#warning-ignore-all: UNUSED_SIGNAL
extends Node


# Building input
signal building_input_allowed(allowed)

func allow_building_input() -> void:
	emit_signal("building_input_allowed", true)
