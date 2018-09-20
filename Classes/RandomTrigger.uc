//=============================================================================
// RandomTrigger
//
// Specify up to 16 things you want to happen: upon triggering, it'll fire off one of them, chosen at random. 
//=============================================================================

class RandomTrigger expands MoreTriggers;

var() name PossibleEvents[16];
var() bool bTouchInstead; //if true, calls events' Touch() instead of Trigger() (makes it work with teleporters)

function PostBeginPlay()
{
	local int x,y;

	y=0;

	for(x=0;x<16;x++)
		if(PossibleEvents[x]!='' && PossibleEvents[x]!='None')
			y++;

	if(y==0)
	{
		log("RandomTrigger had no events set - it has been destroyed.");
		Destroy();
	}
}

function BeenTriggered(Actor instigator)
{
	local int x;
	local Actor a;
	local deusexplayer P;

	//if(!instigator.IsA('Pawn')) return;

	//get random event, excluding blank entries
	do
	{
		x=Rand(16);
	}until(PossibleEvents[x]!='None');

	foreach AllActors(class'Actor',a,PossibleEvents[x])
	{
		if(bTouchInstead)
			a.Touch(instigator);
		else
		{
			if(!instigator.IsA('Pawn'))
			{
				P = Deusexplayer(getplayerpawn()); //find any player, anywhere
				if(P != none)
					a.Trigger(instigator, P);
				else
					a.Trigger(instigator, None);
			}
			else
				a.Trigger(instigator,Pawn(instigator));
		}
	}
}

defaultproperties
{
	CollisionRadius=96.000000
	bTouchInstead=False
}
