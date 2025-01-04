
module( "angelcore", package.seeall ) 
local AGCore = AGCore or {}

-- Wrapper for LUA includes 
-- @param file: Path to the LUA file that needs to be included
function AGCore:IncludeLUA( file )

    if file then 
        ADDCSLuaFile( file )
        include( file )
        print("[AGCore] - One or several files were included through the wrapper!")
    else 
        print( "[AGCore] - Core include is nil or invalid!" )

    end
end

-- Wrapper for including LUA files from tables
-- @param files: Table containing the paths of the LUA files
function AGCore:IncludeTable( files )

 for _, file in pairs(files) do 
    self:IncludeLUA(file)
    end

end