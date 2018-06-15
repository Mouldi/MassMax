
nativeobjchildren = #()
newobjchildren = #() 
optimisedobjs = #()
names = #()


fn selectAllChildren obj1=
(
deselect selection
if obj1.children != undefined do
(
selectmore obj1.children
)

)

 
rollout Fuckit "Fuck it let's do it manualy"
(
-- filter all objects of class Box:
Function weapon_filt obj = Superclassof obj == GeometryClass
	Function selection_filt optimisedobjs = Superclassof optimisedobjs == GeometryClass
-- Pickbutton to select a Box from the scene
	button optimizedlist "Select List of Attachements" width:140 filter:selection_filt
pickbutton chooseit "Get Weapon children" width:140 filter:weapon_filt
pickbutton choosesecond "Attach children's children" width:140 filter:weapon_filt
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
 

selectAllChildren(obj1)
	
	
	nativeobjchildren = selection as Array
	for i =1 to nativeobjchildren.count do

	(
-- 		ResetScale nativeobjchildren[i]
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
-- obj.wirecolor = red
-- and display the name of the object on the button:
	

	choosesecond.text = obj.name
	
for i =1 to nativeobjchildren.count do

	(
print(nativeobjchildren[i].name)
		for j = 1 to optimisedobjs.count do
		(
		if (nativeobjchildren[i].name == optimisedobjs[j].name) do
			(
	    
		in coordsys #world
		(
		optimisedobjs[j].pos = nativeobjchildren[i].pos 
-- 		mybox.objectoffsetrot = nativeobjchildren[i].objectoffsetrot
		)
		optimisedobjs[j].parent = obj
		hide nativeobjchildren[i]
		)
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
createDialog Fuckit
