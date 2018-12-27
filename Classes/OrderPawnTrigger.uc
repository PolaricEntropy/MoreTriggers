//=============================================================================
// OrderPawnTrigger
// 
// Sets the order of the ScriptedPawn that triggered/touched it.
// Use either TT_PawnProximity or TT_ClassProximity with a specified ScriptedPawn class in ClassProximityType.
// By: PolaricEntropy
//=============================================================================
class OrderPawnTrigger extends MoreTriggers;

var(OrdersTrigger) name Orders;
var(OrdersTrigger) name ordersTag;

function BeenTriggered(Actor Other, Actor instigator)
{
	if (instigator.isA('ScriptedPawn'))
	{
		//Set the orders on the pawn.
		ScriptedPawn(instigator).SetOrders(Orders, ordersTag, True);
	}
}

defaultproperties
{
	 TriggerType=TT_PawnProximity
     CollisionRadius=96.000000
}
