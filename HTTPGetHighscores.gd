extends HTTPRequest

func _ready():
	request("https://raw.githubusercontent.com/greenpixels/3Levels/main/highscores.json", ["content-type: application/json"]);
	
