extends TransformableItem



func _ready():
	itemName = "Feather"
	interactionText = "Read"
	formChange = "Chicken"
	
func onInteraction(interactorParent):
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
		self.queue_free()
