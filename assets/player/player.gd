extends KinematicBody2D

const MAX_SPEED : float = 200.0;
const ACCELERATION : float = 200.0;
const FRICTION : float = 100.0;
const GRAV : float = 2000.0;
const JUMP_STRENGTH = 200;
var velocity : Vector2 = Vector2.ZERO;
var vsp : float = 0.0;

onready var animation_player : AnimationPlayer = $AnimationPlayer;
onready var sprite : Sprite = $Sprite;

func _physics_process(delta):
	
	## Horizontal movement
	var horizontal_input : float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	
	if(horizontal_input != 0.0 and abs(velocity.x) < MAX_SPEED):
		velocity.x += ACCELERATION * horizontal_input * delta;
	else:
		velocity.x *= 0.75;
	
	## Vertical movement
	if(Input.is_action_just_pressed("ui_up")):
		velocity.y-=JUMP_STRENGTH;
	 
	## Apply collision
	velocity = move_and_slide(velocity, Vector2(0,1));
	
	if(velocity.y == 0.0):
		vsp = 0.0;
	
	## Set animation
	if(velocity.y > 0.0):
		animation_player.play("Fall");
	elif(velocity.y < 0.0):
		animation_player.play("Rise");
	else:
		if velocity.x as int != 0.0:
			animation_player.play("Run");
			sprite.flip_h = velocity.x < 0;
		else:
			animation_player.play("Idle");
	
	animation_player.playback_speed = (abs(velocity.x)/MAX_SPEED) + 0.5;	
