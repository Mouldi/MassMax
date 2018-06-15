
 childrenchildren = #()
global rot = eulerToQuat(eulerAngles 0 0 0)
 
 fn CalculateDiff obj =
 (
 pivot )

 

fn SetUpObject obj =
(
	ResetTransform obj
	in coordsys #world
		obj.pos = [0.0,0.0,0.0]
	obj.rotation = rot
	ResetTransform obj

		
)
fn selectAllChildren  obj1 =
(
	
deselect selection
selectmore obj1	
if obj1.children != undefined do
(
	
selectmore obj1.children

for i = 1 to obj1.children.count do
(
if obj1.children[i].children != undefined do
(
	
	selectmore obj1.children[i].children

)

)
)
childrenchildren = selection as Array


)
fn FBX_Export  obj1 =
(
individualFBXs = #()
if obj1 != undefined then append individualFBXs  obj1
	


--Geometry------------------------------------------------------------------------
FBXExporterSetParam "SmoothingGroups" false
FBXExporterSetParam "NormalsPerPoly" false
FBXExporterSetParam "TangentSpaceExport" false
FBXExporterSetParam "SmoothMeshExport" false
FBXExporterSetParam "Preserveinstances" false
FBXExporterSetParam "SelectionSetExport" false
FBXExporterSetParam "GeomAsBone" false
FBXExporterSetParam "ColladaTriangulate" false
FBXExporterSetParam "PreserveEdgeOrientation" false
--Animation------------------------------------------------------------------------
FBXExporterSetParam "Animation" false
FBXExporterSetParam "Skin" false
FBXExporterSetParam "Shape" false
--Cameras------------------------------------------------------------------------
FBXExporterSetParam "Cameras" false
--Lights------------------------------------------------------------------------
FBXExporterSetParam "Lights" false
--Embed Media--------------------------------------------------------------------
FBXExporterSetParam "EmbedTextures" false
--Units----------------------------------------------------------------------------
--Axis Conversion-----------------------------------------------------------------
FBXExporterSetParam "AxisConversionMethod" "none"
FBXExporterSetParam "UpAxis" "Y" 
--UI----------------------------------------------------------------
FBXExporterSetParam "ShowWarnings" false
FBXExporterSetParam "GenerateLog" false
--FBX File Format----------------------------------------------------------------
FBXExporterSetParam "ASCII" false
FBXExporterSetParam "FileVersion" "FBX201400"

for n in individualFBXs do
(	
-- Path and file name stuff
makeDir (maxFilePath + "FBX")
--Do you need to put .fbx on the end of this? I'm not near a copy of max at the moment so i cant tell. 
FBXSavePath = (maxFilePath + "FBX\\" + n.name)


	addModifier n (Edit_Poly())
	collapseStack n
ResetTransform n
ResetScale n
	SetUpObject n
		
--You need to select the objects because fbx exporter is only exporting selected items.

exportFile FBXSavePath #noPrompt selectedOnly:true using:FBXEXP 
	
)
free individualFBXs
)


rollout ExportFBX "FBX Exporter" 
(
-- filter all objects of class Box:
Function weapon_filt obj = Superclassof obj == GeometryClass
-- Pickbutton to select a Box from the scene
pickbutton chooseit "Select Model" width:140 filter:weapon_filt
-- pickbutton choosesecond "Select Second Weapon" width:140 filter:weapon_filt

-- If the user picked an object, then
on chooseit picked obj do
(
	
-- see if the user did not cancel the picking...
if obj != undefined do
(
-- if he did not, make the box's wireframe red:
obj.wirecolor = red
-- and display the name of the object on the button:
chooseit.text = obj.name
	
in coordsys #world
	

	
selectAllChildren  obj	


FBX_Export obj



	
)
)

-- end on
)
-- end rollout
createDialog ExportFBX