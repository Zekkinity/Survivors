extends Camera2D

const DEADZONE = 100

func _input(event: InputEvent)-> void:
	if event is InputEventMouseMotion:
		var target = event.position - get_viewport().size * 0.5
		if target.length() < DEADZONE:
			self.position = Vector2(0,0)
		else:
			self.position = target.normalized() * (target.length() - DEADZONE) * 0.5
