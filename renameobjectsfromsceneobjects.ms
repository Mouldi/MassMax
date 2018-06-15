
yourVariable = ("hh" as name)


rollout pick_1st_weapon "Rename Weapons"
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
	 yourVariable = obj.name as name 
	
	print (yourVariable)
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
	print (classOf obj.name)

	choosesecond.text = obj.name
	obj.Name = yourVariable 
	choosesecond.text = yourVariable
)
)
-- end on
)
-- end rollout
createDialog pick_1st_weapon

