obj1





fn ChannelDiagCheck =
(
hwnd = DialogMonitorOPS.GetWindowHandle()
diagtitle = 	uiAccessor.getWindowText hwnd

if ( (UIAccessor.GetWindowText hwnd) == "Unwrap UVW" ) then
(
UIAccessor.PressButtonByName hwnd "&Yes"
	print "fuck yeahhhhhhhhh"
	true
)
else if ((UIAccessor.GetWindowText hwnd) != "Unwrap UVW" ) then
(
print "fuck noooooooooooo"
false
)
)

fn SwapUVW obj =
(
	
DialogMonitorOPS.RegisterNotification ChannelDiagCheck id:#ChannelChange
	
	dialogMonitorOps.interactive = false
			dialogMonitorOps.enabled = true

		
		-- add uvw modifier
		addmodifier obj (unwrap_UVW()) ui:on			
			obj.modifiers[#unwrap_uvw].unwrap.setMapChannel 2
	
-- 			DialogMonitorOPS.unRegisterNotification id:#ChannelChange
		
			obj.modifiers[#unwrap_uvw].unwrap.reset()	
	
				
-- 			forcecompleteredraw dodisabled:true  
		ChannelDiagCheck()
			dialogMonitorOps.interactive = true
	dialogMonitorOps.enabled = false
	DialogMonitorOPS.unRegisterNotification id:#ChannelChange
			obj.modifiers[#unwrap_uvw].unwrap.setMapChannel 1
			collapseStack(obj)
		)
-- 		
-- 		-- reset uvws
-- 		checkDialogAbandon()	
-- 		obj.modifiers[#unwrap_uvw].unwrap.reset()
		
-- 		-- set uvw channel to 1

		


-- 	(ClassOf obj.modifiers[1])  ui:on	
-- 	forcecompleteredraw dodisabled:true
	
-- 	checkDialogMove()
-- 	dialogMonitorOps.unregisterNotification id:#resetuvmove
-- 	
-- 	dialogMonitorOps.unregisterNotification id:#resetuvabandon
	
		
	
	


rollout SwapUV "UVW Transfer" 
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
obj1 = obj	
	
SwapUVW obj1
-- 	DialogMonitorOPS.unRegisterNotification id:#ChannelChange
	
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

-- end on
)
-- end rollout
createDialog SwapUV