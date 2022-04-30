extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal _OnBoxOpen(item)
signal _MoneyChanged(money)

export(float) var itemChance = 0.8
export(Array, Resource) var possibleItems
export(int) var price

export(AudioStream) var failAudio

export(Resource) var currentItem

var clickOk = true
var animBackward = false

var money = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	
	randomize()
	PullNewItem()
	
	emit_signal("_MoneyChanged", money)
	


func PullNewItem():
	
	var randVal = randi()
	
	currentItem = null
	
	var currentChance = ((randVal % 100) as float) / (100 as float)
	
	if currentChance >= 1 - itemChance : 
		currentItem = possibleItems[randVal % possibleItems.size()]
	
	

func ReleaseItem():
	
	emit_signal("_OnBoxOpen", currentItem)
	
	if(currentItem == null):
		$AudioStreamPlayer.stream = failAudio
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stream = currentItem.audio
		$AudioStreamPlayer.play()
		
		money += currentItem.price
	
		emit_signal("_MoneyChanged", money)
	

func _OnInputEvent(viewport, event, shape_idx):
	
	var mouseEvent = (event as InputEventMouseButton)
	
	if mouseEvent != null && mouseEvent.button_index == BUTTON_LEFT && event.is_pressed() && clickOk:
		
		if money >= price:
			
			money -= price
	
			emit_signal("_MoneyChanged", money)
			
			$AnimationPlayer.play("Box_Open")
			
		else:
			print("Not enough money")
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
		
	


func _OnFadeOut():
	$AnimationPlayer.play_backwards("Box_Open")
