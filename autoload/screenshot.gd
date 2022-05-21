extends Node


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed('screenshot'):
		take_screenshot()


func take_screenshot() -> void:
	var dir := Directory.new()
	var path := 'user://screenshots/'
	
	#dir.open('user://')
	
	if not dir.dir_exists(path):
		var err = dir.make_dir(path)
		if err == OK:
			print('created screenshot directory')
		else:
			print('could not create screenshot directory, error: %s' % err)
	
	var time := OS.get_datetime()
	var file := str(time.year, '-', time.month, '-', time.day, '-', time.hour, time.minute, time.second, '.png')

	var fullname := path + file
	print(fullname)
	
	var image := get_viewport().get_texture().get_data()
	image.flip_y()
	var error := image.save_png(fullname)
	
	if error:
		print('Screenshot error: %s' % error)
	else:
		print('Screenshot saved to %s/screenshots/%s' % [OS.get_user_data_dir(), file])
