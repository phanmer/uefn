 
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI}
using { /UnrealEngine.com/Temporary/SpatialMath}
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Verse.org/Colors/NamedColors }
 

 
pinpad_device := class(creative_device):
 
    var StuffPerAgent : [agent]?tuple(canvas,text_block,string) = map{}
 
    @editable AssignPinPadButton : button_device = button_device{}
    @editable FailTrigger : trigger_device = trigger_device{}
    @editable SuccessTrigger : trigger_device = trigger_device{}
    @editable SuccessTrigger2 : trigger_device = trigger_device{}
 
    @editable PIN : int = 0
    @editable PIN2 : int = 0
 
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        AssignPinPadButton.InteractedWithEvent.Subscribe(AddPinPad)
 
    S2M<localizes>(S:string):message="{S}"
 
    AddPinPad(A:agent):void=
        if(Stuff:=StuffPerAgent[A]?):
            #Do not assign
        else:
            Val:=MakeCanvas()
            if:
                PlayerUI:=GetPlayerUI[player[A]]
            then:
                PlayerUI.AddWidget(Val(0),player_ui_slot{InputMode:=ui_input_mode.All})
                if(set StuffPerAgent[A] = option{(Val(0),Val(1),"")}){}
 
    RemovePinPad(A:agent):void=
        if(Stuff:=StuffPerAgent[A]?):
            if:
                PlayerUI:=GetPlayerUI[player[A]]
            then:
                PlayerUI.RemoveWidget(Stuff(0))
                if(set StuffPerAgent[A] = false){}
 
    MakeCanvas():tuple(canvas,text_block)=
        Button0 := button_regular{DefaultText:=S2M("0")}
        Button0.OnClick().Subscribe(Add0)
        Button1 := button_regular{DefaultText:=S2M("1")}
        Button1.OnClick().Subscribe(Add1)
        Button2 := button_regular{DefaultText:=S2M("2")}
        Button2.OnClick().Subscribe(Add2)
        Button3 := button_regular{DefaultText:=S2M("3")}
        Button3.OnClick().Subscribe(Add3)
        Button4 := button_regular{DefaultText:=S2M("4")}
        Button4.OnClick().Subscribe(Add4)
        Button5 := button_regular{DefaultText:=S2M("5")}
        Button5.OnClick().Subscribe(Add5)
        Button6 := button_regular{DefaultText:=S2M("6")}
        Button6.OnClick().Subscribe(Add6)
        Button7 := button_regular{DefaultText:=S2M("7")}
        Button7.OnClick().Subscribe(Add7)
        Button8 := button_regular{DefaultText:=S2M("8")}
        Button8.OnClick().Subscribe(Add8)
        Button9 := button_regular{DefaultText:=S2M("9")}
        Button9.OnClick().Subscribe(Add9)
        Delete := button_loud{DefaultText:=S2M("Delete")}
        Delete.OnClick().Subscribe(DeleteLastChar)
        Enter := button_loud{DefaultText:=S2M("Enter")}
        Enter.OnClick().Subscribe(EnterFunc)
        NumTB := text_block{DefaultText:=S2M(""),DefaultTextColor:=White}
 
 
        MyCanvas:= canvas:
            Slots:=array:
                canvas_slot:
                    Anchors:=anchors{Minimum:=vector2{X:=0.5,Y:=0.5},Maximum:=vector2{X:=0.5,Y:=0.5}}
                    Alignment:=vector2{X:=0.5,Y:=0.5}
                    SizeToContent:=true
                    Widget:=overlay:
                        Slots:=array:
                            overlay_slot:
                                #Outside ColorBlock
                                HorizontalAlignment:=horizontal_alignment.Fill
                                VerticalAlignment:=vertical_alignment.Fill
                                Widget:=color_block{DefaultColor:=MakeColorFromSRGB(0.05,0.05,0.05),DefaultDesiredSize:=vector2{X:=564.0,Y:=550.0}, DefaultOpacity := 0.0}
                            overlay_slot:  
                                HorizontalAlignment:=horizontal_alignment.Center
                                VerticalAlignment:=vertical_alignment.Bottom
                                Padding:=margin{Bottom:=20.0}
                                Widget:=overlay:
                                    Slots:=array:
                                        #PinPad ColorBlock
                                        overlay_slot:
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Fill
                                            Widget:=color_block{DefaultColor:=MakeColorFromSRGB(0.0,0.01,0.50), DefaultOpacity := 0.0}
                                        #PinPad
                                        overlay_slot:
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
                                            Padding:=margin{Top:=20.0,Left:=20.0,Bottom:=20.0,Right:=20.0}
                                            Widget:=stack_box:
                                                Orientation:=orientation.Vertical
                                                Slots:=array:
                                                    #1-3 Stack
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=25.0, Left:=50.0, Right:=50.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button1
                                                                stack_box_slot:
                                                                    Widget:=Button2
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    #Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Widget:=Button3
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                    #4-6
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=25.0, Left:=50.0, Right:=50.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button4
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    Widget:=Button5
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    #Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    Widget:=Button6
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                    #7-9
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=25.0, Left:=50.0, Right:=50.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button7
                                                                stack_box_slot:
                                                                    Widget:=Button8
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    #Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Widget:=Button9
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                    #Delete, 0 and Enter
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=25.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Delete
                                                                stack_box_slot:
                                                                    Widget:=Button0
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    #Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Widget:=Enter
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                            #Text Block Stuff
                            overlay_slot:
                                HorizontalAlignment:=horizontal_alignment.Center
                                VerticalAlignment:=vertical_alignment.Top
                                Padding:=margin{Top:=20.0}
                                Widget:=overlay:
                                    Slots:=array:
                                        overlay_slot:
                                            Widget:=color_block{DefaultColor:=MakeColorFromSRGB(0.9,1.0,0.01),DefaultDesiredSize:=vector2{X:=535.0,Y:=45.0}}
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Fill
                                        overlay_slot:
                                            Widget:=NumTB
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
 
 
 
 
        return (MyCanvas,NumTB)
 
    Add0(WM:widget_message):void=AddNum(0,WM)
    Add1(WM:widget_message):void=AddNum(1,WM)
    Add2(WM:widget_message):void=AddNum(2,WM)
    Add3(WM:widget_message):void=AddNum(3,WM)
    Add4(WM:widget_message):void=AddNum(4,WM)
    Add5(WM:widget_message):void=AddNum(5,WM)
    Add6(WM:widget_message):void=AddNum(6,WM)
    Add7(WM:widget_message):void=AddNum(7,WM)
    Add8(WM:widget_message):void=AddNum(8,WM)
    Add9(WM:widget_message):void=AddNum(9,WM)
 
    EnterFunc(WM:widget_message):void=
        Print("Enter")
        PinAsString:string="{PIN}"
        PinAsString2:string="{PIN2}"
        if(Stuff:=StuffPerAgent[WM.Player]?):
            if(PinAsString=Stuff(2)):
                Print("SUCCESS: {PIN} = {Stuff(2)}")
                SuccessTrigger.Trigger(WM.Player)
            if(PinAsString2=Stuff(2)):
                Print("SUCCESS: {PIN2} = {Stuff(2)}")
                SuccessTrigger2.Trigger(WM.Player)
                
            else:
                Print("FAIL: {PIN} != {Stuff(2)}")
                FailTrigger.Trigger(WM.Player)
                
            RemovePinPad(WM.Player)
 
 
 
    AddNum(Num:int,WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String:string=Stuff(2)
            set String += "{Num}" #Add a new number
            if(set StuffPerAgent[WM.Player] = option{(Stuff(0),Stuff(1),String)}){}
            UpdateUI(WM)
 
    UpdateUI(WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String:string=Stuff(2)
            TB:=Stuff(1)
            TB.SetText(S2M("{String}"))
 
    DeleteLastChar(WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String: string = Stuff(2)
            var UpdatedString : string = ""
            for(Index->S:String):
                if(Index = String.Length-1):
                    #This the last character, remove it
                else:
                    set UpdatedString += "{S}"
            if(set StuffPerAgent[WM.Player] = option{(Stuff(0),Stuff(1),UpdatedString)}){}
            UpdateUI(WM)# fill this file with your verse-script