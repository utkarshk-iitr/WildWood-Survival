extends Panel
var time:float=0.0
var minute=0
var second=0
var nanosec=0
var restart=false
@onready var stat: Stat = preload("res://inventory/game_stats.tres")

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause") and restart==false:
		set_process(false)
		restart=true
	elif restart==true:
		set_process(true)
		restart=false

func _process(delta):
	nanosec=fmod(time,1) * 10
	second=fmod(time,60)
	minute=fmod(time,3600) / 60
	$minute.text="%02d:" % minute
	$second.text="%02d:" % second
	$nanosec.text="%02d" % nanosec
	if visible: time+=delta
	stat.score = time
