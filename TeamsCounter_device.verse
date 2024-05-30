
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath}

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
TeamsCounter_device := class(creative_device):
    
    @editable
    var TeamCounter1 : player_counter_device = player_counter_device {}
    @editable
    var TeamCounter2 : player_counter_device = player_counter_device {}
    @editable
    var TeamCounter3 : player_counter_device = player_counter_device {}
    @editable
    var TeamCounter4 : player_counter_device = player_counter_device {}

    @editable
    var IconTeam1 : hud_message_device = hud_message_device {}
    @editable
    var IconTeam2 : hud_message_device = hud_message_device {}
    @editable
    var IconTeam3 : hud_message_device = hud_message_device {}
    @editable
    var IconTeam4 : hud_message_device = hud_message_device {}
    
    @editable
    Timer:timer_device = timer_device{}

    

    OnBegin<override>()<suspends>:void=
        Timer.SuccessEvent.Subscribe(OnTimeComplete)
        



    OnTimeComplete(Agent: ?agent):void=
        TeamCounter1.Enable()
        TeamCounter2.Enable()
        TeamCounter3.Enable()
        TeamCounter4.Enable()


        TeamCounter1.CountSucceedsEvent.Subscribe(OnCountSucceedT1)
        TeamCounter2.CountSucceedsEvent.Subscribe(OnCountSucceedT2)
        TeamCounter3.CountSucceedsEvent.Subscribe(OnCountSucceedT3)
        TeamCounter4.CountSucceedsEvent.Subscribe(OnCountSucceedT4)

        TeamCounter1.CompareToTarget()
        TeamCounter2.CompareToTarget()
        TeamCounter3.CompareToTarget()
        TeamCounter4.CompareToTarget()

        

        
    OnCountSucceedT1():void=
        IconTeam1.Hide()
    OnCountSucceedT2():void=
        IconTeam2.Hide()
    OnCountSucceedT3():void=
        IconTeam3.Hide()
    OnCountSucceedT4():void=
        IconTeam4.Hide()