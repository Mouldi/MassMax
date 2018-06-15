
rollout uvwCreator "UVW Switch" 
(
	-- filter all objects of class Box:
Function geometry_filt obj = Superclassof obj == GeometryClass
	-- Pickbutton to select an object from the scene
	pickbutton chooseit "Overide Channel 1 " width:140 filter:geometry_filt
	pickbutton chooseit2 "Swap Channel 1 and 2 " width:140 filter:geometry_filt
	
	on chooseit  picked  obj do
	(
		if obj != undefined do
		(
			channelinfo
			print(obj.name)
			chooseit.text= obj.name
			channelinfo.copychannel obj 3 2
		channelinfo.pastechannel obj 3 1
			collapseStack obj
		)
	)
	on chooseit2  picked  obj do
	(
		if obj != undefined do
		(
			channelinfo
			print(obj.name)
			chooseit2.text = obj.name
			
			
			channelinfo.copychannel obj 3 1
			channelinfo.pastechannel obj 3 3
			channelinfo.clearchannel obj 1
			collapseStack obj
			
			channelinfo.copychannel obj 3 2
			channelinfo.pastechannel obj 3 1
			collapseStack obj
			
			channelinfo.copychannel obj 3 3
			channelinfo.pastechannel obj 3 2
			collapseStack obj
			
		)
	)
)

createDialog uvwCreator
