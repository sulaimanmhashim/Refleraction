extends Control

@onready var pauseButton = $AspectRatioContainer/Pause
@onready var victoryScreen = $Victory_Screen
@onready var victoryAnim = $Victory_Screen/AnimationPlayer

var animPlaying

func _ready():
	var popup=pauseButton.get_popup()
	popup.id_pressed.connect(file_menu)
	victoryScreen.hide()
	Global.play_music_level()
	animPlaying = false

func _process(_delta):
	if Global.victory:
		victoryScreen.show()
		if not animPlaying:
			victoryAnim.play("blur")
			animPlaying = true
	else:
		victoryScreen.hide()

func _on_pause_toggled(_toggled_on):
	var is_paused = get_tree().paused
	if is_paused:
		get_tree().paused=false
	elif not is_paused:
		get_tree().paused=true

func file_menu(id):
	if id==1:
		get_tree().change_scene_to_file("res://ui/Level_Select.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://ui/Level_Select.tscn")
