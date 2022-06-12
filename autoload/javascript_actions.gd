extends Node


func open_popup(content : String) -> void:
	if not OS.has_feature('JavaScript'):
		return
		
	var command := "document.getElementById('popup-inner').innerHTML = '%s'" % content
	
	JavaScript.eval(command)
	JavaScript.eval("showPopup()", true)
