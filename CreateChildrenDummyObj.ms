
nativeobjchildren = #()
newobjchildren = #() 
optimisedobjs = #()
names = #()


fn selectAllChildren =
(
	free nativeobjchildren
deselect selection
if obj1.children != undefined do
(
selectmore obj1.children
)
nativeobjchildren = selection as Array
)

 
rollout GenerateChildPos "Generate Children Dummies"
(
-- filter all objects of class Box:
Function weapon_filt obj = Superclassof obj == GeometryClass
	Function selection_filt optimisedobjs = Superclassof optimisedobjs == GeometryClass
-- Pickbutton to select a Box from the scene
	button optimizedlist "Select List of Attachements" width:140 filter:selection_filt
pickbutton chooseit "Select First Weapon" width:140 filter:weapon_filt
pickbutton choosesecond "Select Second Weapon" width:140 filter:weapon_filt
 --The list box displays what you currently have selected by the ArrayPick button.
  listbox LB01 "List of Optimised Attachs" 
      height:5;      --5 lines tall.
         ReadOnly:True; --Read Only List.
	
	on optimizedlist pressed  do
	(
		
		optimisedobjs = selection as array
		print(optimisedobjs)
		for item in optimisedobjs do
			(
				names = append names item.name
			)
		LB01.items = names
	)
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
ResetScale obj
	obj1 = obj	
 

selectAllChildren()
	
	
	
	for i =1 to nativeobjchildren.count do

	(
		ResetScale nativeobjchildren[i]
print(nativeobjchildren[i].name)
		)		
	
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
	
for i =1 to nativeobjchildren.count do

	(
print(nativeobjchildren[i].name)
		mybox = Box length:5 width:5 height:5
	    mybox.parent = obj
		mybox.name = nativeobjchildren[i].name
		in coordsys #Parent
		(
		mybox.transform = nativeobjchildren[i].transform 
		
		)
		)	

-- 	for i =1 to nativeobjchildren.count do
-- 	(
-- 		

-- 		deleteItem nativeobjchildren[i]
-- 	
-- 		
-- 	)
-- 	for i =1 to newobjchildren.count do
-- 	(
-- 		
-- 	
-- 			deleteItem newobjchildren[i]
-- 			
-- 	
-- )
free nativeobjchildren

free newobjchildren	
-- end on
)))
-- end rollout
createDialog GenerateChildPos
