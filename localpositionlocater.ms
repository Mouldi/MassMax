
 
 
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

fn PlaceObject obj obj1 =
(
	addModifier obj (meshSelect())
	
	collapseStack obj
	addModifier obj1 (meshSelect())
	collapseStack obj1
	
	clone = snapshotAsMesh obj
	for i = 1 to meshop.getNumVerts obj by 1 do
	(
		
if (meshop.getNumVerts obj1 >= i) then
		(
		
		meshOp.setVert obj i ( getVert obj1 i)
			print(i)
	
		)
		
		
	)
-- 	obj = clone

	
)
fn CloneObjectData obj obj1 =
(
-- 	obj.transform = obj1.transform
	obj.objectoffsetpos = obj1.objectoffsetpos
	obj.objectoffsetrot = obj1.objectoffsetrot
	obj.objectoffsetscale = obj1.objectoffsetscale
	
-- 	obj.pos = obj1.pos
-- 	obj.rotation = obj1.rotation 
-- 	obj.scale =  obj1.scale
-- 	
	
)
fn PrepareObject obj obj1 =
(
		in coordsys #world
		--	offsetrot = inverse (obj1.rotation * inverse (matrix3 1))
--obj.objectOffsetRot = obj1.rotation -- rotate the object away from its pivot
--rotate obj offsetrot -- puts back the object in the original orientation, leaving the pivot oriented like the target object
--
		
		maxOps.pivotMode  = #pivotonly
		ResetPivot obj
		
		
		
-- 		Reset_XForm obj
		maxOps.pivotMode  = #none
-- 		RotatePivotOnly obj obj1.rotation
-- 		PlaceObj obj obj1 
		
		maxOps.pivotMode  = #objectonly
-- 		obj.pivot = obj1.pivot 
-- 		ResetPivot obj
	CenterPivot obj
-- 		 move obj obj1.pos 		
-- 		Rotate obj obj1.rotation
		
		
 maxOps.pivotMode  = #none
 ResetScale obj
		ResetTransform obj
 ResetXForm obj
 collapseStack(obj)
 
 obj.transform = obj1.transform
--  obj.pos = obj1.pos
--  obj.rotation = obj1.rotation
-- 		xform_pivot_only obj  obj1.transform
)
fn AlignPivotTo Obj Trgt =
(
-- Get matrix from object
if classOf Trgt != matrix3 then Trgt = Trgt.transform
	
-- Store child transforms
local ChldTms = in coordSys Trgt ( for Chld in Obj.children collect Chld.transform )

-- Current offset transform matrix
local TmScale = scaleMatrix Obj.objectOffsetScale
local TmRot = Obj.objectOffsetRot as matrix3
local TmPos = transMatrix Obj.objectOffsetPos
local TmOffset = TmScale * TmRot * TmPos

-- New offset transform matrix
TmOffset *= obj.transform * inverse Trgt

-- Apply matrix
Obj.transform = Trgt

-- Restore offsets
Obj.objectOffsetPos = TmOffset.translation
Obj.objectOffsetRot = TmOffset.rotation
Obj.objectOffsetScale = TmOffset.scale

-- Restore child transforms
for i = 1 to Obj.children.count do
(
	Obj.children[i].transform = ChldTms[i] * inverse Trgt * Obj.transform
	)


)


fn xform_pivot_only obj newX = ((
-- Sets the transformation of the pivot of an object without moving the geometry 
-- v0.1 - (c) Martin Breidt - 30.05.08
--
-- obj: object whose pivot should be transformed
-- newX: matrix3 value with new transform for pivot
--
-- !! currently works only correctly for non-scaled objects !!
--
with redraw off (
	ResetPivot obj
	CenterPivot obj
-- store old transform
local oldX = obj.transform
-- transform entire object such that pivot matches target transform matrix
-- this will also move the geometry
obj.transform = newX

-- compute "difference" transformation between old and new
local delta = oldX * (inverse newX)
-- counter-rotate to remove rotation from geometry
obj.objectOffsetRot = delta as quat

-- compute translation vector in world space
local dvec_world = oldX.row4 - newX.row4

-- transform translation vector from "world" to "new" coordinate system
local new_op = (newX * (transMatrix dvec_world) * (inverse newX)).row4
-- counter-translate to remove translation from geometry
obj.objectOffsetPos = new_op
)
)

--- now create some test objects
-- clear scene
delete $*

-- create some initial geometry and transform it somehow as a starting point
t = teapot pos:[150,-70,30] wirecolor:red
rotate t (eulerangles 45 31 70)

-- create copy so we can check later in the viewport whether the geometry has moved
t2 = copy t
t2.wirecolor = blue

-- define a target transform matrix for pivot:
-- the pivot's x axis should be [0,0,-1] (negative z axis),
-- the pivot's y axis should be [1,0,0] (positive x axis),
-- the pivot's z axis should be [0,-1,0] (negative y axis),
-- and the pivot should be at position [110,0,50]
new = (matrix3 [0,0,-1] [1,0,0] [0,-1,0] [110,0,50])

-- transform only the pivot of "t" so it matches "new"
-- xform_pivot_only t new

select t
)

fn PlaceObj obj1 obj2 =
(
	
	obj1.pos = obj2.pos
	obj1.rotation = obj2.rotation
	obj1.scale = obj2.scale
	)
-- define function for rotating only the pivot point
fn RotatePivotOnly obj obj2 = (
toolMode.coordsys #world

objnode = obj.pos * obj.rotation * obj.scale

objoffset= (obj.objectoffsetpos * obj.objectoffsetrot * obj.objectoffsetscale) 
objtrans = objoffset * objnode

-- obj2offset= (obj2.objectoffsetpos * obj2.objectoffsetrot * obj2.objectoffsetscale) 
-- obj2trans = obj2.transform

print(obj.transform)
print(obj.objectoffsetpos)
print(obj.objectoffsetrot)
print(obj.objectoffsetscale)

print(obj.pos)
print(obj.rotation)
print(obj.scale)




print("my own calculated values")
print("obj node %" + objnode as string)
print("obj offset %" + objoffset as string)
print("obj objtrans %"+ objtrans as string)



maxOps.pivotMode  = #pivotOnly
	move obj [0,0,0]

-- maxOps.pivotMode  = #none	

-- maxOps.pivotMode  = #none	
-- obj.rotation = obj1.transform.rotation
-- obj.scale = obj1.transform.scale

-- obj.objectoffsetpos = obj1.objectoffsetpos / obj1.transform.pos 
-- obj.objectoffsetrot = obj1.objectoffsetrot / obj1.transform.rotation 
-- obj.objectoffsetscale = obj1.objectoffsetscale / obj1.transform.scale 

-- in coordsys #world
-- 	maxOps.pivotMode  = #pivotOnly
-- 		

-- 	obj.pivot = obj1.pivot





-- maxOps.pivotMode  = #pivotOnly		
--  obj.pivot = obj1.pivot 
-- animate off in coordsys local obj.rotation*=RotValInv
-- obj.objectoffsetpos*=RotValInv
-- obj.objectoffsetrot*=RotValInv

-- maxOps.pivotMode  = #none	
)
function TransformPivot obj vec dir =
	(
		vec = obj.transform[1]
		tm = obj.transform
		vec = normalize vec
		dir = normalize dir
		rtm = angleaxis (acos (dot vec dir)) (normalize (cross dir vec))
		tempObjTM = translate (rotate (scalematrix tm.scale) (tm.rotation*rtm)) tm.pos
		--
		worldAlignPivot obj
		rotation =  Inverse tempObjTM.rotation
		in coordsys local obj.rotation *= rotation
		obj.objectoffsetrot *= rotation
		obj.objectoffsetpos *= rotation	
		
	)		

fn AligntoPivot obj x y z absolute:true =
(
-- store the object's position for later
p = obj.pos
r = obj.rotation

if absolute do
(
-- store the object's rotation as an offset from the
-- identity matrix (aka zero world transform)
offsetrot = inverse (obj.rotation * inverse (matrix3 1))

-- use the stored offset to zero the pivot rotation
-- in world coords. after this step, the supplied x y z 
-- will be an absolute offset from world coords:)
obj.rotation *= offsetrot
obj.objectoffsetrot *= offsetrot
)

-- get the supplied x y z degrees as a quaternion offset.
-- the inversion changes the rotation from a right-handed 
-- coordinate system to the expected left-handed system.
-- Rotation in Maxscript sure is tricky!
rot = inverse ((eulerangles x y z) as quat)
pos = inverse (x y z) as point3

-- finally, apply the final offset to the object's pivot.
-- Basically, we're transforming the whole object, and then
-- using .objectoffsetrot to backtransform just the object's 
-- geometry. Pretty neat, huh?
obj.rotation *= rot

obj.objectoffsetrot *= rot


-- set the object to it's original position
obj.pos = p
obj.rotation = r

return ok
)













rollout pick_1st_weapon "Change Pivot Point"
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
 AlignPivotTo obj obj1	
AlignObjectAB obj obj1

	
	originoffsetobj1 = obj1.pivot
	
	obj1.pivot = obj1.center
	centredoffsetobj1 = obj1.pivot
	
	trueoffsetobj1 = originoffsetobj1 - centredoffsetobj1 
	
	obj.pivot = obj.center
	
	obj.pivot += trueoffsetobj1
	
	obj1.pivot = originoffsetobj1
	
	ResetScale obj
	
	
	print(trueoffsetobj1)

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

