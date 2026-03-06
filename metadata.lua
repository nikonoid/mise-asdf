-- metadata.lua
-- Plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#metadata-lua

PLUGIN = { -- luacheck: ignore
    name = "asdf",
    version = "0.0.1",
    description = "An asdf CLI shim that translates commands to mise",
    author = "nikonoid",
    updateUrl = "https://github.com/nikonoid/mise-asdf",
    minRuntimeVersion = "0.2.0",
    legacyFilenames = {
        ".tool-versions",
    },
}
