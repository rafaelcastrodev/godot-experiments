extends Node;
"""
GLOBALS MANAGER
"""

## CONSTANTS, ENUMS AND DICTIONARIES ==============================================================

const PlayerActions: Dictionary = {
	START = "start",
	SWAP_SKIN = "swap_skin",
	JOIN = "join",
	UP = "move_up",
	LEFT = "move_left",
	DOWN = "move_down",
	RIGHT = "move_right",
	JUMP = "jump",
	WALK = "walk",
	SNEAK = "sneak",
	ATTACK = "attack",
	INTERACT = "interact",
};

const PlayerAnimations: Dictionary = {
	IDLE = "idle",
	WALK = "walk",
	CROUCH = "crouch",
	JUMP = "jump",
	FALL = "fall",
	RUN = "run",
	SNEAK = "sneak",
	ATTACK = "attack",
	HURT = "hurt",
};

const PlayerStates: Dictionary = {
	IDLE = "idle",
	WALK = "walk",
	CROUCH = "crouch",
	JUMP = "jump",
	FALL = "fall",
	RUN = "run",
	SNEAK = "sneak",
	ATTACK = "attack",
	HURT = "hurt",
};


var GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity", 300);

const PLAYER_JUMP_HEIGHT: float = 18;
const PLAYER_JUMP_TIME_TO_APEX: float = 0.3;
## 9 Frames of game time ## Formula: FPS / (desired frames) = time in seconds;
const PLAYER_JUMP_BUFFER_TIME: float = 0.1;
## 6 Frames of game time ## Formula: FPS / (desired frames) = time in seconds;
const PLAYER_COYOTE_TIME: float = 0.1;
const FACTOR_PLAYER_JUMP_VELOCITY_HEIGHT: float = 2;
const FACTOR_PLAYER_GRAVITY_JUMP_HEIGHT: float = 2;
const FACTOR_POW_PLAYER_JUMP_TIME_APEX: float = 2;
const FACTOR_PLAYER_GRAVITY_FALL: float = 2;
const FACTOR_PLAYER_GROUND_DAMPING: float = 1.0;
const FACTOR_PLAYER_AIR_DAMPING: float = 1.0;

const PLAYER_MAX_SPEED: float = 180.0;
const PLAYER_RUNNING_SPEED: float = 80.0;
const PLAYER_WALKING_SPEED: float = 40.0;
const PLAYER_SNEAKING_SPEED: float = 15.0;
const PLAYER_GROUND_DAMPING: float = 0.5;
const PLAYER_AIR_DAMPING: float = 0.2;
const PLAYER_JUMP_VELOCITY = (PLAYER_JUMP_HEIGHT * FACTOR_PLAYER_JUMP_VELOCITY_HEIGHT) * (-1) / PLAYER_JUMP_TIME_TO_APEX;
const PLAYER_GRAVITY = (PLAYER_JUMP_HEIGHT * FACTOR_PLAYER_GRAVITY_JUMP_HEIGHT) / pow(PLAYER_JUMP_TIME_TO_APEX, FACTOR_POW_PLAYER_JUMP_TIME_APEX);
const PLAYER_GRAVITY_FALL: float = PLAYER_GRAVITY * FACTOR_PLAYER_GRAVITY_FALL;
