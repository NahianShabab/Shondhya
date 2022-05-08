extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_pressed("Forward"):
		$AudioStreamPlayer.play();
	elif Input.is_action_pressed("Backward"):
		$AudioStreamPlayer.stop();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
