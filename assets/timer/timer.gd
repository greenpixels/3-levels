extends RichTextLabel

onready var time : float = 0.0;

func _physics_process(delta):
	time+=delta;
	bbcode_text = "[center]" + (round(time) as String) +" sec/s[/center]";
