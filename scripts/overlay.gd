extends Control

@onready var pauseButton = $AspectRatioContainer/Pause

func _ready():
	var popup=pauseButton.get_popup()
	popup.id_pressed.connect(file_menu)
	Music.play_music_level()

func _on_pause_toggled(_toggled_on):
	var is_paused = get_tree().paused
	if is_paused:
		get_tree().paused=false
	elif not is_paused:
		get_tree().paused=true

func file_menu(id):
	if id==1:
		get_tree().change_scene_to_file("res://ui/level_select.tscn")


