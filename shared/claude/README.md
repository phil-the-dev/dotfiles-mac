# Claude Config

These files are symlinked into `~/.claude/` by `install.sh`.

## CLAUDE.md
Global coding standards applied to every Claude Code session.

## settings.json
Claude Code settings including MCP server definitions. Add servers under `mcpServers`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

Use environment variable references (`${VAR_NAME}`) for secrets — never hardcode tokens in this file.
