//=============================================================================
// LOSHateTrigger.
//
// Makes pawns that can see the triggerer hate them.
//
// By: Hawk (for Deus Ex: Revision)
//=============================================================================
class LOSHateTrigger extends MoreTriggers;

var() bool bEventClassOnly;
var() bool bIsOn;
var() float checkInterval;
var Actor intruder;

// if we are triggered, turn us on
function Trigger(Actor Other, Pawn Instigator)
{
	if (!bIsOn)
		bIsOn = True;
	
	if (SetAlliances(Other))
	{
		Super.Trigger(Other, Instigator);
		if (bTriggerOnceOnly)
			Destroy();
	}
}

// if we are untriggered, turn us off
function UnTrigger(Actor Other, Pawn Instigator)
{
	if (bIsOn)
		bIsOn = False;

	Super.UnTrigger(Other, Instigator);
}

function Timer()
{
	if (!bIsOn)
	{
		SetTimer(0.1, False);
		return;
	}

	if (intruder != None)
		if (SetAlliances(intruder))
			if (bTriggerOnceOnly)
				Destroy();
}

singular function Touch(Actor Other)
{
	if (!bIsOn)
		return;
		
	if (!IsRelevant(Other))
		return;

	intruder = Other;
	SetTimer(checkInterval, True);
}

function UnTouch(Actor Other)
{
	if (!bIsOn)
		return;

	intruder = None;
	SetTimer(0.1, False);
}

function bool SetAlliances(actor Other)
{
	local Pawn curPawn;
	local ScriptedPawn P;
	
	if (Other == None)
		return False;
	
	// find an NPC with LOS
	if (Other != None && Pawn(Other) != None)
	{
		for (curPawn=Level.PawnList; curPawn != None; curPawn=curPawn.nextPawn)
		{
			P = ScriptedPawn(curPawn);
			if(P != None && (!bEventClassOnly || (bEventClassOnly && P.Tag == Event)) && P.AICanSee(Other, P.ComputeActorVisibility(Other), True, True, True, True) > 0 && P.Alliance != Pawn(Other).Alliance)
				P.ChangeAlly(Pawn(Other).Alliance, -1, False);
		}
	}

	return True;
}

defaultproperties
{
     CollisionRadius=96.000000
     bIsOn=True
	 checkInterval=0.350000
}
