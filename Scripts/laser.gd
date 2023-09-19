extends Area2D

@export var speed: int = 2000
var direction: Vector2 = Vector2.UP


func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit("laser")
		
	if "is_enemy" in body: # Can be used to check for methosds or properties
		print("Dude, this thing looks dangerous!")
		
	queue_free()


func _on_auto_death_timer_timeout():
	queue_free()
