extends AudioStreamPlayer

const music_bg = preload("res://assets/music_bg.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream==music:
		return
	stream = music
	volume_db=volume
	play()

func play_music_level():
	_play_music(music_bg)
