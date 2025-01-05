module( "angelcore", package.seeall ) 
AGCore = AGCore or {}

AGCore.Version = "1.0.0"
AGCore.Prefix = "[AGCore] - "

AGCore.LOG = {
    INFO = "INFO",
    WARNING = "WARNING",
    ERROR = "ERROR"
}

-- Prints a message to the console with the AGCore prefix.
-- @param msg The message to print to the console
function AGCore.Print( msg )

    print( AGCore.Prefix .. msg )

end

-- Wrapper for LUA includes. 
-- @param file Path to the LUA file that needs to be included
function AGCore:IncludeLUA( file )

    if file then 
        AddCSLuaFile( file )
        include( file )
        AGCore.Print("The following file has been included: " .. file)
    else 
        AGCore.Print("Core include is nil or invalid!" )

    end
end

-- Function for including LUA files from directories.
-- @param directory Directory path containing the LUA files
-- @see wiki.facepunch.com/gmod/Global.include
function AGCore:IncludeDir( directory )
	directory = directory .. "/"

	local files, directories = file.Find( directory .. "*", "LUA" )

	for _, v in ipairs( files ) do
		if string.EndsWith( v, ".lua" ) then
			AGCore:IncludeLUA( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
		print( "[AUTOLOAD] Directory: " .. v )
		AGCore:IncludeDir( directory .. v )
	end
end

-- Wrapper for including LUA files from tables.
-- @param files Table containing the paths of the LUA files
function AGCore:IncludeTable( files )

 for _, file in pairs(files) do 
    self:IncludeLUA(file)
    end

end

-- Logging function.  
-- @param logEvent The string to print to the console
-- @param logType The type of log to print ex. INFO, WARNING, ERROR
-- @see AGCore.LOG
function AGCore:Log(logEvent,logType)

    local logType = logType or "INFO"

    if not AGCore.LOG[logType] then 
        logType = "INFO"
    end


    local logMsg = string.format("[%s] - %s", logType, logEvent)

    print(logMsg)

end

function AGCore.AnimSys( result, offset )  
    
    local offset = offset or 0
    local animCur = math.sin(CurTime() * offset ) * result
    return animCur
end





AGCore.Print("AngelCore loaded!")

AGCore:IncludeLUA("angelcore/core/angel_view.lua")

