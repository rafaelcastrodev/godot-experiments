extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: JUMP
====================== """

func enter() -> void:
	super();
	owner.is_jumping = true;
	owner.Character.velocity.y = Globals.PLAYER_JUMP_VELOCITY;
	owner.AnimatedSprite.play(Globals.PlayerStates.JUMP);
#}

func exit() -> void:
	owner.is_jumping = false;
	super();
#}

func physics_update(_delta: float) -> void:

	if not owner.is_pressing_jump or owner.Character.velocity.y > 0:
		state_transitioned.emit(self, Globals.PlayerStates.FALL);
		return;
#}
