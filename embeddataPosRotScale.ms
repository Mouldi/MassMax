
 
 
 obj1  -- xyz aligned pivot
obj2  -- rotated and moved pivot
fn AlignObjectAB obj obj1 =
(
	coordSys #world
	
	
	
	
	maxOps.pivotMode  = #objectonly
	Obj.objectOffsetPos = Obj1.objectOffsetPos
Obj.objectOffsetRot = Obj1.objectOffsetRot
Obj.objectOffsetScale = Obj1.objectOffsetScale
	
-- in coordSys #local 
-- 	
-- 	

-- 	obj.pos = obj1.pos
-- 	
-- 	
	
	
-- 	
-- 	
	maxOps.pivotMode  = #none

	)


fn CloneObjectData obj obj1 =
(
	in coordsys #world
	maxOps.pivotMode  = #pivotonly
-- 	obj.transform = obj1.transform
	obj.objectoffsetpos = obj1.objectoffsetpos
	obj.objectoffsetrot = obj1.objectoffsetrot
	obj.objectoffsetscale = obj1.objectoffsetscale
	
-- 	obj.pos = obj1.pos
-- 	obj.rotation = obj1.rotation 
-- 	obj.scale =  obj1.scale
-- 	
	maxOps.pivotMode  = #none
)

fn PlaceObj obj1 obj2 =
(
		in coordsys #world
	obj1.pos = obj2.pos
	obj1.rotation = obj2.rotation
	obj1.scale = obj2.scale
	)
-- define function for rotating only the pivot point







rollout pick_1st_weapon "Clone POS/ROT/Scale"
(
-- filter all objects of class Box:
Function weapon_filt obj = Superclassof obj == GeometryClass
-- Pickbutton to select a Box from the scene
pickbutton chooseit "Select First Weapon" width:140 filter:weapon_filt
pickbutton choosesecond "Select Second Weapon" width:140 filter:weapon_filt

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
		ResetTransform obj-- 	ResetPivot n
-- 	resetShape n
	collapseStack obj
obj1 = obj	

-- 	obj1= obj
-- 	obj1.transform = obj.transform
-- 	
-- 	obj1.objectoffsetrot = obj.rotation
-- obj1.rotation = obj.objectoffsetRot
-- obj1.pos = obj.pos
-- obj1.pivot = obj.pivot
--	coordsys local
	--#affectpivotonly
	
	
	
--	pivotpoint = obj.p as point3

	
)
)
on choosesecond picked obj do
(
-- see if the user did not cancel the picking...
if obj != undefined do
(
-- if he did not, make the box's wireframe red:
obj.wirecolor = red
-- and display the name of the object on the button:
	

	choosesecond.text = obj.name
	ResetTransform obj-- 	ResetPivot n
-- 	resetShape n
	collapseStack obj

-- 	
	-- 		
-- 	CloneObjectData obj obj1
-- 	PrepareObject obj obj1
-- 	

		
-- 		maxOps.pivotMode  = #pivotonly


-- 	
-- 	theCoords = (obj.transform * (inverse obj1.transform)).pos

-- 	
-- 	 obj.transform.pos =  theCoords
-- 	
--  maxOps.pivotMode  = #none
-- PlaceObject obj obj1
PlaceObj	 obj obj1
-- AlignObjectAB obj obj1
-- CloneObjectData obj obj1
	

-- 		RotatePivotOnly obj obj1.rotation
-- 		TransformPivot obj obj1.transform[1] (normalize obj1.pos)
		
-- 			obj.objectOffsetPos = obj1.objectOffsetPos
-- 		obj.objectOffsetScale = obj1.objectOffsetScale
-- 			obj.objectOffsetRot = obj1.objectOffsetRot
--  		obj.objectOffsetRot = obj1.objectOffsetRot
--  				
--  		
--  		
--  				obj.objecttransform.pos = obj1.objecttransform.pos
--  		obj.objecttransform.rotation = obj1.objecttransform.rotation
--  		obj.objecttransform.scale = obj1.objecttransform.scale
-- 				obj.rotation = obj1.objectOffsetrot
-- 				obj.position = obj1.objectOffsetpos
-- 				obj.scale = obj1.objectOffsetscale
				
		
-- 		
--	AligntoPivot obj obj1.rotation.x obj1.rotation.y obj1.rotation.z 	
	--AlignPivot obj
)
)
-- end on
)
-- end rollout
createDialog pick_1st_weapon

