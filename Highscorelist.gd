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

onready var mono_font : Font = preload("res://Monogram.tres");
onready var list : VBoxContainer = $Panel/ScrollContainer/Entries
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
		var entries : Array = json.result.highscores;
		var index : int = 0;
		
		# Loop through the received highscore array
		while index < entries.size():
			var time : float = entries[index][0];
			var name : String = entries[index][1];
			
			# Create a new Label for every entry, style it and ...
			var label : RichTextLabel = RichTextLabel.new();
			label.rect_min_size = Vector2(list.get_parent_area_size().x, 0);
			label.bbcode_enabled = true;
			label.bbcode_text = (index + 1) as String + ".[indent]%.3f sec/s by %s[/indent]" % [time, name];
			mono_font.size = 8;
			label.add_font_override("normal_font", mono_font);
			label.fit_content_height = true;
			
			# ... add it to the list parent
			list.add_child(label);
			index+=1;
