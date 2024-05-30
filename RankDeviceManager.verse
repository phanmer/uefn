
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Random }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation/Tags }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors/NamedColors }
using { /UnrealEngine.com/Temporary/SpatialMath }


spawner := class(tag){}

sentries := class(tag){}

TextForUI<localizes>(InText : string, InText2: string, Agent : agent) : message = "{InText} / {InText2}"


RankDeviceManager := class(creative_device):

    var PlayerMap : [player]RankDeviceManager = map{}

    @editable Tracker : tracker_device = tracker_device{}

    @editable Tracker2 : tracker_device = tracker_device{}

    @editable Tracker3 : tracker_device = tracker_device{}

    @editable Bronze : hud_message_device = hud_message_device{}

    @editable SilverR : hud_message_device = hud_message_device{}

    @editable GoldR : hud_message_device = hud_message_device{}

    @editable diamondR : hud_message_device = hud_message_device{}

    @editable platR : hud_message_device = hud_message_device{}

    @editable EliteR : hud_message_device = hud_message_device{}

    @editable ChampionR : hud_message_device = hud_message_device{}

    @editable UnrealR : hud_message_device = hud_message_device{}


    
    InitSpawners():void =
        Spawners := GetCreativeObjectsWithTag(spawner{})
        for (Obj : Spawners):
            if (Spawner := player_spawner_device[Obj]):
                Spawner.SpawnedEvent.Subscribe(OnPlayerAdded)

    
    OnBegin< override>()< suspends>:void=
        InitSpawners()
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
          
          
    KillSpawnLoop(Player : player, TextBlock : text_block, Agent : agent)<suspends>:void =
       
        var TotalGoal : int = 0


        loop:
            
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)

            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            #Print("TrackerOne: {TotalPointsTrackerOne} TrackerTwo: {TotalPointsTrackerTwo} TrackerThree: {TotalPointsTrackerThree}")

            if (TotalPoints < 0):
                Tracker.Reset(Player)
                Tracker2.Reset(Player)
                Tracker3.Reset(Player)
                set TotalGoal = 100

            Sleep(0.0)
            if (AgentStats := PlayerMap[Player]):
                TextBlock.SetText(TextForUI("{TotalPoints}","{TotalGoal}", Agent))
                if (TotalPoints >= 0):
                    set TotalGoal = 100
                    if (TotalPoints >= 100):
                        set TotalGoal = 300
                        if (TotalPoints >= 300):
                            set TotalGoal = 1000
                            if (TotalPoints >= 1000):
                                set TotalGoal = 2500
                                if (TotalPoints >= 2500):
                                    set TotalGoal = 5000
                                    if (TotalPoints >= 5000):
                                        set TotalGoal = 20000
                                        if (TotalPoints >= 20000):
                                            set TotalGoal = 50000
                                            if (TotalPoints >= 50000):
                                                set TotalGoal = 50000

    
    RankSpawnLoop(Player : player, TextBlock : text_block, Agent : agent)<suspends>:void =

        var TotalGoal : int = 0
        
        loop:
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            Sleep(0.0)
            if (TotalPoints < 0):
                if (PlayerUi := GetPlayerUI[Player]):
                    Bronze.Show(Agent)
                    break
        loop:
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            Sleep(0.0)
            if (TotalPoints >= 0):
                if (PlayerUi := GetPlayerUI[Player]):
                    Bronze.Show(Agent)
                    break
        loop:
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            Sleep(0.0)
            if (TotalPoints >= 100):
                if (PlayerUi := GetPlayerUI[Player]):
                    SilverR.Show(Agent)
                    break
        loop:
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            Sleep(0.0)
            if (TotalPoints >= 300):
                 if (PlayerUi := GetPlayerUI[Player]):
                    GoldR.Show(Agent)
                    break            
        loop:
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)
  

            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            Sleep(0.0)
            if (TotalPoints >= 1000):
                if (PlayerUi := GetPlayerUI[Player]):
                    diamondR.Show(Agent)
                    break
        loop:
            Sleep(0.0)
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            if (TotalPoints >= 2500):
                    if (PlayerUi := GetPlayerUI[Player]):
                    platR.Show(Agent)
                    break       
        loop:
            Sleep(0.0)
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            if (TotalPoints >= 5000):
                    if (PlayerUi := GetPlayerUI[Player]):
                    EliteR.Show(Agent)
                    break
        loop:
            Sleep(0.0)
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)


            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            if (TotalPoints >= 20000):
                    if (PlayerUi := GetPlayerUI[Player]):
                    ChampionR.Show(Agent)
                    break
        loop:
            Sleep(0.0)
            TotalPointsTrackerOne := 10* Tracker.GetValue(Player)
            TotalPointsTrackerTwo := -2* Tracker2.GetValue(Player)
            TotalPointsTrackerThree := 15* Tracker3.GetValue(Player)
            TotalPoints := TotalPointsTrackerOne + TotalPointsTrackerTwo + TotalPointsTrackerThree
            if (TotalPoints >= 50000):
                    if (PlayerUi := GetPlayerUI[Player]):
                    UnrealR.Show(Agent)
                    break

    OnPlayerAdded(NewPlayer : agent):void =

        if (PlayerObj := player[NewPlayer]):
            if (PlayerExists := PlayerMap[NewPlayer]):

            else:
                if (set PlayerMap[PlayerObj] = RankDeviceManager{}):
                    if(PlayerUI := GetPlayerUI[PlayerObj]):
                        var TextBlock2 : text_block = text_block{DefaultTextColor := Beige}

                        if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) < 15):
                            MyCanvas2 := canvas:
                                Slots := array:
                                    canvas_slot:
                                        Anchors := anchors{Minimum := vector2{X := 0.025, Y := 0.35}, Maximum := vector2{X := 0.025, Y := 0.35}}
                                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                                        Alignment := vector2{X := 0.025, Y := 0.35}
                                        SizeToContent := true
                                        Widget := TextBlock2
                            PlayerUI.AddWidget(MyCanvas2)

                        if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 0):
                            Bronze.Show(NewPlayer)
                            MyCanvas2 := canvas:
                                Slots := array:
                                    canvas_slot:
                                        Anchors := anchors{Minimum := vector2{X := 0.025, Y := 0.35}, Maximum := vector2{X := 0.025, Y := 0.35}}
                                        Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                                        Alignment := vector2{X := 0.025, Y := 0.35}
                                        SizeToContent := true
                                        Widget := TextBlock2
                            PlayerUI.AddWidget(MyCanvas2)
                            
                            if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 100):
                                SilverR.Show(NewPlayer)
                                
                                if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 300):
                                    GoldR.Show(NewPlayer)
                                    
                                    if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 1000):
                                        diamondR.Show(NewPlayer)
                                        
                                        if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 2500):
                                            platR.Show(NewPlayer)
                                            
                                            if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 5000):
                                                EliteR.Show(NewPlayer)
                                                
                                                if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 20000):
                                                    ChampionR.Show(NewPlayer)
                                                    
                                                    if (10*Tracker.GetValue(PlayerObj)-2*Tracker2.GetValue(PlayerObj)+15*Tracker2.GetValue(PlayerObj) >= 50000):
                                                        UnrealR.Show(NewPlayer)
                                                        

                       
                        
                        var TextBlock : text_block = text_block{DefaultTextColor := White}
                        MyCanvas := canvas:
                            Slots := array:
                                canvas_slot:
                                    Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.5}, Maximum := vector2{X := 1.0, Y := 0.5}}
                                    Offsets := margin{Top := 0.0, Left := 0.0, Right := 0.0, Bottom := 0.0}
                                    Alignment := vector2{X := 1.0, Y := 0.5}
                                    SizeToContent := true
                                    Widget := TextBlock
                        
                        PlayerUI.AddWidget(MyCanvas)

                        spawn{KillSpawnLoop(PlayerObj, TextBlock, NewPlayer)}

                        spawn{RankSpawnLoop(PlayerObj, TextBlock2, NewPlayer)}


                        

    OnPlayerRemoved(PlayerLeaving : player):void =
        if (ActualPlayer := PlayerMap[PlayerLeaving]):
            var TempPlayerMap:[player]RankDeviceManager = map{}
            for (Key -> Value : PlayerMap, Key <> PlayerLeaving):
                set TempPlayerMap = ConcatenateMaps(TempPlayerMap, map{Key => Value})

            set PlayerMap = TempPlayerMap