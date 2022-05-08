extends Spatial



var ammo=100;
var bulletDecal=preload("res://Decals/AssaultBulletDecal.tscn");

func _ready():
	pass
func fire():
	if $AnimationPlayer.is_playing():
		pass
	elif ammo<=0:
		pass
	else:
		$AnimationPlayer.play("Fire");
		ammo-=1;
		
		#raycast (hitscan weapon)
		#var spaceState=get_world().direct_space_state;
		#var result=spaceState.intersect_ray($CrossHairPosition.global_transform.origin,
		#$CrossHairPosition.global_transform.origin+$CrossHairPosition.global_transform.basis.z.normalized()*1000,
		#[self]);
		var ray=$CrossHairPosition/RayCast;
		ray.enabled=true;
		if(ray.get_collider()!=null):
			var collider=ray.get_collider();
			if(collider.is_in_group("Environment")):
				var bulletDecalInstance=bulletDecal.instance();
				bulletDecalInstance.global_transform.origin=ray.get_collision_point();
				bulletDecalInstance.look_at(ray.get_collision_point()+ray.get_collision_normal(),Vector3.UP);
				collider.add_child(bulletDecalInstance);
				print(collider);
		else:
			pass
		pass




