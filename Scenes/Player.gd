extends KinematicBody
enum MoveState{IDLE,RUNNING};
var moveState=MoveState.IDLE;
var velocity=Vector3.ZERO;
var upDirection=Vector3(0,1,0);
var moveSpeed=5;
var gravity=Vector3(0,-9.8,0);

func _ready():
	pass 

func _process(delta):
	pass
	
func _physics_process(delta):
	var direction=Vector3.ZERO;
	if is_on_floor():
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
			moveState=MoveState.RUNNING;
			var forward=global_transform.basis.z;
			var right=global_transform.basis.x;
			velocity.z=(forward*direction.z+right*direction.x).z;
			velocity.x=(forward*direction.z+right*direction.x).x;
			velocity=velocity.normalized()*moveSpeed;
	elif moveState!=MoveState.IDLE:
		moveState=MoveState.IDLE;
		velocity=Vector3.ZERO;
		pass
	velocity+=velocity+gravity*delta;
	velocity=move_and_slide(velocity,upDirection);
		
func _input(event):
	pass
