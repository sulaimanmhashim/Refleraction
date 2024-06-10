extends Control

func _ready():
	Music.play_music_level()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://ui/main.tscn")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://levels/Level_1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://levels/Level_2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://levels/Level_3.tscn")

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://levels/Level_4.tscn")

func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://levels/Level_5.tscn")

func _on_level_6_pressed():
	get_tree().change_scene_to_file("res://levels/Level_6.tscn")

func _on_level_7_pressed():
	get_tree().change_scene_to_file("res://levels/Level_7.tscn")

func _on_level_8_pressed():
	get_tree().change_scene_to_file("res://levels/Level_8.tscn")

func _on_level_9_pressed():
	get_tree().change_scene_to_file("res://levels/Level_9.tscn")
