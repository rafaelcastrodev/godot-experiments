extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: FALL
====================== """

func enter() -> void:
	super();
	owner.is_falling = true;
	owner.AnimatedSprite.play(Globals.PlayerStates.FALL);
#}

func exit() -> void:
	super();
	owner.is_falling = false;
#}

func physics_update(_delta: float) -> void:

	if owner.Character.is_on_floor():
		state_transitioned.emit(self, Globals.PlayerStates.IDLE);
		return;
#}
