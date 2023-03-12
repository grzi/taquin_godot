extends Node2D

signal case_clicked(x, y);

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var click_event = event as InputEventMouseButton;
		if click_event.button_index == 1 && click_event.pressed:
			var x = position.x / 192 as int;
			var y = position.y / 192 as int;
			case_clicked.emit(x,y);
			
	pass # Replace with function body.
