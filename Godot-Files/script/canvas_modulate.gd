extends CanvasModulate

var time:float=0.0
var ingame_min = (2*PI)/1440
var ingame_speed = 7
@export var gradient:GradientTexture1D

func _process(delta: float) -> void:
	time += delta * ingame_min * ingame_speed
	var value = (sin(time+PI/2)+1)/2.0
	self.color = gradient.gradient.sample(value)
