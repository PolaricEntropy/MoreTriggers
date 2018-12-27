//=============================================================================
// UnlitTrigger
//
// Toggles bUnlit on actors.
//
// By: PolaricEntropy
//=============================================================================
class UnlitTrigger extends MoreTriggers;

function BeenTriggered(Actor Other, Actor Instigator)
{
	local Actor A;

    if (Event != '')
    {
		foreach AllActors(Class'Actor', A, event)
		{
			if (A != none)
				A.bUnlit = !A.bUnlit;
		}
    }
}

defaultproperties
{
}
