extends ItemParent


func hit(type: String):
	if not opened:
		opened = true
		$LidSprite.hide()
		for i in range(3):
			var pos = $SpawnPositions.get_child(0).global_position
			open.emit(pos, current_dir)
