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

function BeenTriggered(Actor Other, Actor Instigator)
{
	local DeusExPlayer player;
	local bool bSuccess;
	local Actor A, conOwner;

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