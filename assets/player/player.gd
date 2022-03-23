#    A simple jump-and-run game-project made with godot.
#    Copyright (C) 2022 Sven | greenpixels_
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

extends KinematicBody2D

const MAX_SPEED : float = 150.0;
const ACCELERATION : float = 800.0;
const GRAV : float = 5000.0;
const JUMP_STRENGTH : float = 190.0;
var velocity : Vector2 = Vector2.ZERO;
var vsp : float = 0.0;
var wall_jump_timer : float = 0.0;
const WALL_JUMP_TIME : float = 0.5;

onready var animation_player : AnimationPlayer = $AnimationPlayer;
onready var sprite : Sprite = $Sprite;

func _physics_process(delta):
	## Horizontal movement
	var horizontal_input : float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");

	if(horizontal_input != 0.0):
		velocity.x += ACCELERATION * horizontal_input * delta;
		sprite.flip_h = horizontal_input != 1;
	else:
		velocity.x -= sign(velocity.x)*ACCELERATION*delta;
		if(abs(velocity.x) < ACCELERATION*delta):
			 velocity.x = 0.0;

	if(abs(velocity.x) > MAX_SPEED):
		velocity.x = sign(velocity.x)*MAX_SPEED;
	
	## Vertical movement
	if(vsp < 800):
		vsp+=GRAV*delta;
	
	### Wall Jump
	if(is_on_wall() and !is_on_floor()):
		if(horizontal_input):
			wall_jump_timer = WALL_JUMP_TIME;
		if(wall_jump_timer > 0):
			velocity.y = 0.0;
			vsp = 0.0;
			if(Input.is_action_just_pressed("ui_up")):
				$JumpSound.play();
				velocity.y-=JUMP_STRENGTH;
				velocity.x-=horizontal_input*(JUMP_STRENGTH/2);
			else:
				wall_jump_timer-=delta;
	
	### Jump
	if(is_on_floor()):
		vsp = 0;
		if(Input.is_action_just_pressed("ui_up")):
			velocity.y-=JUMP_STRENGTH;
			$JumpSound.play();
	 
	velocity.y+=vsp*delta;

	## Apply collision
	var was_on_floor : bool = is_on_floor();
	velocity = move_and_slide(velocity, Vector2(0, -1), true);
	if(is_on_floor() and !was_on_floor):
		$LandSound.play();
	
	## Set animation
	if(velocity.y > 0.0):
		animation_player.play("Fall");
	elif(velocity.y < 0.0):
		animation_player.play("Rise");
	else:
		if velocity.x as int != 0.0:
			animation_player.play("Run");
		else:
			if(is_on_wall() and !is_on_floor() and wall_jump_timer > 0):
				animation_player.play("Slide");
			else:
				animation_player.play("Idle");
	
	animation_player.playback_speed = (abs(velocity.x)/MAX_SPEED) + 0.5;	

func _on_exit_area_entered(_body):
	## Switch scenes when colliding with exit-door
	var current_scene : String = get_tree().get_current_scene().get_name();
	var _is_ok : bool;
	match(current_scene):
		"Level1" : 
			_is_ok = get_tree().change_scene("res://Level2.tscn");
		"Level2" : 
			_is_ok = get_tree().change_scene("res://Level3.tscn");
		"Level3" : 
			_is_ok = get_tree().change_scene("res://Level4.tscn");
		"Level4" : 
			_is_ok = get_tree().change_scene("res://Level1.tscn");
			Global.time = 0;

## Toggle leaderboard-camera
func _on_Highscorelist_player_entered_highscorelist(camera : Camera2D):
	camera.make_current();
func _on_Highscorelist_player_exited_highscorelist(_camera  : Camera2D):
	$Camera2D.make_current();
	
	
