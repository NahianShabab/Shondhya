extends KinematicBody
var velocity=Vector3.ZERO;
var upDirection=Vector3(0,1,0);
var moveSpeed=25;
var airMoveSpeed=10;
var gravity=9.8;
var airFriction=3;
var jumpVelocity=5;
func _ready():
	pass 

func _process(delta):
	if Input.is_action_pressed("Fire"):
		$Camera/WeaponPoint/Assault.fire();
	pass
	
func _physics_process(delta):
	var direction=Vector3.ZERO;
	if is_on_floor():
		if Input.is_action_pressed("Jump"):
			velocity.y=jumpVelocity; 
		if Input.is_action_pressed("Forward"):
			direction.z=1;
			pass
		if Input.is_action_pressed("Backward"):
			direction.z=-1;
			pass
		if Input.is_action_pressed("MoveLeft"):
			direction.x=1;
			pass
		if Input.is_action_pressed("MoveRight"):
			direction.x=-1;
			pass
	if direction!=Vector3.ZERO:
			var forward=global_transform.basis.z;
			var right=global_transform.basis.x;
			velocity.z=((forward*direction.z+right*direction.x).normalized()*moveSpeed).z;
			velocity.x=((forward*direction.z+right*direction.x).normalized()*moveSpeed).x;
	elif is_on_floor():
		velocity.x=0;
		velocity.z=0;
	else:
		velocity.x=lerp(velocity.x,0,airFriction*delta);
		velocity.z=lerp(velocity.z,0,airFriction*delta);
	velocity.y-=(gravity*delta);
	velocity=move_and_slide(velocity,upDirection);
	print(velocity);
		
func _input(event):
	pass
