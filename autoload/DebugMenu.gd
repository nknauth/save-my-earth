extends Control
#class_name what


var active : bool = false


func _ready() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_menu"):
		active = not active
		visible = active


func _on_VideoTestButton_pressed() -> void:
	var html = '<iframe width="560" height="315" src="https://www.youtube.com/embed/tNuIWDdiIHg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
	JavascriptActions.open_popup(html)
