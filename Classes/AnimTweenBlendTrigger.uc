//=============================================================================
// AnimTweenBlendTrigger
//
// Forces an actor to play the specified anim blended with another anim. Animations in Unreal can be a bit wonky, so your milage may vary.
//
// By: PolaricEntropy, based on AnimTrigger (for Deus Ex: Revision)
//=============================================================================
class AnimTweenBlendTrigger extends MoreTriggers;

var() Name AnimSequence;
var() float tweentime;

function BeenTriggered(Actor Other, Actor instigator)
{
	local Actor a;

	foreach AllActors(LimitingClass,a,Event)
		a.TweenBlendAnim(AnimSequence, tweentime);

}

defaultproperties
{
}
