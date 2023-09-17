extends LevelParent


func _on_exit_gate_area_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($Player, "move_speed", 0, 0.3)
	get_tree().change_scene_to_file("res://Scenes/Levels/outside.tscn")
