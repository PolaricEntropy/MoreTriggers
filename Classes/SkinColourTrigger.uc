//=============================================================================
// SkinColourTrigger
//
// Detects whether you selected default, black, albino, latin or ginger JC. You specify the tags of various triggers based on detected PlayerSkin, and it'll fire them accordingly when triggered. 
// I.e. you could put "WarningTrigger" in the JCAlbinoTag field, and have that fire off a SpecialEvent telling the player to put some fucking sun cream on.
//
// By: DDL
//=============================================================================
class SkinColourTrigger extends MoreTriggers;

var() name JCDefaultTag;
var() name JCBlackTag;
var() name JCLatinoTag;
var() name JCGingerTag;
var() name JCAlbinoTag;

function beentriggered(Actor Other, actor ins)
{
	local deusexplayer p;
	local name trigname;
	local actor trigA, A;

	p = deusexplayer(getplayerpawn());

	if(P != none)
	{
		switch(P.PlayerSkin)
		{
			case 0: trigname = JCDefaultTag; break;
			case 1: trigname = JCBlackTag; break;
			case 2: trigname = JCLatinoTag; break;
			case 3: trigname = JCGingerTag; break;
			case 4: trigname = JCAlbinoTag; break;
			default: trigname = JCDefaultTag; break;
		}

		foreach Allactors(Class'actor', trigA, trigname)
		{
			//log("Triggering "$string(trigname));
			trigA.Trigger(self, P);
		}
	}
	else
		log("Can't find a player!");

	if(event != '')
	{
		if(pawn(ins) != none)
		{
			foreach Allactors (Class'Actor',A,event)
				A.Trigger(ins,pawn(ins));
		}
		else
		{
			foreach Allactors (Class'Actor',A,event)
				A.Trigger(ins,none);
		}
	}
}

defaultproperties
{
}