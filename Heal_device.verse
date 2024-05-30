
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Fortnite.com/Teams }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
Heal_device := class(creative_device):

    @editable
    var PlayerSpawners : []player_spawner_device = array{}
    HEAL_DELAY : float = 0.1




    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        for (Spawner : PlayerSpawners):
            Spawner.SpawnedEvent.Subscribe(OnPlayerSpawn)
        
    

    #-----------------------------------------------------------------------------------------------------------------------------------------
    OnPlayerSpawn(Agent : agent) : void =
        if (FC:fort_character = Agent.GetFortCharacter[]):
            FC.DamagedEvent().Subscribe(OnPlayerDamaged)
            FC.DamagedShieldEvent().Subscribe(OnShieldDamaged)

        

    OnPlayerDamaged(DR:damage_result):void=
        if(FC:fort_character = fort_character[DR.Target]):
            CurrentHealth:float = FC.GetHealth()
            Print("Current Health of Player")

        DamagedAmount:float = DR.Amount
        Print("Damaged Amount: {DamagedAmount}")

        if(Instigator:game_action_instigator = DR.Instigator?):
            if(InstigatingAgent:agent = Instigator.GetInstigatorAgent[]):
                if(FC:fort_character = InstigatingAgent.GetFortCharacter[]):
                    CurrentHealth:float = FC.GetHealth()
                    Print("Current Health of player: {CurrentHealth}")
                    DoSiphon(FC, DamagedAmount)



    HealPlayer(Player:fort_character, Amount:float)<suspends>:void=
        var HealedAmount:float = 0.0
        loop:
            CurrentHealth:float = Player.GetHealth()
            if(CurrentHealth = 100.0):
                break

            Sleep(HEAL_DELAY)



    OnShieldDamaged(DR:damage_result):void=
        if(FC:fort_character = fort_character[DR.Target]):
            CurrentShield:float = FC.GetShield()
            Print("Current Shield of player: {CurrentShield}")

        DamagedAmount:float = DR.Amount
        Print("Amount Damaged: {DamagedAmount}")

        if(Instigator:game_action_instigator = DR.Instigator?):
            if(InstigatingAgent:agent = Instigator.GetInstigatorAgent[]):
                if(FC:fort_character = InstigatingAgent.GetFortCharacter[]):
                    CurrentShield:float = FC.GetShield()
                    Print("Current Shield of player: {CurrentShield}")
                    DoSiphon(FC, DamagedAmount)



    FixShield(Player:fort_character, Amount:float)<suspends>:void=
        var FixedAmount:float = 0.0
        loop:
            CurrentShield:float = Player.GetShield()
            if(CurrentShield = 100.0):
                break
            else:
                set FixedAmount += 1.0
                NewShield:float = CurrentShield + 1.0
                Player.SetShield(NewShield)

                if(FixedAmount >= Amount):

                    break
                
                Sleep(HEAL_DELAY)



    DoSiphon(Player:fort_character, Amount:float):void=
        CurrentShield:float = Player.GetShield()
        CurrentHealth:float = Player.GetHealth()

        if(CurrentHealth < 100.0):
            Print("Heal player first {Amount}")
            spawn:
                HealPlayer(Player, Amount)
        else:
            if(CurrentShield < 100.0):
                Print("fix shield {Amount}")
                spawn:
                    FixShield(Player, Amount)
