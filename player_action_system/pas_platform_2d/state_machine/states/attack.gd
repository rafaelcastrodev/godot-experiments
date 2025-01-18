extends FiniteState;

""" ======================
PAS_PLATFORM_2D
STATE: ATTACK
====================== """

func on_animation_finished() -> void:
	super();
	state_transitioned.emit(self, Globals.PlayerStates.IDLE);
	owner.is_attacking = false;
#}

func enter() -> void:
	super();
	owner.is_attacking = true;
	owner.AnimatedSprite.play(Globals.PlayerStates.ATTACK);
#}

func exit() -> void:
	super();
	owner.is_attacking = false;
#}
