extends Node2D

var MAX_BOUNCES = 10
var MAX_LENGTH = 1000
var victory

@onready var line = $Line2D
@onready var ray = $Ray
@onready var sprite = $Sprite2D

func _ready():
	victory=false

func _process(_delta):
	var prev = null
	var first_medium = null
	var bounces = 0
	if not victory:
		line.clear_points()
	
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			sprite.look_at(get_global_mouse_position())
			
			line.add_point(Vector2.ZERO)
			var origin = line.global_position
			var end = (get_global_mouse_position()-line.global_position)
			var target
			var collider
			var normal
			
			while true:
				ray.clear_exceptions()
				if prev!=null:
					ray.add_exception(prev)
				if first_medium!=null:
					ray.add_exception(first_medium)
				
				ray.global_position = origin
				ray.target_position = end.normalized()*MAX_LENGTH
				ray.force_raycast_update()
				
				if not ray.is_colliding():
					var pt = ray.global_position + ray.target_position
					line.add_point(line.to_local(pt))
					break
				
				target = ray.get_collision_point()
				collider = ray.get_collider()
				normal = ray.get_collision_normal()
				prev = collider
				
				line.add_point(line.to_local(target))
				
				if collider.is_in_group("absorber"):
					collider.get_parent().recieve(ray)
					break	
				
				if collider.is_in_group("mirror"):
					var in_dir = target-origin
					var out_dir = in_dir.bounce(normal)
					
					origin = target
					end = out_dir
					ray.force_raycast_update()
				
				if collider.is_in_group("medium"):
					if first_medium==null:
						#print(collider.get_parent().get_name())
						first_medium=collider
						continue
					if first_medium!=null:
						#print("this")
						var in_dir = target-origin
						var normal_angle = (-normal).angle()
						var incident_angle  = (-normal).angle_to(in_dir)
						
						var refracted_angle = handle_angle(	incident_angle,
															normal_angle,
															first_medium.get_name(),
															collider.get_name())
						
						if refracted_angle == INF:
							var out_dir = in_dir.bounce(normal)
							
							origin = target
							end = out_dir
							ray.force_raycast_update()
							continue
						
						origin = target
						end = Vector2.from_angle(refracted_angle)
						ray.force_raycast_update()
				bounces+=1
				if bounces>=MAX_BOUNCES:
					break

func handle_angle(incident, normal, incident_med, refracted_med):
	var n1
	var n2
	
	var air = 1
	var water = 1.33
	var glass = 1.5
	
	if incident_med==null:
		n1=1
	elif incident_med.contains("Glass"):
		n1=glass
	elif incident_med.contains("Water"):
		n1=water
	elif incident_med.contains("Air"):
		n1=air
	
	if refracted_med.contains("Glass"):
		n2=glass
	elif refracted_med.contains("Water"):
		n2=water
	elif refracted_med.contains("Air"):
		n2=air
	
	var sin_ang = (n1 / n2) * sin(incident)
	#print(sin_ang)
	sin_ang = max(-1.0, min(1.0, sin_ang))
	#print(sin_ang)
	
	if sin_ang>=1:
		return INF
	if sin_ang<=-1:
		return INF
	
	var refracted = asin(sin_ang)
	
	return refracted+normal
