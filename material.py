import MaxPlus
import sys
import os



for n in MaxPlus.SelectionManager.Nodes:
    count = n.Material.GetNumSubMtls()
    print count
    for i in range(0,count):
        print i.materialList 
        print type(n.Material)
        #sub = n.Material.GetSubMtl(i)
        

