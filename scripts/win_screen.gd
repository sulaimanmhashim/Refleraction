extends Control

var victory

func _ready():
	victory = false

func _process(_delta):
	if victory:
		show()
	if not victory:
		hide()

func hit_stop():
	Engine.time_scale = 0

func won():
	victory=true
	$Win/AnimationPlayer.play("blur")
