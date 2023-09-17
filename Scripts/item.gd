extends Area2D

var rotation_speed: int = 5
var available_types = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = available_types[randi() % len(available_types)]

var direction: Vector2
var distance: int = randi_range(150, 250)


func _ready():
	if type == "laser":
		$Sprite2D.modulate = Color(0.1, 0.2, 0.8)
	elif type == "grenade":
		$Sprite2D.modulate = Color(0.9, 0, 0)
	elif type == "health":
		$Sprite2D.modulate = Color(0, 0.8, 0)
		
	# Tweens
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == "health" and Globals.health < 100:
		Globals.health += 10
	elif type == "laser":
		Globals.laser_amount += 5
	elif type == "grenade":
		Globals.grenade_amount += 1
	queue_free()
