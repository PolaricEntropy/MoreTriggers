//=============================================================================
// PawnAppearTrigger
//
// Allows pawns to EnterWorld() and LeaveWorld() without requiring a MissionScript.
//=============================================================================
class PawnAppearTrigger extends MoreTriggers;

enum EEntryType
{
	ENT_Enter,
	ENT_Leave,
	ENT_Toggle
};

var() EEntryType Appear;

function BeenTriggered(Actor Other, Actor Instigator)
{

	local ScriptedPawn P;

    foreach AllActors(Class'ScriptedPawn',P, event)
	{
		if(Appear == ENT_Enter)
		{
			if(!P.bInWorld)
				P.EnterWorld();
		}
		else if(Appear == ENT_Leave)
		{
			if(P.bInWorld)
				P.LeaveWorld();
		}
		else
		{
			if(!P.bInWorld)
			   P.EnterWorld();
			else
				P.LeaveWorld();
		}
	}

}

defaultproperties
{
	Appear=ENT_Toggle
}
