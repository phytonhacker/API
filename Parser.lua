local Parser = {}

-- A regisztrált "API-k"
local APIS = {}

function Parser.RegisterAPI(name, table)
    APIS[name] = table
end

function Parser.Run(input)
    -- Egyszerű parse-olás: "API::FunctionName(args...)"
    local apiName, funcName, args = string.match(input, "([%w_]+)::([%w_]+)%((.*)%)")
    if not apiName or not funcName then
        warn("Érvénytelen szintaxis: " .. input)
        return
    end

    local api = APIS[apiName]
    if not api then
        warn("Ismeretlen API: " .. apiName)
        return
    end

    local func = api[funcName]
    if not func then
        warn("Ismeretlen függvény: " .. funcName .. " az API-n belül: " .. apiName)
        return
    end

    -- Egyszerű argumentum feldolgozás (csak true/false szám string alapú)
    local parsedArgs = {}
    for arg in string.gmatch(args, "[^,%s]+") do
        if arg == "true" then
            table.insert(parsedArgs, true)
        elseif arg == "false" then
            table.insert(parsedArgs, false)
        elseif tonumber(arg) then
            table.insert(parsedArgs, tonumber(arg))
        elseif string.match(arg, [[".*"]]) then
            table.insert(parsedArgs, string.sub(arg, 2, -2)) -- string, levágja az idézőjeleket
        else
            warn("Ismeretlen argumentum: " .. arg)
            return
        end
    end

    return func(unpack(parsedArgs))
end

return Parser
