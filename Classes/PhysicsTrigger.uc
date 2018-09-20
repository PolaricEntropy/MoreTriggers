//=============================================================================
// PhysicsTrigger
//
// Allows you to change the physics state on specified actors.
//
// By: Unknown, probably Sheep.
// Modified by: bjorn98009_91 to support MoreTriggers and a custom physics property (instead of just Falling).
//=============================================================================

class PhysicsTrigger expands MoreTriggers;

var(PhysicsTrigger) const EPhysics NewPhysicsState;

function BeenTriggered(Actor Instigator)
{
	local Actor A;

    if (Event != '')
       {
	   foreach AllActors(Class'Actor', A, event)
	           if (A != none)
					A.SetPhysics(NewPhysicsState);
       }
}

defaultproperties
{
	NewPhysicsState=PHYS_Falling
}
