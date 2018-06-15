objx = object
childrenchildren = #()



fn clearDeadNodes array = 
(
	if array.count != 0 do (for i = array.count to 1 by -1 where not isValidNode array[i] do deleteItem array i)
	array
)
fn CleanHidden childrenchildren =
(
	for obj in childrenchildren do
	(
	if (obj.isHidden  == true)  then
	
		delete (obj)
		
	)
	clearDeadNodes childrenchildren
-- 	for i=1 to childrenchildren.count do
-- 	(
-- 	if childrenchildren[i].isNodeHidden ==true  do
-- 	
-- 	deleteItem childrenchildren i
-- 	
-- )
)
	

fn selectAllChildren  obj1 =
(
deselect selection

if obj1.children != undefined do
(
	
selectmore obj1.children
)
childrenchildren = selection as array

)

rollout GenerateDummies "Generate Dummies" 
(
-- filter all objects of class Box:
Function weapon_filt obj = Superclassof obj == GeometryClass
-- Pickbutton to select a Box from the scene
pickbutton chooseit "Delete hidden children" width:140 filter:weapon_filt
-- pickbutton choosesecond "Select Second Weapon" width:140 filter:weapon_filt
pickbutton generate "Generate Slots" width:140 filter:weapon_filt
-- pickbutton choosesecond "Select Second Weapon" width:140 filter:weapon_filt

	
-- If the user picked an object, then
on chooseit picked obj do
(
	
-- see if the user did not cancel the picking...
if obj != undefined do
(

-- if he did not, make the box's wireframe red:

-- and display the name of the object on the button:
chooseit.text = obj.name
	objx = obj

	
-- SwapUVW obj1
-- 	ChannelInfo.copychannel obj1 
	
selectAllChildren  objx	
CleanHidden childrenchildren

-- lastlist = #()
		
	for obji in childrenchildren do
	(
		myboxc = Box length:5 width:5 height:5
-- 		append lastlist obji
		obji.parent = undefined	
		in coordsys #world
		(
		
		myboxc.transform = obji.transform
		

			
		
		
			
			)
			myboxc.parent = objx
			myboxc.name = obji.name
			print (myboxc.name + myboxc.pos as string)
			
		
	)
-- 	for obji in childrenchildren do
-- 	(
-- 	
-- 	myboxc.rotation = obji.rotation

-- 	)
free childrenchildren
	

	
)
)
on generate picked obj do
(
	if obj != undefined do
(
	in coordsys #world
	(
	for i=1 to 4 do
		(
			mybox = Box length:5 width:5 height:5
		mybox.name = i as string
		
		
			mybox.pos = obj.pos + ([(7*i), (-7) ,3] )
			mybox.parent = obj
			ResetScale mybox
			ResetTransform mybox
		)
		
	)
	)
)
-- end on
)
-- end rollout
createDialog GenerateDummies