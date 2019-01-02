//=============================================================================
// ElevatorTrigger
//
// Allows you to send elevator to keyframes based on what button triggered it, also supports opening doors.
//
// By: PolaricEntropy (for Deus Ex: Revision)
//=============================================================================
class ElevatorTrigger extends MoreTriggers;

struct ElevatorFrameInfo {
	var() name ButtonTag;
	var() name DoorTag;
};

var() ElevatorFrameInfo elevatorFrames[8];
var name savedDoors;

function BeenTriggered(Actor Other, Actor Instigator)
{
	local int i;
	local ElevatorMover elevator;
	local Mover doors;
	
	if (Event != '')
	{
		for (i=0; i<8; i++)
		{
			//Find the keyframe that has the buttonTag we shall go to.
			if (elevatorFrames[i].ButtonTag != '' && Other.Tag == elevatorFrames[i].ButtonTag)
			{				
				foreach AllActors(class'ElevatorMover', elevator, Event)
				{
					//We are already here, just open the doors (if we have any).
					if (elevator.KeyNum == i)
					{
						if (elevatorFrames[i].DoorTag != '')
							foreach AllActors(class'Mover', doors, elevatorFrames[i].DoorTag)
								doors.Trigger(Self, Other.Instigator);
					}
					else //We are not at the destination already.
					{
						//Check if we have doors where we currently are.
						if (elevatorFrames[elevator.KeyNum].DoorTag != '')
						{
							foreach AllActors(class'Mover', doors, elevatorFrames[elevator.KeyNum].DoorTag)
							{
								//If doors are not closed, close them.
								if (doors.KeyNum != 0)
									doors.Trigger(Self, Other.Instigator);
							}
						}
						
						
						//Send the elevator here.
						elevator.SetSeq(i);
						
						//If we have a door tag, trigger the door after the elevator has moved.
						if (elevatorFrames[i].DoorTag != '')
						{
							savedDoors = elevatorFrames[i].DoorTag;
							SetTimer(elevator.MoveTime - 0.5, False);
						}
					}
				}
				break;
			}
		}
	}
}

function Timer()
{
	local Mover doors;
	
	if (savedDoors != '')
	{
		foreach AllActors(class'Mover', doors, savedDoors)
			doors.Trigger(Self, Instigator);
		savedDoors = '';
	}
}

defaultproperties
{
}