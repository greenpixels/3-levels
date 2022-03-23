extends Area2D

onready var list : ItemList = $Entries;
onready var camera : Camera2D = $Camera2D;
signal player_entered_highscorelist(camera);
signal player_exited_highscorelist(camera);

## Send out signals containing this nodes camera information when player enters the area
func _on_highscorelist_body_entered(body : Object):
	emit_signal("player_entered_highscorelist", camera)
func _on_highscorelist_body_exited(body : Object):
	emit_signal("player_exited_highscorelist", camera)

## Gets the highscorelist from the github repository and puts it into a item list
func _on_HTTPGetHighscores_request_completed(result, response_code, headers, body):
	var json : JSONParseResult = JSON.parse(body.get_string_from_utf8());
	if (json.error == OK):
		var entries = json.result.highscores;
		var index = 0;
		while index < entries.size():
			var time : float = entries[index][0];
			var name : String = entries[index][1];
			list.add_item((index + 1) as String + ")  %.3f sec/s by %s" % [time, name]);
			index+=1;
