extends Control
var sfx_bus = AudioServer.get_bus_index("SFX")
var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	get_tree().paused = false
	loadl("music")
	loadl("sfx")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scene/options_menu.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scene/world.tscn")

func _on_exit_pressed():
	get_tree().quit()

func loadl(a):
	var config = ConfigFile.new()
	var error = config.load("res://saves/"+a+".cfg")
	if error != OK: return
	if a=="music": AudioServer.set_bus_volume_db(music_bus,config.get_value(a,a))
	else: AudioServer.set_bus_volume_db(sfx_bus,config.get_value(a,a))
