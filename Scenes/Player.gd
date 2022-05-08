extends KinematicBody
var velocity=Vector3.ZERO;
var upDirection=Vector3(0,1,0);
var moveSpeed=15;
var airMoveSpeed=10;
var gravity=9.8;
var airFriction=3;
var jumpVelocity=5;
var mouseRelative=Vector2();
var lookSensitivity=0.8;
var maxLookAngle=90;
var minLookAngle=-90;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	pass 

func _process(delta):
	if Input.is_action_pressed("Exit"):
		get_tree().quit(0);
	if Input.is_action_pressed("Fire"):
		#TODO : fire
		$Camera/WeaponPoint/Assault.fire();
	#TODO: add ammo info 
	#$CanvasLayer/RichTextLabel.text=str($Camera/WeaponPoint/Assault.ammo);
	$UI/AmmoText.text=str($Camera/WeaponPoint/Assault.ammo);
	
	rotatePlayer(delta);
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
	#print(velocity);
		
func _input(event):
	if event is InputEventMouseMotion:
		mouseRelative=event.relative;
	pass
	
func rotatePlayer(delta):
	var xMove=mouseRelative.x;
	var yMove=mouseRelative.y;
	#move up/down the camera
	var cameraRotationDegree=yMove*lookSensitivity;
	#$Camera.rotate_x(deg2rad(clamp(cameraRotationDegree,minLookAngle,maxLookAngle)));
	$Camera.rotation_degrees.x=clamp($Camera.rotation_degrees.x-cameraRotationDegree,minLookAngle,maxLookAngle);
	
	#rotate the player 
	var playerRotationDegree=-xMove*lookSensitivity;
	rotate_y(deg2rad(playerRotationDegree));
	#if(xMove!=0):
		#print(rotation_degrees.y);
	mouseRelative=Vector2();
