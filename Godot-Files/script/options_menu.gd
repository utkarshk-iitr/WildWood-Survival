extends Control

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("SFX")
var music_bus = AudioServer.get_bus_index("Music")
var save_path = "res://saves/save.cfg"

func _ready():
	loadl("music")
	loadl("sfx")

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus,value)
	savel("music",value)
	if value==-30: AudioServer.set_bus_mute(music_bus,true)
	else: AudioServer.set_bus_mute(music_bus,false)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus,value)
	savel("sfx",value)
	if value==-30: AudioServer.set_bus_mute(sfx_bus,true)
	else: AudioServer.set_bus_mute(sfx_bus,false)

func _on_sfx_slider_mouse_exited():
	release_focus()

func _on_music_slider_mouse_exited():
	release_focus()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func _on_reset_pressed():
	var config = ConfigFile.new()
	config.set_value("game","highscore",0)
	config.save(save_path)

func loadl(a):
	var config = ConfigFile.new()
	var error = config.load("res://saves/"+a+".cfg")
	if a=="music": $AudioOptions/Music_Slider.value = config.get_value(a,a)
	else: $AudioOptions/SFX_Slider.value = config.get_value(a,a)
	
func savel(a,v):
	var config = ConfigFile.new()
	config.set_value(a,a,v)
	config.save("res://saves/"+a+".cfg")
