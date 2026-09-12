--[[
  9wrwares Config Sync (standalone)
  ---------------------------------
  Works with ANY engine that reads getgenv()['9wrwares'] (including pastebin uv1Z83cm).

  Load order:
    1) your config table  (getgenv()['9wrwares'] = { ... })
    2) THIS file          (starts polling)
    3) engine             loadstring(game:HttpGet("https://pastebin.com/raw/uv1Z83cm"))()

  Website Apply Live writes JSON → this merges into the SAME table the engine already uses.
]]

local HttpService = game:GetService("HttpService")

local DEFAULT_URL = "https://igotmultipleyter.github.io/9wwwwraree/config.json"
local FALLBACKS = {
    "https://igotmultipleyter.github.io/9wwwwraree/config.json",
    "https://igotmultipleyter.github.io/9wwwwraree/9wrwares_config.json",
}

local function deepMerge(dst, src)
    if type(dst) ~= "table" or type(src) ~= "table" then
        return src
    end
    for k, v in pairs(src) do
        if k ~= "_meta" then
            if type(v) == "table" and type(dst[k]) == "table" then
                deepMerge(dst[k], v)
            else
                dst[k] = v
            end
        end
    end
    return dst
end

local function HttpGetBody(url)
    if type(url) ~= "string" or url == "" then
        return nil
    end
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and type(res) == "string" and #res > 1 then
        return res
    end
    local req = (syn and syn.request) or http_request or (fluxus and fluxus.request) or request
    if type(req) == "function" then
        local ok2, res2 = pcall(function()
            return req({ Url = url, Method = "GET" })
        end)
        if ok2 and type(res2) == "table" then
            local body = res2.Body or res2.body
            if type(body) == "string" and #body > 1 then
                return body
            end
        end
    end
    return nil
end

local function DecodeJson(body)
    if type(body) ~= "string" then
        return nil
    end
    body = body:gsub("^\239\187\191", "")
    local ok, decoded = pcall(function()
        return HttpService:JSONDecode(body)
    end)
    if not ok or type(decoded) ~= "table" then
        return nil
    end
    -- JSONBin v3 wraps in .record
    if type(decoded.record) == "table" then
        return decoded.record
    end
    return decoded
end

local function GetSyncSettings()
    local root = getgenv()["9wrwares"]
    if type(root) ~= "table" then
        return nil
    end
    local cs = root["Settings"] and root["Settings"]["Config Sync"]
    if type(cs) ~= "table" then
        return {
            Enabled = true,
            URL = DEFAULT_URL,
            Interval = 3,
            ["Notify On Apply"] = true,
        }
    end
    return cs
end

local function ResolveUrl(cs)
    local url = cs and cs["URL"]
    if type(url) == "string" and url ~= "" then
        if url:sub(-1) == "/" then
            return url .. "config.json"
        end
        return url
    end
    return DEFAULT_URL
end

local LastVersion = nil
if getgenv()._9wrConfigSyncRunning then
    -- already started
else
    getgenv()._9wrConfigSyncRunning = true

    task.spawn(function()
        task.wait(1)
        while true do
            local interval = 3
            local cs = GetSyncSettings()
            if type(cs) == "table" and tonumber(cs["Interval"]) then
                interval = math.clamp(tonumber(cs["Interval"]), 1, 60)
            end
            local enabled = not (type(cs) == "table" and cs["Enabled"] == false)

            if enabled then
                local primary = ResolveUrl(cs)
                local urls = { primary }
                for _, u in ipairs(FALLBACKS) do
                    if u ~= primary then
                        table.insert(urls, u)
                    end
                end
                -- if URL looks like jsonbin, don't use github fallbacks only
                for _, url in ipairs(urls) do
                    local body = HttpGetBody(url)
                    local decoded = DecodeJson(body)
                    if decoded then
                        local ver = decoded._meta and decoded._meta.version
                        if ver == nil or ver ~= LastVersion then
                            LastVersion = ver
                            local root = getgenv()["9wrwares"]
                            if type(root) ~= "table" then
                                root = {}
                                getgenv()["9wrwares"] = root
                            end
                            -- merge IN PLACE so pastebin engine's local CFG still sees changes
                            deepMerge(root, decoded)
                            if not (type(cs) == "table" and cs["Notify On Apply"] == false) then
                                pcall(function()
                                    if type(Notify) == "function" then
                                        Notify("Config synced")
                                    else
                                        print("[9wrwares] Config synced from " .. tostring(url))
                                    end
                                end)
                            end
                        end
                        break
                    end
                end
            end
            task.wait(interval)
        end
    end)

    print("[9wrwares] config sync running")
end
