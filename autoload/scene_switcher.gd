extends Node2D

signal transition_halfway

onready var anim : AnimationPlayer = $AnimationPlayer


func transition(next_scene : PackedScene) -> void:
	get_tree().paused = true
	
	anim.stop(true)
	anim.play("fadeinout")
	
	yield(self, "transition_halfway")
	
	#warning-ignore:return_value_discarded
	get_tree().change_scene_to(next_scene)
	
	get_tree().paused = false


func halfway() -> void:
	emit_signal("transition_halfway")

#var current_scene = null
#
#
#func _ready() -> void:
#	var root := get_tree().get_root()
#	current_scene = root.get_child(root.get_child_count() - 1)
#
#
#func goto_scene(path: NodePath) -> void:
#	call_deferred('_deferred_goto_scene', path)
#
#
#func _deferred_goto_scene(path: NodePath) -> void:
#	current_scene.queue_free()
#
#	var s = ResourceLoader.load(path)
#	current_scene = s.instance()
#
#	get_tree().get_root().add_child(current_scene)
#	get_tree().set_current_scene(current_scene)
