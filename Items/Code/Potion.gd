extends PickableItem

class_name Potion

func _ready():
	itemName = "Potion"
	interactionText = "Pick Up"
	
func onInteraction(interactorParent):
	if interactorParent.addItemToInventory(itemName) == true:
		pickedUp = true
		self.queue_free()
