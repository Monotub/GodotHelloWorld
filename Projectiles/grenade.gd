extends RigidBody2D

const speed = 750



func explode():
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("Explosion")
	$GPUParticles2D.restart()
