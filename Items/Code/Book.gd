extends InteractableItem


func _ready():
	self.itemName = "Book"
	self.interactionText = "Read"

	
	self.skeletonDialogText = [
		"Along the way, you might find it hard to progress in your current form",
		"Just remember, there's often more than one solution",
		"Be cautious though, if you run out of items, you may find yourself unable to move forward"
	]
	
	self.dogDialogText = [
		"You chew through a few of the pages",
		"Written on the edge of a page, you see a small handwritten passage",
		" \"He came again tonight...\"",
		"\"This time it was with a \'gift\'... this has to stop.\""
	]
	
	self.chickenDialogText = [
		"A chicken has no need for puny words",
		"You shred the book to pieces with your mighty beak"
	]

	self.tutorialText = [
		"TUTORIAL: I'm a book, I can't be picked up, but sometimes I have helpful information.",
		"Watch out though, if you're in chicken form, you might be compelled to destroy me"
	]

	self.activeItemDialogText = [
		"I'm responding to your active item, in this case, it's a potion!"
	]
	
	
func onInteraction(interactorParent):
#	if interactorParent.getActiveItem() == "Potion":
#		dialogText = activeItemDialogText
#	elif interactorParent.getActiveItem() == "Feather":
#		print("it's a feather")
#	elif interactorParent.getActiveItem() == "Key":
#		print("keys are useful!")
	
	
	if interactionCount == 0:
		dialogText = tutorialText
		interactionCount += 1
	else:
		self.dialogText = getDialog(interactorParent)
		if interactorParent.currentForm == "Chicken":
			self.hide()
			
	if interactorParent.getActiveItem() == "Potion":
		dialogText = activeItemDialogText
	spawnDialog()

func _on_DialogBox_dialogFinished():
	if self.visible == false:
		self.queue_free()
