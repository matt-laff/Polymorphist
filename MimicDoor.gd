extends InteractableItem

var player
var keyDialogText = []
export var hasSecret = false

var dogDialogTextWithSecret = []

func _ready():
	self.itemName = "MimicDoor"
	self.interactionText = "Open"

	
	self.skeletonDialogText = [
		"I'm a door!"
	]
	
	self.dogDialogText = [
		"Awww whose a cute puppy??",
		"Yes you! You're a good puppy!",
		"Does puppy want a toy?",
		"You recieved 1 [Potion] !",
		"Here, you're free to pass"
	]
	
	self.dogDialogTextWithSecret = [
		"Awww whose a cute puppy??",
		"Yes you! You're a good puppy!",
		"Does puppy want a toy?",
		"You recieved 1 [Potion] !",
		"Don't tell anybody, but just behind me and to the left, there's a secret passage...",
		"...Well there isn't right now, but eventually the maker will put one there!"
	]
	self.chickenDialogText = [
		"A chicken has no need for puny words",
		"You shred the book to pieces with your mighty beak"
	]

	keyDialogText = [
		"Oh it's a key."
	]
	
	
func onInteraction(interactorParent):
	self.dialogText = getDialog(interactorParent)
	player = interactorParent
	if player.currentForm == "Dog":
		$AnimationPlayer.play("MimicShow")
		player.addItemToInventory("Potion")
		if hasSecret == true:
			dialogText = dogDialogTextWithSecret
	elif player.hasItem("Key"):
		dialogText = keyDialogText
		spawnDialog()
	else:
		$AnimationPlayer.play("MimicShow")
		dialogText = [
			"What, you thought you'd just open me?",
			"Thanks for the meal!",
			"TODO: Add Game Over screen"
		]




func _on_DialogBox_dialogFinished():	
	if player.hasItem("Key") && player.currentForm !=  "Dog":
		player.removeItemFromInventory("Key")
		self.queue_free()
	if player.currentForm == "Dog":
		self.queue_free()
	elif !player.hasItem("Key"):
		get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name):
	spawnDialog()
	pass # Replace with function body.
