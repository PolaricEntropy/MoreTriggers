//=============================================================================
// BlowUpMoverTrigger
//
// Blows up the movers with the matching event.
//
// By: PolaricEntropy
//=============================================================================
class BlowUpMoverTrigger extends MoreTriggers;

function BeenTriggered(Actor Other, Actor Instigator)
{
	local DeusExMover m;
		
	if (Event != '')
	{		
		foreach AllActors(class'DeusExMover', m, Event)
			m.BlowItUp(Pawn(Instigator));
	}
}

defaultproperties
{
}