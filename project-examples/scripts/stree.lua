-- (Incomplete) Tagged PDF Structure Tree printer
-- David CarlisleDecember 2024

if (#arg ~= 1 ) then
  print ("No pdf supplied")
  os.exit()
end

doc = pdfe.open(arg[1])

if (doc==nil) then
  print("failed to open " .. arg[1] .. " as PDF")
  os.exit()
end

function stree (K, indent, ns)
if(K) then
if (type(K) == "string") then
  print (indent .. "[" .. K .. "]")
else
if (type(K) == "number") then
  print (indent .. "[[" .. K .. "]]")
else
  local Ktable=pdfe.dictionarytotable(K)
  local ns=0
  if(Ktable.NS) then
   ns=Ktable.NS[3] -- should look this up in Namespace table
  end
  if(Ktable.S) then
  print (indent .. "<" .. Ktable.S[2] .. " xmlns=\"" .. ns .. "\">")
  if(Ktable.K) then
    local i = 1
    while(Ktable.K[i]) do
      stree(K.K[i],indent .. " ",ns)
      i=i+1
    end
  end
  print (indent .. "</" .. Ktable.S[2] .. ">")
  else
--  print ("no S")
  end
end
end
else
-- print("no K")
end
end

cat = pdfe.getcatalog(doc)
stree(cat.StructTreeRoot.K,"","")


