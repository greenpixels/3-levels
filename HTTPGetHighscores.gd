extends HTTPRequest

func _ready():
	var _is_ok : bool = request("https://raw.githubusercontent.com/greenpixels/3Levels/main/highscores.json", ["content-type: application/json"]);
	
