extends PickableItem



func _ready():
	itemName = "Book"
	interactionText = "Read"
	
func onInteraction(interactorParent):
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
		self.queue_free()
