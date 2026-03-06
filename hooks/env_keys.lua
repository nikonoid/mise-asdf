--- Puts the shim's bin/ directory on PATH so `asdf` resolves to the shim.
--- @param ctx {path: string, runtimeVersion: string, sdkInfo: table}
--- @return table[]
function PLUGIN:EnvKeys(ctx) -- luacheck: ignore
    local mainPath = ctx.path

    return {
        {
            key = "PATH",
            value = mainPath .. "/bin",
        },
    }
end
