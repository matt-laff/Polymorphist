extends Panel
class_name InventorySlot

var itemClass

signal slotEntered(myItem)
signal mouseInput(event, invSlot)

var myItem = null

var defaultTexture = preload("res://UITwo/Inventory/Assets/InventorySlotOutline.png")
var defaultStyle: StyleBoxTexture = null

var selectedTexture = preload("res://UITwo/Inventory/Assets/InventorySlotSelected.png")
var selectedStyle: StyleBoxTexture = null

var isSelected = false

func _ready():
	selectedStyle = StyleBoxTexture.new()
	defaultStyle = StyleBoxTexture.new()
	selectedStyle.texture = selectedTexture
	defaultStyle.texture = defaultTexture

func itemInit(newItem):
	itemClass = load(newItem.filename)
	myItem = itemClass.instance()
	$PanelCenter/ItemIcon.texture = myItem.getIconTexture()
	$PanelCenter/ItemIcon.scale = $PanelCenter.scale / Vector2(1.66,1.66)
#	myItem.position = $PanelCenter.position
#	add_child(myItem)
	

func insertItem(newItem):
	myItem = newItem
	myItem.position = $PanelCenter.position
	$PanelCenter/ItemIcon.texture = myItem.getIconTexture()
	$PanelCenter/ItemIcon.scale = $PanelCenter.scale / Vector2(1.66,1.66)
#	self.add_child(myItem)

	
func grabItem():
	var temp = myItem
	if myItem != null:
		$PanelCenter/ItemIcon.texture = null
#		remove_child(myItem)
	myItem = null
	return temp
	
	
func _on_Area2D_mouse_entered():
	emit_signal("slotEntered", myItem)
	updateFrame()


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		emit_signal("mouseInput", event, self)
		
func updateFrame():
	isSelected = !isSelected
	if isSelected == true:
		set('custom_styles/panel', selectedStyle)
	else:
		set('custom_styles/panel', defaultStyle)


func _on_Area2D_mouse_exited():
	updateFrame()
