extends InteractableItem


signal collected(item)



func _on_StaticBody2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			print("clicked on body")
			emit_signal("collected", self)

func getIconTexture():
	return $IconTexture
