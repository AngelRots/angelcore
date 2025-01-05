module( "angelcore", package.seeall ) 
AGCore = AGCore or {}

AGCore.Version = "1.0.0"
AGCore.Prefix = "[AGCore] - "

AGCore.LOG = { 
    "INFO", 
    "WARNING", 
    "ERROR", 
    "UNDEFINED" 
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
        self.Print("The following file has been included: " .. file)
    else 
        self.Print("Core include is nil or invalid!" )

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
			self:IncludeLUA( v, directory )
		end
	end

	for _, v in ipairs( directories ) do
		print( "[AUTOLOAD] Directory: " .. v )
		self:IncludeDir( directory .. v )
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
-- @param logType The keyvalue of log to print as a string ( 1 INFO, 2 WARNING, 3 ERROR )
-- @see AGCore.LOG
function AGCore:Log(logEvent,logType)

    logType = self.LOG[logType]

    if not table.HasValue(self.LOG, logType) then
        logType = self.LOG[4]
    end

    if logType == self.LOG[3] then
        error(logEvent,1)
    end

    if logType == self.LOG[2] then 
        ErrorNoHalt(logEvent)
    end

    local logMsg = string.format("[%s] %s", logType, logEvent)

    self.Print(logMsg)

end

function AGCore.AnimSys( result, offset )  
    
    local offset = offset or 0
    local animCur = math.sin(CurTime() * offset ) * result

    return animCur

end




AGCore:Log("AGCore has been initialized!",1)

AGCore:IncludeLUA("angelcore/core/angel_view.lua")

