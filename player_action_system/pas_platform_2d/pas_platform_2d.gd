class_name PAS_Platform2D
extends PlayerActionSystem

""" ======================
PAS_PLATFORM_2D
Manage States and Inputs related to state transitions for a 2D platformer
====================== """

@export var Character: Player;

var character_initial_state: String = Globals.PlayerStates.IDLE;

var character_current_speed: float;
var character_direction: int;
var fresh_direction: int;
var movement_damping: float;
var movement_damping_factor: float;
var can_move: bool = true;
var can_roam: bool = true;
var can_jump: bool = true;
var can_attack: bool = true;
var is_moving: bool = false;
var is_running: bool = false;
var is_walking: bool = false;
var is_sneaking: bool = false;
var is_attacking: bool = false;
var is_jumping: bool = false;
var is_jump_just_pressed: bool = false;
var is_pressing_jump: bool = false;
var is_jump_buffer: bool = false;
var is_coyote_time: bool = false;
var is_falling: bool = false;
var is_hurt: bool = false;
var was_on_floor: bool = false;

@onready var StateMachine: FiniteStateMachine = $StateMachine;
@onready var JumpBufferTimer: Timer = $Timers/JumpBufferTimer;
@onready var CoyoteTimer: Timer = $Timers/CoyoteTimer;
@onready var AnimatedSprite: AnimatedSprite2D;

""" BUILT-IN METHODS ====================== """

func _ready() -> void:
	JumpBufferTimer.timeout.connect(_on_timeout_jump_buffer);
	CoyoteTimer.timeout.connect(_on_coyote_timer_timeout);
#}

func _physics_process(delta: float) -> void:
	_handle_input(delta);
	_handle_gravity(delta);
	_handle_movement(delta);
	_handle_animations();
#}

""" PRIVATE METHODS ====================== """

func initialize(char: Player) -> void:
	Character = char;
	AnimatedSprite = char.AnimatedSprite;
	StateMachine.initialize(Character, character_initial_state);
	Character.AnimatedSprite.animation_finished.connect(_on_animation_finished);
#}

func _handle_input(delta: float) -> void:
	if not can_move:
		return;

	if can_roam:
		_handle_direction_input(delta);

	if can_jump:
		_handle_jump_input(delta);

	if can_attack:
		_handle_attack_input();
#}

func _handle_direction_input(_delta: float) -> void:

	# Directional Input
	character_direction = _get_character_direction();
	var press_right = int(_get_input_pressed(Globals.PlayerActions.RIGHT));
	var press_left = int(_get_input_pressed(Globals.PlayerActions.LEFT));

	# Determine fresh direction
	if _get_input_just_pressed(Globals.PlayerActions.RIGHT):
		fresh_direction = 1;
	elif _get_input_just_pressed(Globals.PlayerActions.LEFT):
		fresh_direction = -1;

	# Handle conflicting inputs
	if press_right and press_left:
		character_direction = fresh_direction;
	elif press_right or press_left:
		character_direction = press_right - press_left;
	else:
		character_direction = 0;

	# Movement states
	is_walking = _get_input_pressed(Globals.PlayerActions.WALK);
	is_sneaking = _get_input_pressed(Globals.PlayerActions.SNEAK);
	is_moving = character_direction != 0;
#}

func _handle_jump_input(_delta: float) -> void:
	is_jump_just_pressed = _get_input_just_pressed(Globals.PlayerActions.JUMP);
	is_pressing_jump = _get_input_pressed(Globals.PlayerActions.JUMP);

	if is_jump_just_pressed:
		if Character.is_on_floor() or is_coyote_time:
			_jump();
		else:
			_handle_jump_buffer();
#}

func _handle_jump_buffer() -> void:
	is_jump_buffer = true;
	JumpBufferTimer.start(Globals.PLAYER_JUMP_BUFFER_TIME);
#}

func _handle_attack_input() -> void:
	if not is_attacking and _get_input_just_pressed(Globals.PlayerActions.ATTACK):
		StateMachine.current_state.state_transitioned.emit(StateMachine.current_state, Globals.PlayerStates.ATTACK);
	pass
#}

func _handle_gravity(delta: float) -> void:

	_handle_input_for_jump_buffer();

	if is_falling:
		if not is_coyote_time and was_on_floor:
			is_coyote_time = true;
			CoyoteTimer.start(Globals.PLAYER_COYOTE_TIME);
		Character.velocity.y += Globals.PLAYER_GRAVITY_FALL * delta;
	else:
		is_coyote_time = false;
		CoyoteTimer.stop();
		Character.velocity.y += Globals.PLAYER_GRAVITY * delta;

		if can_jump and is_jump_buffer:
			_jump();
#}

func _handle_input_for_jump_buffer() -> void:
	if not can_jump:
		return;
	is_pressing_jump = _get_input_pressed(Globals.PlayerActions.JUMP);
#}

func _jump() -> void:
	is_jump_buffer = false;
	is_coyote_time = false;
	StateMachine.current_state.state_transitioned.emit(StateMachine.current_state, Globals.PlayerStates.JUMP);
#}

func _handle_movement(_delta: float) -> void:
	was_on_floor = Character.is_on_floor();

	if character_direction != 0:
		Character.velocity.x = character_direction * character_current_speed;
		is_moving = true;
	else:
		movement_damping = Globals.PLAYER_GROUND_DAMPING;
		movement_damping_factor = Globals.FACTOR_PLAYER_GROUND_DAMPING;

		if is_falling:
			movement_damping = Globals.PLAYER_AIR_DAMPING;
			movement_damping_factor = Globals.FACTOR_PLAYER_AIR_DAMPING;

		Character.velocity.x *= (movement_damping_factor - movement_damping)
		is_moving = false;

	Character.velocity.x = clamp(Character.velocity.x, Globals.PLAYER_MAX_SPEED * (-1), Globals.PLAYER_MAX_SPEED);
	Character.move_and_slide();
#}

func _handle_animations() -> void:
	#TODO: rework
	if character_direction != 0:
		Character.AnimatedSprite.scale.x = character_direction;
#}

func _get_character_direction() -> int :

	return MultiplayerInput.get_axis(
		Character.player_device,
		Globals.PlayerActions.LEFT,
		Globals.PlayerActions.RIGHT);
#}

func _get_input_pressed(action_name: String):
	return MultiplayerInput.is_action_pressed(Character.player_device, action_name);
#}

func _get_input_just_pressed(action_name: String):
	return MultiplayerInput.is_action_just_pressed(Character.player_device, action_name);
#}


""" SIGNAL METHODS ====================== """

func _on_timeout_jump_buffer() -> void:
	is_jump_buffer = false;
#}

func _on_coyote_timer_timeout() -> void:
	is_coyote_time = false;
#}

func _on_animation_finished() -> void:
	StateMachine.current_state.on_animation_finished();
#}
