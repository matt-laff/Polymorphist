extends Panel

class_name InventorySlot

var itemClass: PackedScene = null
var item: Node = null

var defaultTexture = preload("res://UI/Inventory/Assets/inventoryItemSlot.png")
var defaultStyle: StyleBoxTexture = null

var activeItemTexture = preload("res://UI/Inventory/Assets/inventoryActiveItemSlot.png")
var activeItemStyle: StyleBoxTexture = null

var isActive = false

func _ready():
	activeItemStyle = StyleBoxTexture.new()
	defaultStyle = StyleBoxTexture.new()
	activeItemStyle.texture = activeItemTexture
	defaultStyle.texture = defaultTexture


func itemInit(itemName):
	itemClass = load("res://Items/Code/" + itemName + ".tscn")
	item = itemClass.instance()
	add_child(item)
	item.position = $PanelCenter.position
	item.disableCollision()


func grabItem():
	remove_child(item)
	find_parent("Inventory").add_child(item)
	item = null
	
func insertItem(newItem):
	item = newItem
	item.position = $PanelCenter.position
	find_parent("Inventory").remove_child(item)
	add_child(item)
	
	
func updateStyle():
	if isActive == true:
		set('custom_styles/panel', activeItemStyle)
		isActive = false
	elif item == null:
		set('custom_styles/panel', defaultStyle)
	else:
		set('custom_styles/panel', defaultStyle)
	
