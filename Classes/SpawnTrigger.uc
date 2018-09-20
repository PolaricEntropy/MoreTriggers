//=============================================================================
// SpawnTrigger
//
// Spawns shit. You can specify an owner and a tag for the spawned item, too.
//=============================================================================

class SpawnTrigger extends MoreTriggers;

var() class<Actor> SpawnClass;
var() name SpawnOwnerTag;
var() name SpawnTag;
var() bool bSpawnOutOfSight;
var() float checktimer;
var actor spawnOwner;
var actor savedinstigator;

function BeenTriggered(Actor instigator)
{
	local actor A;

	if(SpawnTag == '')
		SpawnTag = SpawnClass.default.Tag;

	if(spawnOwnerTag != '')
	{
		foreach AllActors(Class'Actor', A, SpawnOwnerTag)
		{
			SpawnOwner = A;
			break;
		}
	}
	if(!bSpawnoutofsight)
	{
		if(spawnOwner != none)
			Spawn(SpawnClass, SpawnOwner, SpawnTag);
		else
			Spawn(SpawnClass,, SpawnTag);
	}
	else
	{
		if(!checkspawn())
		{
			savedinstigator = instigator;
			settimer(checktimer,true);
		}
		else
		{
			checktimer = 0;
			settimer(checktimer,false);
		}
	}
}

function timer()
{
	if(checktimer > 0)
		BeenTriggered(savedinstigator);
}

function bool Checkspawn()
{
	local actor A;
	local deusexplayer p;

	P = deusexplayer(getplayerpawn());
	if(P != none && P.LineOfSightTo(self, true))
		return false;
	else
	{
		if(spawnOwner != none)
			A = Spawn(SpawnClass, SpawnOwner, SpawnTag);
		else
			A = Spawn(SpawnClass,, SpawnTag);

		return (A != none);
	}
	return false;
}

defaultproperties
{
	spawnClass=None
	checktimer=2.0
}
