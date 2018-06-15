listofmaterials = #()
materialids = #()
bitmapimagefilename = #()
names = #()
colormtl = Multimaterial()
mtl  = multiMaterial()
model
colors = #()
clr
newcolor 
fn GenerateUniqueColor =
(
	i = 1
	do
	(
		clr = color (random 0 255) (random 0 255) (random 0 255)
		
		
	
		
			for j=1 to listofmaterials.count do
	(
		if colors[i] != clr do
		(
		colors = append colors	clr	
		) 
	)
	i=i+1
	)
	while colors.count <  listofmaterials.count
	
	
)
fn CreateNewMat  =
(
	colormtl.name = mtl.name + 2 as String
	colormtl.materialIDList = mtl.materialIDList
	GenerateUniqueColor()
	i =1
	for item  in  colormtl.materiallist do
	(
		
		item.diffuse = colors[i] as color
		i = i+1
	)
	meditMaterials[2] =  colormtl
)

fn getobjectfromselection obj1=
(
deselect selection
if obj1 != undefined do
(
select obj1
	model = obj1
)

)

rollout mtlgen "Material Generator" width:340 height:400
(
	-- filter all objects of class Box:
Function geometry_filt obj = Superclassof obj == GeometryClass
	-- Pickbutton to select an object from the scene
	pickbutton chooseit "Get Model " width:140 filter:geometry_filt
	
	button Createmtl "Create Code Material" width:140 
	--The list box displays what you currently have selected by the ArrayPick button.
  listbox LB01 "List of Materials" width: 150 align:#left
      height:10;      --5 lines tall.
         ReadOnly:false; --Read Only List.
listbox LB02 "List of material ids"   offset: [170,-158] width: 150 height:10 align:#left
	
      height:10;      --10 lines tall.
         ReadOnly:false; --Read Only List/on/off.	
button mtlbtn "Use Coded Material" offset: [0,10] width: 150 height:100 align:#left	
	button mtlbtn2 "Use Original Material"  offset: [170,-105] width: 150 height:100 align:#left	
	on Createmtl pressed  do
	(
		
		CreateNewMat  ()
	)
	on mtlbtn pressed  do
  (
    model.material = colormtl
   
  )
  	on mtlbtn2 pressed  do
  (
    model.material = mtl
   
  )
	on chooseit  picked  obj do
	(
		if obj != undefined do
		(
			print(obj.name)
			model = obj
		--listofmaterials = obj.material
			mtl = obj.material
			meditMaterials[1] =  mtl
			listofmaterials = mtl.materiallist
			Material_ID
		print(listofmaterials)
		for item in listofmaterials do
			(
				names = append names item.name
				bitmapimagefilename = append bitmapimagefilename item.diffuseMap.filename 
			)
		LB01.items = names
		)
		
		for i =1 to listofmaterials.count do

	(
		materialids = append materialids (mtl.materialIDList[i] as string) 
print(mtl.materialIDList[i])
		
		
		--materialID
		
		)
		lb02.items = materialids
	)
)

createDialog mtlgen
