module( "angelcore", package.seeall ) 
local AGCore = AGCore or {}

AGCore.Version = "1.0.0"
AGCore.Prefix = "[AGCore] - "

AGCore.LOG = {
    INFO = "INFO",
    WARNING = "WARNING",
    ERROR = "ERROR"
}

-- Wrapper for LUA includes 
-- @param file: Path to the LUA file that needs to be included
function AGCore:IncludeLUA( file )

    if file then 
        AddCSLuaFile( file )
        include( file )
        print(AGCore.Prefix .. "One or several files were included through the wrapper!")
    else 
        print( AGCore.Prefix .. "Core include is nil or invalid!" )

    end
end

-- Wrapper for including LUA files from tables
-- @param files: Table containing the paths of the LUA files
function AGCore:IncludeTable( files )

 for _, file in pairs(files) do 
    self:IncludeLUA(file)
    end

end

-- Logging function  
-- @param logEvent: The string to print to the console
-- @param logType: The type of log to print ex. INFO, WARNING, ERROR
-- @see AGCore.LOG
function AGCore:Log(logEvent,logType)

    local logType = logType or "INFO"

    if not AGCore.LOG[logType] then 
        logType = "INFO"
    end


    local logMsg = string.format("[%s] - %s", logType, logEvent)

    print(logMsg)

end