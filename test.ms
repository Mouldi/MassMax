Environment = dotNetClass "System.Environment"
MyPath = Environment.GetEnvironmentVariable "MouldiScripts" 
MyFile = MyPath +"\material.py" as string

mybox = box()

showProperties(mybox)
myarray = #(


