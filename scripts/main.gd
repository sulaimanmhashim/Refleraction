extends Control

func _ready():
	Music.play_music_level()

func _on_about_pressed():
	get_tree().change_scene_to_file("res://ui/about.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://ui/level_select.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://ui/main.tscn")
