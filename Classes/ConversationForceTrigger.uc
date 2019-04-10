//=============================================================================
// ConversationForceTrigger
//
// Copy of the ConversationTrigger, but with the option of forcing the conversation.
// By: PolaricEntropy (inspired by Shifter's similar trigger).
//=============================================================================
class ConversationForceTrigger extends MoreTriggers;

var() name conversationTag;
var() string BindName;
var() name checkFlag;
var() bool bCheckFalse;
var() bool bForcePlay;

//WCCC, 4/9/19: Adding this to solve some issues with alive flags.
var() name ParticipantNames[4];

function BeenTriggered(Actor Other, Actor Instigator)
{
	local DeusExPlayer player;
	local bool bSuccess;
	local Actor A, conOwner;
	local int i;
	local FlagBase FBase;
	local string TestStr;

	player = DeusExPlayer(Instigator);
	bSuccess = True;

	// only works for DeusExPlayers
	if (player == None)
		return;

	if (checkFlag != '')
	{
		if (!player.flagBase.GetBool(checkFlag))
			bSuccess = bCheckFalse;
		else
			bSuccess = !bCheckFalse;
	}
	
	//WCCC: Do some checks through our participant names.
	if (player != None)
		FBase = player.FlagBase;
		
	if (bSuccess && FBase != None && ParticipantNames[0] != '')
	{
		for (i=0; i<4; i++)
		{
			if (ParticipantNames[i] != '')
			{
				//WCCC: I hate this check... But it works. Efficiency is not always my strong suit.
				TestStr = string(ParticipantNames[i]);
				if (FBase.GetBool(FBase.StringToName(TestStr$"_Unconscious")) || FBase.GetBool(FBase.StringToName(TestStr$"_Dead")))
				{
					bSuccess = false;
					break;
				}
			}
			else break;
		}
	}

	if (BindName != "" && conversationTag != '')
	{
		foreach AllActors(class'Actor', A)
			if (A.BindName == BindName)
			{
				conOwner = A;
				break;
			}

		if (bSuccess)
			player.StartConversationByName(conversationTag, conOwner,,bForcePlay);
	}
}

defaultproperties
{
     bTriggerOnceOnly=True
	 bForcePlay=True
     CollisionRadius=96.000000
}