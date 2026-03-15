# mise-asdf

A [mise](https://mise.jdx.dev) plugin that installs a thin `asdf` CLI shim, so
scripts and CI workflows written for asdf work transparently on a mise setup.

The shim translates `asdf` commands into their `mise` equivalents at runtime —
no real asdf installation required.

## Why?

Your team standardized on asdf.  You switched to mise.  Rather than rewriting
every bootstrap script, Makefile target, and README instruction, drop this plugin
in and everything keeps working.

## Install

```bash
# From the mise registry (once published)
mise use asdf@latest

# Or install directly from GitHub
mise plugin add asdf https://github.com/nikonoid/mise-asdf
mise install asdf@latest
mise use -g asdf@latest
```

After installation, `asdf` on your `PATH` resolves to the shim:

```bash
asdf --version
# asdf shim (mise-asdf plugin) — mise 2025.x.x
```

## Command mapping

| asdf command | Translated to |
|---|---|
| `asdf install …` | `mise install …` |
| `asdf uninstall …` | `mise uninstall …` |
| `asdf current …` | `mise current …` |
| `asdf where …` | `mise where …` |
| `asdf which …` | `mise which …` |
| `asdf latest …` | `mise latest …` |
| `asdf shell …` | `mise shell …` |
| `asdf local …` | `mise use …` |
| `asdf global …` | `mise use -g …` |
| `asdf list` | `mise ls` |
| `asdf list <name>` | `mise ls <name>` |
| `asdf list all <name>` | `mise ls-remote <name>` |
| `asdf list-all …` | `mise ls-remote …` |
| `asdf plugin add …` | `mise plugins add …` (errors swallowed for core plugins) |
| `asdf plugin list …` | `mise plugins ls …` |
| `asdf plugin remove …` | `mise plugins rm …` |
| `asdf plugin update …` | `mise plugins update …` |
| `asdf update …` | `mise upgrade …` |
| `asdf exec … ` | `mise exec -- …` |
| `asdf env …` | `mise env …` |
| `asdf info` | `mise doctor` |
| `asdf reshim` | no-op (mise doesn't need reshimming) |
| anything else | forwarded to `mise` as-is |

## Development

### Prerequisites

```bash
mise install   # installs dev tools (stylua, hk, etc.)
```

### Testing locally

```bash
mise run test
```

### Linting & formatting

```bash
mise run lint
mise run format
```

### Full CI suite

```bash
mise run ci
```

## How it works

This is a standard [mise tool plugin](https://mise.jdx.dev/tool-plugin-development.html)
with Lua hooks:

- **`hooks/available.lua`** — lists versions by querying this repo's GitHub tags
- **`hooks/pre_install.lua`** — returns a `raw.githubusercontent.com` URL pointing
  to `src/asdf` at the requested tag
- **`hooks/post_install.lua`** — moves the downloaded script into `bin/asdf` and
  makes it executable
- **`hooks/env_keys.lua`** — adds `bin/` to `PATH`

The shim itself lives in `src/asdf` — a single Bash script with a `case`
statement that maps asdf subcommands to mise.

## Releasing

1. Bump the `version` in `metadata.lua`
2. Tag and push:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
3. Users can now `mise install asdf@1.0.0`

## License

MIT
