extends Panel

class_name InventorySlot

var itemClass: PackedScene = null
var item: Node = null


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
	
