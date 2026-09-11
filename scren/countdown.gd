extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fade():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.finished.connect(self.queue_free)
	
func setup(t:String):
	text = t
	if (t == "3"):
		label_settings.font_color = Color(1.0, 0.914, 0.0, 1.0)
	elif (t == "2"):
		label_settings.font_color = Color(1.0, 0.694, 0.0, 1.0)
	else:
		label_settings.font_color = Color(1.0, 0.439, 0.094, 1.0)
