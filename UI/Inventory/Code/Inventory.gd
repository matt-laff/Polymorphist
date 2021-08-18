extends Node2D

signal activeItemSlotUpdated

onready var screenSize = get_viewport_rect().size
onready var numSlots = $InvSlotContainer.get_children()
var heldItem = null

var activeItemSlotSet = false
var activeItemSlot


var inventorySlots = []
var invIdx = 0

func _ready():
	self.hide()
	self.set_as_toplevel(true)
	for invSlot in numSlots:
		invSlot.connect("gui_input", self, "updateInvSlot", [invSlot])
		connect("activeItemSlotUpdated", invSlot, "updateStyle")
		inventorySlots.append(invSlot)
	setActiveItemSlot(inventorySlots[0])

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		self.visible = !self.visible
	self.position = Vector2(get_owner().position.x + 70, get_owner().position.y - 40)
	

	
#	if activeItemSlot.item != null:
#		print(activeItemSlot.item.itemName)
##	
#	self.position.x = clamp(position.x, 0, screenSize.x - 230)
##	self.position.y = clamp(position.y, 0, screenSize.y)

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
					if invSlot.item.canTransform && invSlot.item.formChange != get_owner().currentForm:
						get_owner().updateForm(invSlot.item.formChange)
						heldItem.queue_free()
						heldItem = null
						invSlot.item.queue_free()
						invSlot.item = null
					elif invSlot.item is Potion:
						get_owner().updateForm("Skeleton")
						heldItem.queue_free()
						heldItem = null
						invSlot.item.queue_free()
						invSlot.item = null
		elif event.button_index == BUTTON_MIDDLE && event.pressed:
			if heldItem == null && invSlot.item != null:
				invSlot.item.queue_free()
				invSlot.item = null

func _input(event):
	if heldItem:
		heldItem.global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("testKey"):
		setActiveItemSlot(inventorySlots[invIdx])
		invIdx += 1
		print(invIdx)
		if invIdx > 5:
			invIdx = 0
		
func addItem(itemName) -> bool:
	for invSlot in numSlots:
		if invSlot.item == null:
			invSlot.itemInit(itemName)
			return true		
	return false
	
func hasItem(itemName) -> bool:
	for invSlot in numSlots:
		if invSlot.item != null:
			if invSlot.item.itemName == itemName:
				return true
	return false
	
func removeItem(itemName):
	for invSlot in numSlots:
		if invSlot.item != null:
			if invSlot.item.itemName == itemName:
				invSlot.item.queue_free()
				invSlot.item = null
				
func setActiveItemSlot(invSlot: InventorySlot):
	if invSlot.item != null:
		print(invSlot.item.itemName)
	activeItemSlot = invSlot
	activeItemSlot.isActive = true
#	activeItemSlotSet = true
	print("set active item slot")
	emit_signal("activeItemSlotUpdated")
		

