//=============================================================================
// ActorAppearTrigger
//
// Makes an actor become unhidden (bHidden=false) or hidden or switch between the two. Works for decorations etc, saves MissionScripting. 
// Say you wanted some cars to pull up outside a house after the player has entered: stick the cars there, make them bHidden=true, then unhide them with this.
//=============================================================================
class ActorAppearTrigger extends MoreTriggers;

enum EEntryType
{
	ENT_Enter,
	ENT_Leave,
	ENT_Toggle
};

var() EEntryType Appear;


function BeenTriggered(Actor Other, Actor Instigator)
{

	local Actor A;

	foreach AllActors(Class'Actor',A, event)
		{
		if(Appear == ENT_Enter)
			A.bHidden=false;
		else if(Appear == ENT_Leave)
			A.bHidden=true;
		else
			A.bHidden=!A.bHidden;
		}

}

defaultproperties
{
	Appear=ENT_Toggle
}
