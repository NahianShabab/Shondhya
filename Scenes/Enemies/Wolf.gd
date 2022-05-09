extends KinematicBody

var velocity=Vector3();
export var speed:float=0.1;

func _ready():
	pass
	
func _physics_process(delta):
	var direction=global_transform.basis.z;
	velocity.x=(direction*speed).x;
	velocity.z=(direction*speed).z;
	velocity.y-=(9.8*delta);
	velocity=move_and_slide(velocity,Vector3.UP);
	print(is_on_floor());
	pass
