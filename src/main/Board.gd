extends Area2D

@export var current_level_image : Texture2D;
var current_board = [];
var current_board_cases = [];
enum Direction{ LEFT, RIGHT, TOP, BOTTOM, NONE};


func _ready():
	assert(current_level_image != null, "Level image must not be null");
	assert(current_level_image.get_width() == current_level_image.get_height(), "Level image must have width == height");

	init_board();
	shuffle_board();
	for i in 4:
		for j in 4:
			if(current_board[i][j] == 0):
				current_board_cases[i].append(null)
				continue;
			var case = preload("res://src/main/Case.tscn").instantiate();
			case.position.x = float(j * 192.0);
			case.position.y = float(i * 192.0);
			var sprite = case.get_node("Sprite2D") as Sprite2D;
			sprite.region_rect.position.x = ((current_board[i][j]-1) % 4 as int) * 192;
			sprite.region_rect.position.y = ((current_board[i][j]-1) / 4 as int) * 192;
			case.connect("case_clicked", _on_case_clicked);
			add_child(case);
			current_board_cases[i].append(case);


	# tentative d'ajout d'une case
	
	pass

func _on_case_clicked(x, y):
	var direction = compute_direction(x,y);
	print(current_board);
	
	match direction:
		Direction.LEFT:
			current_board[y][x-1] = current_board[y][x];
			current_board[y][x] = 0;
			current_board_cases[y][x-1] = current_board_cases[y][x];
			current_board_cases[y][x-1].position.x-=192;
		Direction.RIGHT:
			current_board[y][x+1] = current_board[y][x];
			current_board[y][x] = 0;
			current_board_cases[y][x+1] = current_board_cases[y][x];
			current_board_cases[y][x+1].position.x+=192;
		Direction.TOP:
			current_board[y-1][x] = current_board[y][x];
			current_board[y][x] = 0;
			current_board_cases[y-1][x] = current_board_cases[y][x];
			current_board_cases[y-1][x].position.y-=192;
		Direction.BOTTOM:
			current_board[y+1][x] = current_board[y][x];
			current_board[y][x] = 0;
			current_board_cases[y+1][x] = current_board_cases[y][x];
			current_board_cases[y+1][x].position.y += 192;
	pass # Replace with function body.


# We could have directly initialized the board in it's target 
# state, but this method is here to show how to initialize 
# 2D arrays
func init_board():
	for x in 4:
		current_board.append([]);
		current_board_cases.append([]);
		for y in 4:
			current_board[x].append(x*4 + y + 1);
	current_board[3][3] = 0;


func shuffle_board():
	var rng = RandomNumberGenerator.new();
	for i in 100:
		var x = rng.randi_range(0, 3);
		var y = rng.randi_range(0, 3);
		var x2 = rng.randi_range(0, 3);
		var y2 = rng.randi_range(0, 3);

		var tmp = current_board[x][y];
		current_board[x][y] = current_board[x2][y2];
		current_board[x2][y2] = tmp

func compute_direction(x, y):
	if x > 0 && current_board[y][x-1] == 0:
		return Direction.LEFT
	if y > 0 && current_board[y-1][x] == 0:
		return Direction.TOP
	if x < 3 && current_board[y][x+1] == 0:
		return Direction.RIGHT
	if y < 3 && current_board[y+1][x] == 0:
		return Direction.BOTTOM
	return Direction.NONE
