extends RichTextLabel

## Count the timer up and show it in the overlay
func _physics_process(delta):
	Global.time+=delta;
	bbcode_text="[center]%.3f sec/s[/center]" % (Global.time)
