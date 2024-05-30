using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }
using { /Verse.org/Simulation/Tags }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

elimination_game_device := class(creative_device):

    @editable
    EndGameDevice : end_game_device = end_game_device{}

    # Array of item granters used to grant the weapons
    @editable
    var WeaponItemGranters : []item_granter_device = array{}
    
    # This is set later, this will be equal to the the number of weapon item_granters in the island
    var NumberOfEliminationsToWin : int = 50
    # Map container to track players progress. This is how to determine which weapon to award to the player
    var AgentMap : [agent]int = map{}
    
    @editable
    var Accolade1:accolades_device = accolades_device{}
    @editable
    var PlayerSpawners : []player_spawner_device = array{}
    @editable
    var Sentries : []sentry_device = array{}
    



    OnBegin<override>()<suspends>:void=
        # Can use this variable to scale the number of eliminations needed based on how many item granters there are in the experience
        set NumberOfEliminationsToWin = WeaponItemGranters.Length
        Print("Number of Weapon Item Granters: {WeaponItemGranters.Length}")
        
        # Randomize the order in which the weapons are granted
        set WeaponItemGranters = Shuffle(WeaponItemGranters)

        # Get all the players in the experience
        AllPlayers := GetPlayspace().GetPlayers()
        for (EliminationGamePlayer : AllPlayers):
            if (FortCharacter := EliminationGamePlayer.GetFortCharacter[]):
                FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated) # subscribe to eliminated event
            
            # Add Players to a Map to track progress
            if (set AgentMap[EliminationGamePlayer] = 1) {} 
            
            # Grant the first weapon to each player
            if (FirstItemGranter:item_granter_device = WeaponItemGranters[0]):
                FirstItemGranter.GrantItem(EliminationGamePlayer) 


        for (Sentry : Sentries):
            Sentry.EliminatedEvent.Subscribe(TestPlayerEliminated) # Subscribe to each Sentry

        for (Spawner : PlayerSpawners):
             Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn) # Subscribe to each player spawn pad
        
        GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded) # Subscribe to new players joining the game
        










        
                # Event that handles when a player is eliminated
    OnPlayerEliminated(Result:elimination_result):void=
        Print("Player Eliminated")
        EliminatingCharacter := Result.EliminatingCharacter
        if (FortCharacter := EliminatingCharacter?):
            if (EliminatingAgent := FortCharacter.GetAgent[]):
                if (EliminatedAgent := FortCharacter.GetAgent[]):
                    if(EliminatedAgent<>EliminatingAgent):
                
                GrantNextWeapon(EliminatingAgent)
        





    # Check if there is a winner for the game, if not then grant the next weapon
    GrantNextWeapon(Agent:agent):void=
        if (var CurrentItemNumber:int = AgentMap[Agent]):
            if (IsVictoryConditionMet(CurrentItemNumber) = true):
                EndGame(Agent) # Game has been won

            else: # Game is not over yet
                if (IsFirstGoalMet(CurrentItemNumber) = true):
                    Accolade1.Award(Agent) # player get 10 eliminations
                
                set CurrentItemNumber = CurrentItemNumber + 1
                if (ItemGranter := WeaponItemGranters[CurrentItemNumber - 1]):
                    ItemGranter.GrantItem(Agent)
                
                if (set AgentMap[Agent] = CurrentItemNumber) {}


                 # Check if the victory condition has been met and return the the result
    IsVictoryConditionMet(EliminationNumber:int)<transacts>:logic=
        if:
            EliminationNumber = NumberOfEliminationsToWin
        then:
            return true
        else:
            return false


    EndGame(Agent:agent):void=
                EndGameDevice.Activate(Agent)



    # Check if player get 10 eliminations and return the the result
    IsFirstGoalMet(EliminationNumber:int)<transacts>:logic=
        if:
            EliminationNumber = 10
        then:
            return true
        else:
            return false



            

    OnPlayerSpawn(InPlayer : agent) : void =
         Print("A Player just spawned!")
         AllPlayers := GetPlayspace().GetPlayers()
        for (EliminationGamePlayer : AllPlayers):
            if (FortCharacter := EliminationGamePlayer.GetFortCharacter[]):
                FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated) # subscribe to eliminated event
                if (InitItemGranter:item_granter_device = WeaponItemGranters[0]):
                    InitItemGranter.GrantItem(InPlayer)
            
            # Add Players to a Map to track progress
            if (set AgentMap[EliminationGamePlayer] = 1) {} 
            
    


    OnPlayerAdded(InPlayer : player) : void =
        Print("A New Player Joined!")
        if:
            Team := GetPlayspace().GetTeamCollection().GetTeam[InPlayer]
            FortCharacter := InPlayer.GetFortCharacter[]


    TestPlayerEliminated(Agent : ?agent) : void =
        Print("Sentry Eliminated")
        if(FortCharacter := Agent?):
            GrantNextWeapon(FortCharacter)

         


