' -----------------------------------------------------------------------------  
' Script Created by RMxprt Version 14.0 to generate Simplorer Circuit design     
' Expect 2 args, first the project name,                                         
'                second the design name                                          
' -------------------------------------------------------------------------------
Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Dim oSml1, oSml2, oModName
oModName = "Setup1"

Set oAnsoftApp = CreateObject("AnsoftSimplorer.SimplorerScript")
' -----------------------------------------------------------------------------  
' Determine the path of this vbs and resolve path to other referenced files      
' -----------------------------------------------------------------------------  
Dim vbspath, dir, path, fileName, filesys, pathArray, count
vbspath = AnsoftScript.GetScriptPath
Set filesys = CreateObject("Scripting.FileSystemObject")
dir = filesys.GetParentFolderName(vbspath)
fileName = filesys.GetFileName(vbspath)
fileName = filesys.GetBaseName(fileName)
pathArray = Split(fileName, "_")
' Form the path
count = UBound(pathArray) - 1
if (count > 0) Then
For i = 0 to count
path = path + pathArray(i)
if (i < count) Then
path = path + "_"
End If
Next
oSml1 = dir + "/" + path + ".sml"
oSml2 = dir + "/" + path + "_signals.sml"
Else ' no _ in file name
oSml1 = dir + "/" + oModName + ".sml"
oSml2 = dir + "/" + "signals.sml"
End if

Set oArgs = AnsoftScript.arguments
Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oProject = oDesktop.NewProject
if (oArgs.Count > 1) then 
  oProject.InsertDesign "Simplorer", oArgs(1), "", ""
else
  oProject.InsertDesign "Simplorer", "Simplorer1", "", ""
end if
Set oDesign = oProject.GetActiveDesign()
Set oEditor = oDesign.SetActiveEditor("SchematicEditor")
Set oDefinitionManager = oProject.GetDefinitionManager()
Set oComponentManager = oDefinitionManager.GetManager("Component")
oComponentManager.ImportModelsFromFile oSml1, Array("NAME:Options", "Mode:=", _
  1)
oComponentManager.ImportModelsFromFile oSml2, Array("NAME:Options", "Mode:=", _
  1)
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "Setup1", _
  "Id:=", "2"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.05334, "Y:=", _
  -0.03048, "Degrees:=", 0, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@Setup1;2;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "IndM3"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@Setup1;2;0"), Array("NAME:NewProps", _
  Array("NAME:InstanceName", "Format:=", "Value", "Location:=", "Center"))))
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "A", "Id:=", 3), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", -0.02794, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "B", "Id:=", 4), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", -0.03048, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "C", "Id:=", 5), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", -0.03302, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "N", "Id:=", 6), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.05842, "Y:=", -0.02794, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "ROT1", "Id:=", 7), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.05842, "Y:=", -0.03048, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "ROT2", "Id:=", 8), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.05842, "Y:=", -0.03302, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "V_ROT", "Id:=", _
  "9"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.09144, "Y:=", -0.0254, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@V_ROT;9;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "speed"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@V_ROT;9;0"), Array("NAME:ChangedProps", _
  Array("NAME:VALUE", "OverridingDef:=", true, "Value:=", "618.198rpm"))))
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "ROT1", "Id:=", _
  10), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.08636, "Y:=", -0.02794, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "ROT2", "Id:=", _
  11), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.08636, "Y:=", -0.0381, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreateGround Array("NAME:GroundProps", "Id:=", "1"), Array(_
  "NAME:Attributes", "Page:=", 1, "X:=", 0.08636, "Y:=", -0.04064, _
  "Degrees:=", 0, "Flip:=", false) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "AM", "Id:=", _
  "12"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04318, "Y:=", 0.00762, _
  "Degrees:=", 90, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@AM;12;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "IA"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@AM;12;0"), Array("NAME:NewProps", _
  Array("NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "AM", "Id:=", _
  "13"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04318, "Y:=", _
  -0.00254, "Degrees:=", 90, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@AM;13;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "IB"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@AM;13;0"), Array("NAME:NewProps", _
  Array("NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "AM", "Id:=", _
  "14"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04318, "Y:=", -0.0127, _
  "Degrees:=", 90, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@AM;14;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "IC"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@AM;14;0"), Array("NAME:NewProps", _
  Array("NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "A", "Id:=", 15), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", 0.01016, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "B", "Id:=", 16), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", 0, "Degrees:=", _
  180, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "C", "Id:=", 17), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.04826, "Y:=", -0.01016, _
  "Degrees:=", 180, "Flip:=", false) 
oEditor.CreatePagePort Array("NAME:PagePortProps", "Name:=", "N", "Id:=", 18), _
  Array("NAME:Attributes", "Page:=", 1, "X:=", 0.07874, "Y:=", 0, "Degrees:=", _
  0, "Flip:=", false) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "VM", "Id:=", _
  "19"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.08382, "Y:=", _
  -0.00254, "Degrees:=", 90, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@VM;19;0"), Array("NAME:NewProps", _
  Array("NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.CreateGround Array("NAME:GroundProps", "Id:=", "1"), Array(_
  "NAME:Attributes", "Page:=", 1, "X:=", 0.0889, "Y:=", -0.00254, "Degrees:=", _
  0, "Flip:=", false) 
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0, -0.0381)", "(0.0254, -0.0381)")), Array("NAME:Attributes", "Page:=", 1) 
oEditor.CreateGround Array("NAME:GroundProps", "Id:=", "1"), Array(_
  "NAME:Attributes", "Page:=", 1, "X:=", 0.0127, "Y:=", -0.04064, "Degrees:=", _
  0, "Flip:=", false) 
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0, -0.0381)", "(0, -0.03556)")), Array("NAME:Attributes", "Page:=", 1) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "E", "Id:=", _
  "20"), Array("NAME:Attributes", "Page:=", 1, "X:=", -0.00254, "Y:=", _
  -0.03048, "Degrees:=", 0, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@E;20;0"), Array("NAME:NewProps", Array(_
  "NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "VA"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", _
  Array("NAME:Type", "OverridingDef:=", true, "Value:=", "ESINE"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", Array(_
  "NAME:AMPL", "OverridingDef:=", true, "Value:=", "326.599V"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", Array(_
  "NAME:FREQ", "OverridingDef:=", true, "Value:=", "50Hz"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", Array(_
  "NAME:TPERIO", "OverridingDef:=", true, "Value:=", "0.02s"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;20;0"), Array("NAME:ChangedProps", Array(_
  "NAME:PHASE", "OverridingDef:=", true, "Value:=", "0deg"))))
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0, -0.0254)", "(0, 0.01016)", "(0.0381, 0.01016)")), Array(_
  "NAME:Attributes", "Page:=", 1) 
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0.0127, -0.0381)", "(0.0127, -0.03556)")), Array("NAME:Attributes", _
  "Page:=", 1) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "E", "Id:=", _
  "21"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.01016, "Y:=", _
  -0.03048, "Degrees:=", 0, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@E;21;0"), Array("NAME:NewProps", Array(_
  "NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "VB"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", _
  Array("NAME:Type", "OverridingDef:=", true, "Value:=", "ESINE"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", Array(_
  "NAME:AMPL", "OverridingDef:=", true, "Value:=", "326.599V"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", Array(_
  "NAME:FREQ", "OverridingDef:=", true, "Value:=", "50Hz"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", Array(_
  "NAME:TPERIO", "OverridingDef:=", true, "Value:=", "0.02s"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;21;0"), Array("NAME:ChangedProps", Array(_
  "NAME:PHASE", "OverridingDef:=", true, "Value:=", "240deg"))))
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0.0127, -0.0254)", "(0.0127, 0)", "(0.0381, 0)")), Array(_
  "NAME:Attributes", "Page:=", 1) 
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0.0254, -0.0381)", "(0.0254, -0.03556)")), Array("NAME:Attributes", _
  "Page:=", 1) 
oEditor.CreateComponent Array("NAME:ComponentProps", "Name:=", "E", "Id:=", _
  "22"), Array("NAME:Attributes", "Page:=", 1, "X:=", 0.02286, "Y:=", _
  -0.03048, "Degrees:=", 0, "Flip:=", false) 
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PropDisplayPropTab", _
  Array("NAME:PropServers", "CompInst@E;22;0"), Array("NAME:NewProps", Array(_
  "NAME:InstanceName", "Format:=", "Value", "Location:=", "Right"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", _
  Array("NAME:InstanceName", "OverridingDef:=", true, "Value:=", "VC"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:PassedParameterTab", _
  Array("NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", _
  Array("NAME:Type", "OverridingDef:=", true, "Value:=", "ESINE"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", Array(_
  "NAME:AMPL", "OverridingDef:=", true, "Value:=", "326.599V"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", Array(_
  "NAME:FREQ", "OverridingDef:=", true, "Value:=", "50Hz"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", Array(_
  "NAME:TPERIO", "OverridingDef:=", true, "Value:=", "0.02s"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Quantities", Array(_
  "NAME:PropServers", "CompInst@E;22;0"), Array("NAME:ChangedProps", Array(_
  "NAME:PHASE", "OverridingDef:=", true, "Value:=", "120deg"))))
oEditor.CreateWire Array("NAME:WireData", "Id:=", "1", "Points:=", Array(_
  "(0.0254, -0.0254)", "(0.0254, -0.01016)", "(0.0381, -0.01016)")), Array(_
  "NAME:Attributes", "Page:=", 1) 
Set oModule = oDesign.GetModule("SimSetup")
oModule.EditTransient "TR", Array("NAME:SimSetup", "OptionName:=", _
  "(Default Options)", "AnalysisEnabled:=", 1, "Name:=", "TR", _
  "TransientData:=", Array("100ms", "2us", "20us", false, ""), _
  "EnableContSolve:=", false)
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "Load Torque", "Standard", "Rectangular Plot", "TR", _
  Array("NAME:Context", "SimValueContext:=", _
  Array(1, 0, 2, 0, false, false, -1, 1, 0, 1, 1, "", 0, 0)), Array("Time:=", _
  Array("All")), Array("X Component:=", "Time", "Y Component:=", Array(_
  "speed.TORQUE")), Array()
oModule.CreateReport "Current", "Standard", "Rectangular Plot", "TR", Array(_
  "NAME:Context", "SimValueContext:=", _
  Array(1, 0, 2, 0, false, false, -1, 1, 0, 1, 1, "", 0, 0)), Array("Time:=", _
  Array("All")), Array("X Component:=", "Time", "Y Component:=", Array(_
  "IA.I", "IB.I", "IC.I")), Array()
if (oArgs.Count > 1) then 
  oProject.SetActiveDesign oArgs(1)
else
  oProject.SetActiveDesign "Simplorer1"
end if
oEditor.ZoomToFit
if (oArgs.Count > 0) then 
  oProject.SaveAs oArgs(0), TRUE
end if
