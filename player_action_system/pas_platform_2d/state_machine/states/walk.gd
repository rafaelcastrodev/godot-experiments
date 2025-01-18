extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: WALK
====================== """

func enter() -> void:
	super();
	owner.character_current_speed = Globals.PLAYER_WALKING_SPEED;
	owner.AnimatedSprite.play(Globals.PlayerStates.WALK);
#}

func exit() -> void:
	super();
#}

func physics_update(_delta: float) -> void:

	if owner.Character.velocity.y > 0:
		state_transitioned.emit(self, Globals.PlayerStates.FALL);
		return;

	if not owner.is_moving:
		state_transitioned.emit(self, Globals.PlayerStates.IDLE);
		return;

	if owner.is_sneaking:
		state_transitioned.emit(self, Globals.PlayerStates.SNEAK);
		return;

	if not owner.is_walking:
		state_transitioned.emit(self, Globals.PlayerStates.RUN);
		return;
#}
