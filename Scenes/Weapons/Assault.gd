extends Spatial



var ammo=100;

func _ready():
	pass 
func fire():
	if $AnimationPlayer.is_playing():
		pass
	elif ammo<=0:
		pass
	else:
		$AnimationPlayer.play("Fire");
		pass


