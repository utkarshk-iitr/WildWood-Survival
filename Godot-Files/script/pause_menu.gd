extends Control
@onready var inv: Inv = preload("res://inventory/playerinv.tres")

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("SFX")
var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	loadl("music")
	loadl("sfx")

func _on_music_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(music_bus,value)
	savel("music",value)
	if value==-30: AudioServer.set_bus_mute(music_bus,true)
	else: AudioServer.set_bus_mute(music_bus,false)

func _on_sfx_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(sfx_bus,value)
	savel("sfx",value)
	if value==-30: AudioServer.set_bus_mute(sfx_bus,true)
	else: AudioServer.set_bus_mute(sfx_bus,false)

func _process(_delta):
	if Input.is_action_just_pressed("pause") and get_tree().paused==false:
		get_tree().paused = true
		$open.play()
	elif Input.is_action_just_pressed("pause") and get_tree().paused==true:
		get_tree().paused = false
		self.visible = false
		
	if AudioServer.is_bus_mute(music_bus) and AudioServer.is_bus_mute(sfx_bus): AudioServer.set_bus_mute(master_bus,true)
	else: AudioServer.set_bus_mute(master_bus,false)
	
func _on_sfx_slider_mouse_exited():
	release_focus()

func _on_music_slider_mouse_exited():
	release_focus()

func _on_restart_pressed():
	inv.empty()
	get_tree().paused = false
	self.visible  = false
	get_tree().reload_current_scene()

func _on_exit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	get_tree().paused = false
	self.visible = false

func _on_back_pressed():
	inv.empty()
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func loadl(a):
	var config = ConfigFile.new()
	var error = config.load("res://saves/"+a+".cfg")
	if a=="music": $AudioOptions/Music_Slider.value = config.get_value(a,a)
	else: $AudioOptions/SFX_Slider.value = config.get_value(a,a)
	
func savel(a,v):
	var config = ConfigFile.new()
	config.set_value(a,a,v)
	config.save("res://saves/"+a+".cfg")
