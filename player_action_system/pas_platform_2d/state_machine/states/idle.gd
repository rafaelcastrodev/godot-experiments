extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: IDLE
====================== """

func enter() -> void:
	super();
	owner.AnimatedSprite.play(Globals.PlayerStates.IDLE);
#}

func exit() -> void:
	super();
#}

func physics_update(_delta: float) -> void:

	if owner.Character.velocity.y > 0:
		state_transitioned.emit(self, Globals.PlayerStates.FALL);
		return;

	if owner.is_sneaking:
		state_transitioned.emit(self, Globals.PlayerStates.SNEAK);
		return;

	if not owner.is_moving:
		return;

	if owner.is_walking:
		state_transitioned.emit(self, Globals.PlayerStates.WALK);
		return;

	state_transitioned.emit(self, Globals.PlayerStates.RUN);
#}
