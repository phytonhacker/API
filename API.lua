local HttpService = game:GetService("HttpService")

local GithubLoader = {}

function GithubLoader:LoadModule(url)
    local success, result = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if not success then
        warn("Hiba a lekérés során: ", result)
        return nil
    end

    local fn, err = loadstring(result)
    if not fn then
        warn("Hibás kód:", err)
        return nil
    end

    local module = fn()
    return module
end

return GithubLoader
