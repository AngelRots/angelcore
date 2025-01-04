
module( "angelcore", package.seeall ) 
local AGCore = AGCore or {}

function AGCore:IncludeLUA( file )

    if file then 
        ADDCSLuaFile( file )
        include( file )
        print("[AGCore] - One or several files were included through the wrapper!")
    else 
        print( "[AGCore] - Core include is nil or invalid!" )

    end
end