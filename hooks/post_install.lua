--- Moves the downloaded shim into bin/asdf and makes it executable.
--- @param ctx {rootPath: string, runtimeVersion: string, sdkInfo: table}
function PLUGIN:PostInstall(ctx) -- luacheck: ignore
    local sdkInfo = ctx.sdkInfo[PLUGIN.name]
    local path = sdkInfo.path

    os.execute("mkdir -p " .. path .. "/bin")

    local src = path .. "/asdf"
    local dest = path .. "/bin/asdf"

    local ok = os.execute("mv " .. src .. " " .. dest .. " && chmod +x " .. dest)
    if ok ~= 0 then
        error("Failed to install asdf shim")
    end
end
