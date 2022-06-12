extends Control


func _ready() -> void:
	var html = '<iframe width="560" height="315" src="https://www.youtube.com/embed/tNuIWDdiIHg" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
	JavascriptActions.open_popup(html)
