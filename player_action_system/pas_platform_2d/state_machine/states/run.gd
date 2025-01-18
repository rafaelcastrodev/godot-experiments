extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: RUN
====================== """

func enter() -> void:
	super();
	owner.is_running = true;
	owner.character_current_speed = Globals.PLAYER_RUNNING_SPEED;
	owner.AnimatedSprite.play(Globals.PlayerStates.RUN);
#}

func exit() -> void:
	super();
	owner.is_running = false;
#}

func physics_update(_delta: float) -> void:

	if owner.Character.velocity.y > 0:
		state_transitioned.emit(self, Globals.PlayerStates.FALL);
		return;

	if not owner.is_moving:
		state_transitioned.emit(self, Globals.PlayerStates.IDLE);
		return;

	if owner.is_walking:
		state_transitioned.emit(self, Globals.PlayerStates.WALK);
		return;

	if owner.is_sneaking:
		state_transitioned.emit(self, Globals.PlayerStates.SNEAK);
		return;
#}
