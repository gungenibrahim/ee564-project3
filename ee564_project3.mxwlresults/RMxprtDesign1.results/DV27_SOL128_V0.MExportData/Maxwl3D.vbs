' --------------------------------------------------------------------
' Script Created by RMxprt to generate Maxwell 3D Version 13.0 design 
' Can specify one arg to setup external circuit                       
' --------------------------------------------------------------------

Set oAnsoftApp = CreateObject("AnsoftMaxwell.MaxwellScriptInterface")
Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oArgs = AnsoftScript.arguments
oDesktop.RestoreWindow
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
designName = oDesign.GetName
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.SetModelUnits Array("NAME:Units Parameter", "Units:=", "mm", _
  "Rescale:=", false)
oDesign.SetSolutionType "Transient"
Set oModule = oDesign.GetModule("BoundarySetup")
if (oArgs.Count = 1) then 
oModule.EditExternalCircuit oArgs(0), Array(), Array(), Array(), Array()
end if
oEditor.SetModelValidationSettings Array("NAME:Validation Options", _
  "EntityCheckLevel:=", "Strict", "IgnoreUnclassifiedObjects:=", true)
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", _
  Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array(_
  "NAME:fractions", "PropType:=", "VariableProp", "UserDef:=", true, _
  "Value:=", "4"))))
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", _
  Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array(_
  "NAME:halfAxial", "PropType:=", "VariableProp", "UserDef:=", true, _
  "Value:=", "0"))))
Set oDefinitionManager = oProject.GetDefinitionManager()
oDefinitionManager.ModifyLibraries designName, Array("NAME:PersonalLib"), _
  Array("NAME:UserLib"), Array("NAME:SystemLib", "Materials:=", Array(_
  "Materials", "RMxprt"))
if (oDefinitionManager.DoesMaterialExist("iron_3DSF0.950")) then
else
oDefinitionManager.AddMaterial Array("NAME:iron_3DSF0.950", _
  "CoordinateSystemType:=", "Cartesian", Array("NAME:AttachedData"), Array(_
  "NAME:ModifierData"), "permeability:=", "4000")
end if
if (oDefinitionManager.DoesMaterialExist("aluminum_75C")) then
else
oDefinitionManager.AddMaterial Array("NAME:aluminum_75C", _
  "CoordinateSystemType:=", "Cartesian", Array("NAME:AttachedData"), Array(_
  "NAME:ModifierData"), "conductivity:=", "3.8e+007")
end if
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/Band", "Version:=", "12.1", "NoOfParameters:=", 7, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "542.6949999999999mm"), Array("NAME:Pair", _
  "Name:=", "DiaYoke", "Value:=", "100mm"), Array("NAME:Pair", "Name:=", _
  "Length", "Value:=", "599.9364911257387mm"), Array("NAME:Pair", "Name:=", _
  "SegAngle", "Value:=", "1.25deg"), Array("NAME:Pair", "Name:=", "Fractions", _
  "Value:=", "1"), Array("NAME:Pair", "Name:=", "HalfAxial", "Value:=", "0"), _
  Array("NAME:Pair", "Name:=", "InfoCore", "Value:=", "0"))), Array(_
  "NAME:Attributes", "Name:=", "Band", "Flags:=", "", "Color:=", _
  "(0 255 255)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", _
  "MaterialName:=", "vacuum", "SolveInside:=", true) 
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/Band", "Version:=", "12.1", "NoOfParameters:=", 7, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "542.6949999999999mm"), Array("NAME:Pair", _
  "Name:=", "DiaYoke", "Value:=", "100mm"), Array("NAME:Pair", "Name:=", _
  "Length", "Value:=", "599.9364911257387mm"), Array("NAME:Pair", "Name:=", _
  "SegAngle", "Value:=", "1.25deg"), Array("NAME:Pair", "Name:=", "Fractions", _
  "Value:=", "1"), Array("NAME:Pair", "Name:=", "HalfAxial", "Value:=", "0"), _
  Array("NAME:Pair", "Name:=", "InfoCore", "Value:=", "100"))), Array(_
  "NAME:Attributes", "Name:=", "Shaft", "Flags:=", "", "Color:=", _
  "(0 255 255)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", _
  "MaterialName:=", "vacuum", "SolveInside:=", true) 
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/Band", "Version:=", "12.1", "NoOfParameters:=", 7, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "542.6949999999999mm"), Array("NAME:Pair", _
  "Name:=", "DiaYoke", "Value:=", "755mm"), Array("NAME:Pair", "Name:=", _
  "Length", "Value:=", "599.9364911257387mm"), Array("NAME:Pair", "Name:=", _
  "SegAngle", "Value:=", "1.25deg"), Array("NAME:Pair", "Name:=", "Fractions", _
  "Value:=", "4"), Array("NAME:Pair", "Name:=", "HalfAxial", "Value:=", "0"), _
  Array("NAME:Pair", "Name:=", "InfoCore", "Value:=", "100"))), Array(_
  "NAME:Attributes", "Name:=", "OuterRegion", "Flags:=", "", "Color:=", _
  "(0 255 255)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", _
  "MaterialName:=", "vacuum", "SolveInside:=", true) 
oEditor.SetPropertyValue "Geometry3DCmdTab", _
  "OuterRegion:CreateUserDefinedPart:1", "Fractions", "fractions"
On Error Resume Next
oEditor.SetPropertyValue "Geometry3DCmdTab", _
  "OuterRegion:CreateUserDefinedPart:1", "HalfAxial", "halfAxial"
On Error Goto 0
oEditor.Copy Array("NAME:Selections", "Selections:=", _
  "OuterRegion")
oEditor.Paste
oEditor.SetPropertyValue "Geometry3DCmdTab", _
  "OuterRegion1:CreateUserDefinedPart:1", "InfoCore", "2"
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "OuterRegion1"), _
  Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "MasterSheet"))))
oEditor.Copy Array("NAME:Selections", "Selections:=", "MasterSheet")
oEditor.Paste
oEditor.SetPropertyValue "Geometry3DCmdTab", _
  "MasterSheet1:CreateUserDefinedPart:1", "InfoCore", "3"
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "MasterSheet1"), _
  Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "SlaveSheet"))))
oEditor.Copy Array("NAME:Selections", "Selections:=", "OuterRegion")
oEditor.Paste
oEditor.SetPropertyValue "Geometry3DCmdTab", _
  "OuterRegion1:CreateUserDefinedPart:1", "InfoCore", "1"
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "OuterRegion1"), _
  Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "Tool"))))
oEditor.FitAll
Set oModule = oDesign.GetModule("ModelSetup")
oModule.SetSymmetryMultiplier "fractions*(1+halfAxial)"
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:Master", "Objects:=", Array("MasterSheet"), _
  Array("NAME:CoordSysVector", "Origin:=", Array("0mm", "0mm", "0mm"), _
  "UPos:=", Array("377.5mm", "0mm", "0mm")), "ReverseV:=", true)
oModule.AssignSlave Array("NAME:Slave", "Objects:=", Array("SlaveSheet"), _
  Array("NAME:CoordSysVector", "Origin:=", Array("0mm", "0mm", "0mm"), _
  "UPos:=", Array("2.3115208333906291e-014mm", "377.5mm", "0mm")), _
  "ReverseV:=", true, "Master:=", "Master", "RelationIsSame:=", true)
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/SlotCore", "Version:=", "12.1", "NoOfParameters:=", 19, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "543.3mm"), Array("NAME:Pair", "Name:=", _
  "DiaYoke", "Value:=", "755mm"), Array("NAME:Pair", "Name:=", "Length", _
  "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", "Skew", "Value:=", _
  "0deg"), Array("NAME:Pair", "Name:=", "Slots", "Value:=", "72"), Array(_
  "NAME:Pair", "Name:=", "SlotType", "Value:=", "3"), Array("NAME:Pair", _
  "Name:=", "Hs0", "Value:=", "2mm"), Array("NAME:Pair", "Name:=", "Hs01", _
  "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs1", "Value:=", "1mm"), _
  Array("NAME:Pair", "Name:=", "Hs2", "Value:=", "60mm"), Array("NAME:Pair", _
  "Name:=", "Bs0", "Value:=", "6mm"), Array("NAME:Pair", "Name:=", "Bs1", _
  "Value:=", "17mm"), Array("NAME:Pair", "Name:=", "Bs2", "Value:=", "22mm"), _
  Array("NAME:Pair", "Name:=", "Rs", "Value:=", "2mm"), Array("NAME:Pair", _
  "Name:=", "FilletType", "Value:=", "0"), Array("NAME:Pair", "Name:=", _
  "HalfSlot", "Value:=", "0"), Array("NAME:Pair", "Name:=", "SegAngle", _
  "Value:=", "30deg"), Array("NAME:Pair", "Name:=", "LenRegion", "Value:=", _
  "599.9364911257387mm"), Array("NAME:Pair", "Name:=", "InfoCore", "Value:=", _
  "0"))), Array("NAME:Attributes", "Name:=", "Stator", "Flags:=", "", _
  "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", _
  "Global", "MaterialName:=", "iron_3DSF0.950", "SolveInside:=", true) 
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/LapCoil", "Version:=", "12.0", "NoOfParameters:=", 21, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "543.3mm"), Array("NAME:Pair", "Name:=", _
  "DiaYoke", "Value:=", "755mm"), Array("NAME:Pair", "Name:=", "Length", _
  "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", "Skew", "Value:=", _
  "0deg"), Array("NAME:Pair", "Name:=", "Slots", "Value:=", "72"), Array(_
  "NAME:Pair", "Name:=", "SlotType", "Value:=", "3"), Array("NAME:Pair", _
  "Name:=", "Hs0", "Value:=", "2mm"), Array("NAME:Pair", "Name:=", "Hs1", _
  "Value:=", "1mm"), Array("NAME:Pair", "Name:=", "Hs2", "Value:=", "60mm"), _
  Array("NAME:Pair", "Name:=", "Bs0", "Value:=", "6mm"), Array("NAME:Pair", _
  "Name:=", "Bs1", "Value:=", "17mm"), Array("NAME:Pair", "Name:=", "Bs2", _
  "Value:=", "22mm"), Array("NAME:Pair", "Name:=", "Rs", "Value:=", "2mm"), _
  Array("NAME:Pair", "Name:=", "FilletType", "Value:=", "0"), Array(_
  "NAME:Pair", "Name:=", "Layers", "Value:=", "2"), Array("NAME:Pair", _
  "Name:=", "CoilPitch", "Value:=", "7"), Array("NAME:Pair", "Name:=", _
  "EndExt", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "SpanExt", _
  "Value:=", "0.1mm"), Array("NAME:Pair", "Name:=", "SegAngle", "Value:=", _
  "5deg"), Array("NAME:Pair", "Name:=", "LenRegion", "Value:=", _
  "599.9364911257387mm"), Array("NAME:Pair", "Name:=", "InfoCoil", "Value:=", _
  "1"))), Array("NAME:Attributes", "Name:=", "Coil", "Flags:=", "", "Color:=", _
  "(250 167 14)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", _
  "MaterialName:=", "copper", "SolveInside:=", true) 
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "Coil"), _
  Array("NAME:DuplicateAroundAxisParameters", "CoordinateSystemID:=", -1, _
  "CreateNewObjects:=", true, "WhichAxis:=", "Z", "AngleStr:=", "5deg", _
  "NumClones:=", "72"), Array("NAME:Options", "DuplicateBoundaries:=", false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "Coil"), Array(_
  "NAME:ChangedProps", Array("NAME:Name", "Value:=", "Coil_0"))))
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/LapCoil", "Version:=", "12.0", "NoOfParameters:=", 21, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "543.3mm"), Array("NAME:Pair", "Name:=", _
  "DiaYoke", "Value:=", "755mm"), Array("NAME:Pair", "Name:=", "Length", _
  "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", "Skew", "Value:=", _
  "0deg"), Array("NAME:Pair", "Name:=", "Slots", "Value:=", "72"), Array(_
  "NAME:Pair", "Name:=", "SlotType", "Value:=", "3"), Array("NAME:Pair", _
  "Name:=", "Hs0", "Value:=", "2mm"), Array("NAME:Pair", "Name:=", "Hs1", _
  "Value:=", "1mm"), Array("NAME:Pair", "Name:=", "Hs2", "Value:=", "60mm"), _
  Array("NAME:Pair", "Name:=", "Bs0", "Value:=", "6mm"), Array("NAME:Pair", _
  "Name:=", "Bs1", "Value:=", "17mm"), Array("NAME:Pair", "Name:=", "Bs2", _
  "Value:=", "22mm"), Array("NAME:Pair", "Name:=", "Rs", "Value:=", "2mm"), _
  Array("NAME:Pair", "Name:=", "FilletType", "Value:=", "0"), Array(_
  "NAME:Pair", "Name:=", "Layers", "Value:=", "2"), Array("NAME:Pair", _
  "Name:=", "CoilPitch", "Value:=", "7"), Array("NAME:Pair", "Name:=", _
  "EndExt", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "SpanExt", _
  "Value:=", "0.1mm"), Array("NAME:Pair", "Name:=", "SegAngle", "Value:=", _
  "5deg"), Array("NAME:Pair", "Name:=", "LenRegion", "Value:=", _
  "599.9364911257387mm"), Array("NAME:Pair", "Name:=", "InfoCoil", "Value:=", _
  "2"))), Array("NAME:Attributes", "Name:=", "CoilTerm", "Flags:=", "", _
  "Color:=", "(250 167 14)", "Transparency:=", 0, "PartCoordinateSystem:=", _
  "Global", "MaterialName:=", "copper", "SolveInside:=", true) 
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", _
  "CoilTerm"), Array("NAME:DuplicateAroundAxisParameters", _
  "CoordinateSystemID:=", -1, "CreateNewObjects:=", true, "WhichAxis:=", "Z", _
  "AngleStr:=", "5deg", "NumClones:=", "72"), Array("NAME:Options", _
  "DuplicateBoundaries:=", false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "CoilTerm"), _
  Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "CoilTerm_0"))))
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignWindingGroup Array("NAME:PhaseA", "Type:=", "Voltage", _
  "IsSolid:=", false, "Current:=", "0A", "Resistance:=", "0.00402947ohm", _
  "Inductance:=", "0H", "Voltage:=", "326.599 * sin(2*pi*50*time)", _
  "ParallelBranchesNum:=", "1")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignWindingGroup Array("NAME:PhaseB", "Type:=", "Voltage", _
  "IsSolid:=", false, "Current:=", "0A", "Resistance:=", "0.00402947ohm", _
  "Inductance:=", "0H", "Voltage:=", "326.599 * sin(2*pi*50*time-2*pi/3)", _
  "ParallelBranchesNum:=", "1")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignWindingGroup Array("NAME:PhaseC", "Type:=", "Voltage", _
  "IsSolid:=", false, "Current:=", "0A", "Resistance:=", "0.00402947ohm", _
  "Inductance:=", "0H", "Voltage:=", "326.599 * sin(2*pi*50*time-4*pi/3)", _
  "ParallelBranchesNum:=", "1")
oModule.AssignCoilTerminal Array("NAME:PhA_0", "Objects:=", Array("CoilTerm_0"), _
  "Conductor number:=", 2, "Point out of terminal:=", false, "Winding:=", _
  "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_1", "Objects:=", Array("CoilTerm_1"), _
  "Conductor number:=", 1, "Point out of terminal:=", false, "Winding:=", _
  "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_2", "Objects:=", Array("CoilTerm_2"), _
  "Conductor number:=", 2, "Point out of terminal:=", false, "Winding:=", _
  "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhCRe_3", "Objects:=", Array(_
  "CoilTerm_3"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_4", "Objects:=", Array(_
  "CoilTerm_4"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_5", "Objects:=", Array(_
  "CoilTerm_5"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhB_6", "Objects:=", Array("CoilTerm_6"), _
  "Conductor number:=", 2, "Point out of terminal:=", false, "Winding:=", _
  "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_7", "Objects:=", Array("CoilTerm_7"), _
  "Conductor number:=", 1, "Point out of terminal:=", false, "Winding:=", _
  "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_8", "Objects:=", Array("CoilTerm_8"), _
  "Conductor number:=", 2, "Point out of terminal:=", false, "Winding:=", _
  "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhARe_9", "Objects:=", Array(_
  "CoilTerm_9"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_10", "Objects:=", Array(_
  "CoilTerm_10"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_11", "Objects:=", Array(_
  "CoilTerm_11"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhC_12", "Objects:=", Array(_
  "CoilTerm_12"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_13", "Objects:=", Array(_
  "CoilTerm_13"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_14", "Objects:=", Array(_
  "CoilTerm_14"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhBRe_15", "Objects:=", Array(_
  "CoilTerm_15"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_16", "Objects:=", Array(_
  "CoilTerm_16"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_17", "Objects:=", Array(_
  "CoilTerm_17"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhA_18", "Objects:=", Array(_
  "CoilTerm_18"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_19", "Objects:=", Array(_
  "CoilTerm_19"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_20", "Objects:=", Array(_
  "CoilTerm_20"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhCRe_21", "Objects:=", Array(_
  "CoilTerm_21"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_22", "Objects:=", Array(_
  "CoilTerm_22"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_23", "Objects:=", Array(_
  "CoilTerm_23"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhB_24", "Objects:=", Array(_
  "CoilTerm_24"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_25", "Objects:=", Array(_
  "CoilTerm_25"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_26", "Objects:=", Array(_
  "CoilTerm_26"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhARe_27", "Objects:=", Array(_
  "CoilTerm_27"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_28", "Objects:=", Array(_
  "CoilTerm_28"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_29", "Objects:=", Array(_
  "CoilTerm_29"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhC_30", "Objects:=", Array(_
  "CoilTerm_30"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_31", "Objects:=", Array(_
  "CoilTerm_31"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_32", "Objects:=", Array(_
  "CoilTerm_32"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhBRe_33", "Objects:=", Array(_
  "CoilTerm_33"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_34", "Objects:=", Array(_
  "CoilTerm_34"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_35", "Objects:=", Array(_
  "CoilTerm_35"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhA_36", "Objects:=", Array(_
  "CoilTerm_36"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_37", "Objects:=", Array(_
  "CoilTerm_37"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_38", "Objects:=", Array(_
  "CoilTerm_38"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhCRe_39", "Objects:=", Array(_
  "CoilTerm_39"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_40", "Objects:=", Array(_
  "CoilTerm_40"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_41", "Objects:=", Array(_
  "CoilTerm_41"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhB_42", "Objects:=", Array(_
  "CoilTerm_42"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_43", "Objects:=", Array(_
  "CoilTerm_43"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_44", "Objects:=", Array(_
  "CoilTerm_44"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhARe_45", "Objects:=", Array(_
  "CoilTerm_45"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_46", "Objects:=", Array(_
  "CoilTerm_46"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_47", "Objects:=", Array(_
  "CoilTerm_47"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhC_48", "Objects:=", Array(_
  "CoilTerm_48"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_49", "Objects:=", Array(_
  "CoilTerm_49"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_50", "Objects:=", Array(_
  "CoilTerm_50"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhBRe_51", "Objects:=", Array(_
  "CoilTerm_51"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_52", "Objects:=", Array(_
  "CoilTerm_52"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_53", "Objects:=", Array(_
  "CoilTerm_53"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhA_54", "Objects:=", Array(_
  "CoilTerm_54"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_55", "Objects:=", Array(_
  "CoilTerm_55"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhA_56", "Objects:=", Array(_
  "CoilTerm_56"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhCRe_57", "Objects:=", Array(_
  "CoilTerm_57"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_58", "Objects:=", Array(_
  "CoilTerm_58"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhCRe_59", "Objects:=", Array(_
  "CoilTerm_59"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhB_60", "Objects:=", Array(_
  "CoilTerm_60"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_61", "Objects:=", Array(_
  "CoilTerm_61"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhB_62", "Objects:=", Array(_
  "CoilTerm_62"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhARe_63", "Objects:=", Array(_
  "CoilTerm_63"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_64", "Objects:=", Array(_
  "CoilTerm_64"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhARe_65", "Objects:=", Array(_
  "CoilTerm_65"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseA")
oModule.AssignCoilTerminal Array("NAME:PhC_66", "Objects:=", Array(_
  "CoilTerm_66"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_67", "Objects:=", Array(_
  "CoilTerm_67"), "Conductor number:=", 1, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhC_68", "Objects:=", Array(_
  "CoilTerm_68"), "Conductor number:=", 2, "Point out of terminal:=", false, _
  "Winding:=", "PhaseC")
oModule.AssignCoilTerminal Array("NAME:PhBRe_69", "Objects:=", Array(_
  "CoilTerm_69"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_70", "Objects:=", Array(_
  "CoilTerm_70"), "Conductor number:=", 2, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
oModule.AssignCoilTerminal Array("NAME:PhBRe_71", "Objects:=", Array(_
  "CoilTerm_71"), "Conductor number:=", 1, "Point out of terminal:=", true, _
  "Winding:=", "PhaseB")
Set oModule = oDesign.GetModule("MeshSetup")
oModule.AssignLengthOp Array("NAME:Length_Coil", "RefineInside:=", true, _
  "Objects:=", Array("Coil_0", "Coil_1", "Coil_2", "Coil_3", "Coil_4", _
  "Coil_5", "Coil_6", "Coil_7", "Coil_8", "Coil_9", "Coil_10", "Coil_11", _
  "Coil_12", "Coil_13", "Coil_14", "Coil_15", "Coil_16", "Coil_17", "Coil_18", _
  "Coil_19", "Coil_20", "Coil_21", "Coil_22", "Coil_23", "Coil_24", "Coil_25", _
  "Coil_26", "Coil_27", "Coil_28", "Coil_29", "Coil_30", "Coil_31", "Coil_32", _
  "Coil_33", "Coil_34", "Coil_35", "Coil_36", "Coil_37", "Coil_38", "Coil_39", _
  "Coil_40", "Coil_41", "Coil_42", "Coil_43", "Coil_44", "Coil_45", "Coil_46", _
  "Coil_47", "Coil_48", "Coil_49", "Coil_50", "Coil_51", "Coil_52", "Coil_53", _
  "Coil_54", "Coil_55", "Coil_56", "Coil_57", "Coil_58", "Coil_59", "Coil_60", _
  "Coil_61", "Coil_62", "Coil_63", "Coil_64", "Coil_65", "Coil_66", "Coil_67", _
  "Coil_68", "Coil_69", "Coil_70", "Coil_71"), "RestrictElem:=", false, _
  "NumMaxElem:=", "1000", "RestrictLength:=", true, "MaxLength:=", "39mm")
Set oModule = oDesign.GetModule("MeshSetup")
oModule.AssignTrueSurfOp Array("NAME:SurfApprox_Coil", "Objects:=", Array(_
  "Coil_0", "Coil_1", "Coil_2", "Coil_3", "Coil_4", "Coil_5", "Coil_6", _
  "Coil_7", "Coil_8", "Coil_9", "Coil_10", "Coil_11", "Coil_12", "Coil_13", _
  "Coil_14", "Coil_15", "Coil_16", "Coil_17", "Coil_18", "Coil_19", "Coil_20", _
  "Coil_21", "Coil_22", "Coil_23", "Coil_24", "Coil_25", "Coil_26", "Coil_27", _
  "Coil_28", "Coil_29", "Coil_30", "Coil_31", "Coil_32", "Coil_33", "Coil_34", _
  "Coil_35", "Coil_36", "Coil_37", "Coil_38", "Coil_39", "Coil_40", "Coil_41", _
  "Coil_42", "Coil_43", "Coil_44", "Coil_45", "Coil_46", "Coil_47", "Coil_48", _
  "Coil_49", "Coil_50", "Coil_51", "Coil_52", "Coil_53", "Coil_54", "Coil_55", _
  "Coil_56", "Coil_57", "Coil_58", "Coil_59", "Coil_60", "Coil_61", "Coil_62", _
  "Coil_63", "Coil_64", "Coil_65", "Coil_66", "Coil_67", "Coil_68", "Coil_69", _
  "Coil_70", "Coil_71"), "NormalDevChoice:=", 2, "NormalDev:=", "30deg", _
  "AspectRatioChoice:=", 1)
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/SlotCore", "Version:=", "12.1", "NoOfParameters:=", 19, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "542.09mm"), Array("NAME:Pair", "Name:=", _
  "DiaYoke", "Value:=", "100mm"), Array("NAME:Pair", "Name:=", "Length", _
  "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", "Skew", "Value:=", _
  "4.090909090909091deg"), Array("NAME:Pair", "Name:=", "Slots", "Value:=", _
  "88"), Array("NAME:Pair", "Name:=", "SlotType", "Value:=", "1"), Array(_
  "NAME:Pair", "Name:=", "Hs0", "Value:=", "2mm"), Array("NAME:Pair", _
  "Name:=", "Hs01", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs1", _
  "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs2", "Value:=", _
  "145.15mm"), Array("NAME:Pair", "Name:=", "Bs0", "Value:=", "3mm"), Array(_
  "NAME:Pair", "Name:=", "Bs1", "Value:=", "13.51mm"), Array("NAME:Pair", _
  "Name:=", "Bs2", "Value:=", "3mm"), Array("NAME:Pair", "Name:=", "Rs", _
  "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "FilletType", "Value:=", _
  "0"), Array("NAME:Pair", "Name:=", "HalfSlot", "Value:=", "0"), Array(_
  "NAME:Pair", "Name:=", "SegAngle", "Value:=", "30deg"), Array("NAME:Pair", _
  "Name:=", "LenRegion", "Value:=", "599.9364911257387mm"), Array("NAME:Pair", _
  "Name:=", "InfoCore", "Value:=", "0"))), Array("NAME:Attributes", "Name:=", _
  "Rotor", "Flags:=", "", "Color:=", "(132 132 193)", "Transparency:=", 0, _
  "PartCoordinateSystem:=", "Global", "MaterialName:=", "iron_3DSF0.950", _
  "SolveInside:=", true) 
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/SquirrelCage", "Version:=", "12.11", _
  "NoOfParameters:=", 24, "Library:=", "syslib", Array("NAME:ParamVector", _
  Array("NAME:Pair", "Name:=", "DiaGap", "Value:=", "542.09mm"), Array(_
  "NAME:Pair", "Name:=", "DiaYoke", "Value:=", "100mm"), Array("NAME:Pair", _
  "Name:=", "Length", "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", _
  "Skew", "Value:=", "4.090909090909091deg"), Array("NAME:Pair", "Name:=", _
  "Slots", "Value:=", "88"), Array("NAME:Pair", "Name:=", "SlotType", _
  "Value:=", "1"), Array("NAME:Pair", "Name:=", "Hs0", "Value:=", "2mm"), _
  Array("NAME:Pair", "Name:=", "Hs01", "Value:=", "0mm"), Array("NAME:Pair", _
  "Name:=", "Hs1", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs2", _
  "Value:=", "145.15mm"), Array("NAME:Pair", "Name:=", "Bs0", "Value:=", _
  "3mm"), Array("NAME:Pair", "Name:=", "Bs1", "Value:=", "13.51mm"), Array(_
  "NAME:Pair", "Name:=", "Bs2", "Value:=", "3mm"), Array("NAME:Pair", _
  "Name:=", "Rs", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", _
  "FilletType", "Value:=", "0"), Array("NAME:Pair", "Name:=", "HalfSlot", _
  "Value:=", "0"), Array("NAME:Pair", "Name:=", "BarEndExt", "Value:=", _
  "5.6mm"), Array("NAME:Pair", "Name:=", "RingLength", "Value:=", "5mm"), _
  Array("NAME:Pair", "Name:=", "RingHeight", "Value:=", "5mm"), Array(_
  "NAME:Pair", "Name:=", "RingDiaGap", "Value:=", "0mm"), Array("NAME:Pair", _
  "Name:=", "CastRotor", "Value:=", "1"), Array("NAME:Pair", "Name:=", _
  "SegAngle", "Value:=", "30deg"), Array("NAME:Pair", "Name:=", "LenRegion", _
  "Value:=", "599.9364911257387mm"), Array("NAME:Pair", "Name:=", "InfoCoil", _
  "Value:=", "0"))), Array("NAME:Attributes", "Name:=", "Bar", "Flags:=", "", _
  "Color:=", "(119 198 206)", "Transparency:=", 0, "PartCoordinateSystem:=", _
  "Global", "MaterialName:=", "aluminum_75C", "SolveInside:=", true) 
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "Bar", _
  "Tool Parts:=", "Tool"), Array("NAME:SubtractParameters", _
  "CoordinateSystemID:=", -1, "KeepOriginals:=", true)
oEditor.SeparateBody  Array("NAME:Selections", "Selections:=", "Bar")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.SetEddyEffect Array("NAME:Eddy Effect Setting", Array(_
  "NAME:EddyEffectVector", Array("NAME:Data", "Object Name:=", "Bar", _
  "Eddy Effect:=", true)))
Set oModule = oDesign.GetModule("MeshSetup")
oModule.AssignLengthOp Array("NAME:Length_Bar", "RefineInside:=", true, _
  "Objects:=", Array("Bar"), "RestrictElem:=", false, "NumMaxElem:=", "1000", _
  "RestrictLength:=", true, "MaxLength:=", "6mm")
oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", _
  "DllName:=", "RMxprt/SlotCore", "Version:=", "12.1", "NoOfParameters:=", 19, _
  "Library:=", "syslib", Array("NAME:ParamVector", Array("NAME:Pair", _
  "Name:=", "DiaGap", "Value:=", "542.09mm"), Array("NAME:Pair", "Name:=", _
  "DiaYoke", "Value:=", "100mm"), Array("NAME:Pair", "Name:=", "Length", _
  "Value:=", "338.7mm"), Array("NAME:Pair", "Name:=", "Skew", "Value:=", _
  "4.090909090909091deg"), Array("NAME:Pair", "Name:=", "Slots", "Value:=", _
  "88"), Array("NAME:Pair", "Name:=", "SlotType", "Value:=", "1"), Array(_
  "NAME:Pair", "Name:=", "Hs0", "Value:=", "2mm"), Array("NAME:Pair", _
  "Name:=", "Hs01", "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs1", _
  "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "Hs2", "Value:=", _
  "145.15mm"), Array("NAME:Pair", "Name:=", "Bs0", "Value:=", "3mm"), Array(_
  "NAME:Pair", "Name:=", "Bs1", "Value:=", "13.51mm"), Array("NAME:Pair", _
  "Name:=", "Bs2", "Value:=", "3mm"), Array("NAME:Pair", "Name:=", "Rs", _
  "Value:=", "0mm"), Array("NAME:Pair", "Name:=", "FilletType", "Value:=", _
  "0"), Array("NAME:Pair", "Name:=", "HalfSlot", "Value:=", "0"), Array(_
  "NAME:Pair", "Name:=", "SegAngle", "Value:=", "30deg"), Array("NAME:Pair", _
  "Name:=", "LenRegion", "Value:=", "599.9364911257387mm"), Array("NAME:Pair", _
  "Name:=", "InfoCore", "Value:=", "100"))), Array("NAME:Attributes", _
  "Name:=", "InnerRegion", "Flags:=", "", "Color:=", "(0 255 255)", _
  "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "MaterialName:=", _
  "vacuum", "SolveInside:=", true) 
Set oModule = oDesign.GetModule("MeshSetup")
oModule.AssignLengthOp Array("NAME:Length_Main", "RefineInside:=", true, _
  "Objects:=", Array("Stator", "Rotor", "Band", "OuterRegion", "InnerRegion", _
  "Shaft"), "RestrictElem:=", false, "NumMaxElem:=", "1000", _
  "RestrictLength:=", true, "MaxLength:=", "85.164mm")
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", "Band", _
  "OuterRegion", "InnerRegion", "MasterSheet", "SlaveSheet"), Array(_
  "NAME:ChangedProps", Array("NAME:Transparent", "Value:=", 0.75))))
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "Band,InnerRegion" & _
  ",Shaft,Stator,Coil_0,Coil_1,Coil_2,Coil_3,Coil_4,Coil_5,Coil_6,Coil_7" & _
  ",Coil_8,Coil_9,Coil_10,Coil_11,Coil_12,Coil_13,Coil_14,Coil_15,Coil_16" & _
  ",Coil_17,Coil_18,Coil_19,Coil_20,Coil_21,Coil_22,Coil_23,Coil_24" & _
  ",Coil_25,Coil_26,Coil_27,Coil_28,Coil_29,Coil_30,Coil_31,Coil_32" & _
  ",Coil_33,Coil_34,Coil_35,Coil_36,Coil_37,Coil_38,Coil_39,Coil_40" & _
  ",Coil_41,Coil_42,Coil_43,Coil_44,Coil_45,Coil_46,Coil_47,Coil_48" & _
  ",Coil_49,Coil_50,Coil_51,Coil_52,Coil_53,Coil_54,Coil_55,Coil_56" & _
  ",Coil_57,Coil_58,Coil_59,Coil_60,Coil_61,Coil_62,Coil_63,Coil_64" & _
  ",Coil_65,Coil_66,Coil_67,Coil_68,Coil_69,Coil_70,Coil_71,CoilTerm_0" & _
  ",CoilTerm_1,CoilTerm_2,CoilTerm_3,CoilTerm_4,CoilTerm_5,CoilTerm_6" & _
  ",CoilTerm_7,CoilTerm_8,CoilTerm_9,CoilTerm_10,CoilTerm_11,CoilTerm_12" & _
  ",CoilTerm_13,CoilTerm_14,CoilTerm_15,CoilTerm_16,CoilTerm_17" & _
  ",CoilTerm_18,CoilTerm_19,CoilTerm_20,CoilTerm_21,CoilTerm_22" & _
  ",CoilTerm_23,CoilTerm_24,CoilTerm_25,CoilTerm_26,CoilTerm_27" & _
  ",CoilTerm_28,CoilTerm_29,CoilTerm_30,CoilTerm_31,CoilTerm_32" & _
  ",CoilTerm_33,CoilTerm_34,CoilTerm_35,CoilTerm_36,CoilTerm_37" & _
  ",CoilTerm_38,CoilTerm_39,CoilTerm_40,CoilTerm_41,CoilTerm_42" & _
  ",CoilTerm_43,CoilTerm_44,CoilTerm_45,CoilTerm_46,CoilTerm_47" & _
  ",CoilTerm_48,CoilTerm_49,CoilTerm_50,CoilTerm_51,CoilTerm_52" & _
  ",CoilTerm_53,CoilTerm_54,CoilTerm_55,CoilTerm_56,CoilTerm_57" & _
  ",CoilTerm_58,CoilTerm_59,CoilTerm_60,CoilTerm_61,CoilTerm_62" & _
  ",CoilTerm_63,CoilTerm_64,CoilTerm_65,CoilTerm_66,CoilTerm_67" & _
  ",CoilTerm_68,CoilTerm_69,CoilTerm_70,CoilTerm_71,Rotor,Bar", _
  "Tool Parts:=", "Tool"), Array("NAME:SubtractParameters", _
  "CoordinateSystemID:=", -1, "KeepOriginals:=", false)
oEditor.SeparateBody  Array("NAME:Selections", "Selections:=", "Rotor")
oEditor.FitAll
Set oModule = oDesign.GetModule("ModelSetup")
oModule.AssignBand Array("NAME:MotionSetup1", "Move Type:=", "Rotate", _
  "Coordinate System:=", "Global", "Axis:=", "Z", "Is Positive:=", true, _
  "InitPos:=", "0deg", "HasRotateLimit:=", false, "NonCylindrical:=", false, _
  "Consider Mechanical Transient:=", true, "Angular Velocity:=", "800rpm", _
  "Moment of Inertia:=", 22.3973, "Damping:=", 0.0356345, "Load Torque:=", _
  "if(speed<138.23, 7.52604*speed, 143804/speed)", "Objects:=", Array("Band"))
oModule.EditMotionSetup Array("NAME:Data", "Consider Mechanical Transient:=", _
  false)
Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "Transient", Array("NAME:Setup1", "StopTime:=", "0.2s", _
  "TimeStep:=", "0.0002s")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.SetMinimumTimeStep "0.002ms" 
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "Torque", "Transient", "XY Plot", "Setup1 : Transient", _
  Array(), Array("Time:=", Array("All")), Array("X Component:=", "Time", _
  "Y Component:=", Array("Moving1.Torque")), Array()
oModule.CreateReport "Winding Currents", "Transient", "XY Plot", _
  "Setup1 : Transient", Array(), Array("Time:=", Array("All")), Array(_
  "X Component:=", "Time", "Y Component:=", Array("Current(PhaseA)", _
  "Current(PhaseB)", "Current(PhaseC)")), Array()
set oUnclassified = oEditor.GetObjectsInGroup("Unclassified")
Dim oObject
For Each oObject in oUnclassified
oEditor.ChangeProperty Array("NAME:AllTabs", Array(_
  "NAME:Geometry3DAttributeTab", Array("NAME:PropServers", oObject), Array(_
  "NAME:ChangedProps", Array("NAME:Model", "Value:=", false))))
Next
oEditor.ShowWindow
