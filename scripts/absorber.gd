extends Node2D

@onready var collision_body = $CharacterBody2D/CollisionPolygon2D
@onready var sprite = $CharacterBody2D/AnimatedSprite2D
var is_full
var is_recieving
var ray
var temp

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.victory = false
	is_full = false
	is_recieving = false
	ray = null
	sprite.play("empty")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ray !=null:
		if ray.get_collider().is_in_group("absorber"):
			is_recieving=true
			if not is_full:
				sprite.play("charging")
	else:
		if not is_full:
			sprite.play("empty")
	temp = ray
	ray = null

func recieve(raycast):
	ray = raycast

func _on_animated_sprite_2d_animation_finished():
	if is_recieving:
		is_full=true
		sprite.play("full")
		temp.get_parent().victory=true
		Global.victory = true
		#get_tree().paused = true
