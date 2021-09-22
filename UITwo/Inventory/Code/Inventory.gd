extends Control
class_name Inventory
onready var formDisplay = $VBoxContainer/FormDisplay/CenterContainer/FormImage
onready var descriptionText = $VBoxContainer/DescriptionPanel/RichTextLabel
onready var numSlots = $VBoxContainer/InventorySlotContainer.get_children()

var heldItem = null
var prevSlot = null

func _ready():
	self.set_as_toplevel(true)
	for invSlot in numSlots:
		invSlot.connect("slotEntered", self, "updateFormDisplay")
		invSlot.connect("mouseInput", self, "updateInvSlot")


func _process(_delta):
	if get_owner() != null:
		self.rect_global_position = get_owner().global_position
	if heldItem != null:
		$HeldItemIcon.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("inventory"):
		if heldItem != null:
			if prevSlot is InventorySlot:
				placeItem(prevSlot)
		self.visible = !self.visible


func updateFormDisplay(invSlot):
	if invSlot != null:
		formDisplay.texture = invSlot.formData
		descriptionText.text = invSlot.itemDescription
	else:
		formDisplay.texture = null


func updateInvSlot(event, invSlot):
	if event.button_index == BUTTON_LEFT && event.pressed == true:
		if heldItem != null && invSlot.myItem == null:
			placeItem(invSlot)
		elif heldItem == null && invSlot.myItem != null:
			pickupItem(invSlot)
		elif heldItem != null && invSlot.myItem != null:
			swapItems(invSlot)



func addItem(item):
	for invSlot in numSlots:
		if invSlot.myItem == null:
			invSlot.itemInit(item)
			return true
	return false


func pickupItem(invSlot):
	heldItem = invSlot.grabItem()
#	add_child(heldItem)
	$HeldItemIcon.texture = heldItem.getIconTexture()
	$HeldItemIcon.global_position = get_global_mouse_position()
	$HeldItemIcon.scale = Vector2(.8,.8)
#	heldItem.global_position = get_global_mouse_position()
	prevSlot = invSlot

func placeItem(invSlot):
#	remove_child(heldItem)
	$HeldItemIcon.texture = null
	invSlot.insertItem(heldItem)
	heldItem = null

func swapItems(invSlot):
	var temp = invSlot.grabItem()
	placeItem(invSlot)
	heldItem = temp
#	add_child(heldItem)
	$HeldItemIcon.texture = heldItem.getIconTexture().texture
