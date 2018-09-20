//=============================================================================
// ActorDestroyTrigger
//
// Destroys specified stuff within its radius. Works on inventory too, so you could stick it in a doorway and have it rob the player of all his weapons when he walks through.
//=============================================================================

class ActorDestroyTrigger extends MoreTriggers;

var() bool bSubclasses; //if true, it also destroys subclasses of ClassProximityType

function Tick(float deltaTime)
{
	local Actor a;
	local Pawn pwn;

	foreach RadiusActors(ClassProximityType,a,CollisionRadius)
		if(a.class==ClassProximityType || bSubclasses)
			a.Destroy();

	//if it's a type of inventory, check if a nearby pawn is carrying it
	if(ClassIsChildOf(ClassProximityType,class'Inventory'))
		foreach RadiusActors(class'Pawn',pwn,CollisionRadius)
			foreach AllActors(ClassProximityType,a)
				if(Inventory(a).Owner==pwn)
					a.Destroy();
}

function bool IsRelevant(Actor other)
{
	return False;
}

defaultproperties
{
	bSubclasses=True
}