extends LevelParent


func _on_exit_gate_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "move_speed", 0, 0.3)
	TransitionLayer.change_scene("res://Scenes/Levels/outside.tscn")
