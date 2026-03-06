--- Returns the download URL for a specific version of the asdf shim.
--- The shim script lives in src/asdf inside the plugin repo; we fetch
--- the raw file for the requested git tag.
--- @param ctx {version: string, runtimeVersion: string}
--- @return table
function PLUGIN:PreInstall(ctx) -- luacheck: ignore
    local version = ctx.version
    local url = "https://raw.githubusercontent.com/nikonoid/mise-asdf/v" .. version .. "/src/asdf"

    return {
        version = version,
        url = url,
    }
end
