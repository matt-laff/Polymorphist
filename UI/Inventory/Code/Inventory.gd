extends Node2D

#
#const slotClass = preload("res://UI/Inventory/Code/SlotTemplate.gd")
onready var numSlots = $InvSlotContainer.get_children()
var heldItem = null

func _ready():
	self.hide()
	self.set_as_toplevel(true)
	for invSlot in numSlots:
		invSlot.connect("gui_input", self, "updateInvSlot", [invSlot])
		
func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
	self.position = Vector2(get_owner().position.x + 30, get_owner().position.y - 230)
		
func updateInvSlot(event: InputEvent, invSlot: InventorySlot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if heldItem != null: # holding an item
				if invSlot.item == null: # no item in slot
					invSlot.insertItem(heldItem)
					heldItem = null
				else: # invSlot has item, and heldItem is not potion
					var tempItem = invSlot.item
					invSlot.grabItem()
					tempItem.global_position = event.global_position
					invSlot.insertItem(heldItem)
					heldItem = tempItem
			else: #Held item is null (empty)
				if invSlot.item != null:
					heldItem = invSlot.item
					invSlot.grabItem()
					heldItem.global_position = get_global_mouse_position()
		elif event.button_index == BUTTON_RIGHT && event.pressed:
				if heldItem is Potion && invSlot.item != null: # holding a potion and item in slot
					if invSlot.item.canTransform:
						get_owner().updateForm(invSlot.item.formChange)
						heldItem.queue_free()
						heldItem = null
						invSlot.item.queue_free()
						invSlot.item = null
		elif event.button_index == BUTTON_MIDDLE && event.pressed:
			if heldItem == null && invSlot.item != null:
				invSlot.item.queue_free()
				invSlot.item = null

func _input(_event):
	if heldItem:
		heldItem.global_position = get_global_mouse_position()
		
func addItem(itemName) -> bool:
	for invSlot in numSlots:
		if invSlot.item == null:
			invSlot.itemInit(itemName)
			return true
	return false
