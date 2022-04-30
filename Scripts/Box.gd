extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal _OnBoxOpen(item)

export(float) var itemChance = 0.8
export(Array, Resource) var possibleItems

export(Resource) var currentItem

var clickOk = true
var animBackward = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	PullNewItem()
	


func PullNewItem():
	
	var randVal = randi()
	
	currentItem = null
	
	var currentChance = ((randVal % 100) as float) / (100 as float)
	
	if currentChance >= 1 - itemChance : 
		currentItem = possibleItems[randVal % possibleItems.size()]
	
	

func ReleaseItem():
	
	if currentItem == null:
		print("You found nothing in the box...")
		$AnimationPlayer.play_backwards("Box_Open")
	else:
		print("You have found: " + (currentItem as Item).name)
		emit_signal("_OnBoxOpen", currentItem)
	

func _OnInputEvent(viewport, event, shape_idx):
	
	var mouseEvent = (event as InputEventMouseButton)
	
	if mouseEvent != null && mouseEvent.button_index == BUTTON_LEFT && event.is_pressed() && clickOk:
		
		
		$AnimationPlayer.play("Box_Open")
		
#		ReleaseItem()
#		PullItem()
		
		clickOk = false


func _OnAnimationFinished(anim_name):
	
	if(!animBackward):
		ReleaseItem()
		PullNewItem()
		animBackward = true
	else:
		animBackward = false
		clickOk = true
		print("Box Ready")
		
	


func _OnFadeOut():
	$AnimationPlayer.play_backwards("Box_Open")
