extends Node

# given a path, save or load a full godot variant
# don't bother with json, just uses str2var and var2str


func save_file(path: String, content) -> void:
	var file := File.new()
	
	var err := file.open(path, File.WRITE)
	if not err:
		file.store_string(var2str(content))
		file.close()


func load_file(path: String): # -> Variant
	var file := File.new()
	
	var err := file.open(path, File.READ)
	if not err:
		var content: String = file.get_as_text()
		return str2var(content)
