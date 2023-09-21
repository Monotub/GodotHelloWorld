extends Area2D

@export var speed: int = 2000
var direction: Vector2 = Vector2.UP


func _ready():
	$AudioStreamPlayer2D.play()
	

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit("laser")
	queue_free()


func _on_auto_death_timer_timeout():
	queue_free()
