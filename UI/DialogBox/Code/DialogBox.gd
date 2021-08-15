extends Control
class_name dialogBox

export var scrollSpd: float = .6
signal dialogFinished

var dialog = [
	"This is the dialog that comes from the dialogBox itself"
]

var dialogIdx = 0
var finished = false
onready var text = $RichTextLabel

func _ready():
	self.set_as_toplevel(true)
	self.set_global_position(Vector2(15, 150))
	print(self.rect_global_position)
		
func _process(_delta):
	$dialogArrow.visible = finished
	if Input.is_action_just_pressed("interact") && get_tree().paused == true:
		print("input!")
		loadDialog()
	
func loadDialog():
	if dialogIdx < dialog.size():
		pause_mode = Node.PAUSE_MODE_PROCESS
		get_tree().paused = true
		finished = false
		text.bbcode_text = dialog[dialogIdx]
		text.percent_visible = 0
		$Tween.interpolate_property(text, "percent_visible", 0, 1, scrollSpd, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		get_tree().paused = false
		print("here!")
		emit_signal("dialogFinished")
		self.queue_free()
	dialogIdx += 1

func setDialog(itemDialog):
	print("in setDialog")
	dialog.clear()
	dialog = itemDialog
	loadDialog()
	
func _on_Tween_tween_completed(_object, _key):
	finished = true
