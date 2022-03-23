extends RichTextLabel

## Shows the time result
func _ready():
	bbcode_text="[center]%.3f sec/s[/center]" % (Global.time)
