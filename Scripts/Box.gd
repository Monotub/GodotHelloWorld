extends ItemParent


func hit(_type: String):
	if not opened:
		opened = true
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi() % $SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_dir)
