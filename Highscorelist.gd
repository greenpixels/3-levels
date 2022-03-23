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

extends Area2D

onready var list : ItemList = $Entries;
onready var camera : Camera2D = $Camera2D;
signal player_entered_highscorelist(camera);
signal player_exited_highscorelist(camera);

## Send out signals containing this nodes camera information when player enters the area
func _on_highscorelist_body_entered(_body : Object):
	emit_signal("player_entered_highscorelist", camera)
func _on_highscorelist_body_exited(_body : Object):
	emit_signal("player_exited_highscorelist", camera)

## Gets the highscorelist from the github repository and puts it into a item list
func _on_HTTPGetHighscores_request_completed(_result, _response_code, _headers, body):
	var json : JSONParseResult = JSON.parse(body.get_string_from_utf8());
	if (json.error == OK):
		var entries = json.result.highscores;
		var index = 0;
		while index < entries.size():
			var time : float = entries[index][0];
			var name : String = entries[index][1];
			list.add_item((index + 1) as String + ")  %.3f sec/s by %s" % [time, name]);
			index+=1;
