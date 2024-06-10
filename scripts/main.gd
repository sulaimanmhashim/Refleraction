extends Control

func _ready():
	Global.play_music_level()

func _on_about_pressed():
	get_tree().change_scene_to_file("res://ui/About.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://ui/Level_Select.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://ui/Main.tscn")

func _on_option_pressed():
	get_tree().change_scene_to_file("res://ui/Options.tscn")
