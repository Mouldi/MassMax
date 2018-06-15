select  objects
-- select ($*Object* as array) 
	for obj in selection do
	(
	 objname = obj.name as String
	subname = substring objname 1 (objname.count - 3)
		obj.name = subname
		print subname
		print obj.name
	)
