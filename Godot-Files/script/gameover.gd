extends Control
@onready var stat: Stat = preload("res://inventory/game_stats.tres")
@onready var inv: Inv = preload("res://inventory/playerinv.tres")
var save_path = "res://saves/save.cfg"

func _ready() -> void:
	$go.play()
	load_highscore()
	if stat.highscore<stat.score:
		stat.highscore = stat.score
		save_highscore()
	
	var nanosec=fmod(stat.score,1) * 10
	var second=fmod(stat.score,60)
	var minute=fmod(stat.score,3600) / 60
	var display1 = ("%02d:" % minute)+("%02d:" % second)+("%02d" % nanosec)
	nanosec=fmod(stat.highscore,1) * 10
	second=fmod(stat.highscore,60)
	minute=fmod(stat.highscore,3600) / 60
	var display2 = ("%02d:" % minute)+("%02d:" % second)+("%02d" % nanosec)
	$Panel/Value.text = " :      "+display1+"\n :      "+display2

func _on_back_pressed() -> void:
	inv.empty()
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")

func load_highscore():
	var config = ConfigFile.new()
	var error = config.load(save_path)
	stat.highscore = config.get_value("game","highscore")
	
func save_highscore():
	var config = ConfigFile.new()
	config.set_value("game","highscore",stat.highscore)
	config.save(save_path)
