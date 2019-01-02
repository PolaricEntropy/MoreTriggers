//=============================================================================
// StateTrigger.
//
// Changes the state of an Actor.
//
// By: PolaricEntropy (for Deus Ex: Revision)
//=============================================================================
class StateTrigger extends MoreTriggers;

var() Name NewState;

function BeenTriggered(Actor Other, Actor instigator)
{
	local Actor A;

	if (Event != '')
		foreach AllActors (class'Actor', A, Event)
			A.GotoState(NewState);
}

defaultproperties
{
}