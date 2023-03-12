extends Area2D

@export var current_level_image : Texture2D;

var icase;

var current_board = [];

func _ready():
	assert(current_level_image != null, "Level image must not be null");
	assert(current_level_image.get_width() == current_level_image.get_height(), "Level image must have width == height");

	init_board();

	print(current_board);

	# tentative d'ajout d'une case
	var case = preload("res://src/main/Case.tscn").instantiate();
	add_child(case);
	icase = case;
	pass

func _process(_delta):
	print(icase);
	pass

# We could have directly initialized the board in it's target 
# state, but this method is here to show how to initialize 
# 2D arrays
func init_board():
	for x in 4:
		current_board.append([]);
		for y in 4:
			current_board[x].append(true);
	current_board[3][3] = false;

