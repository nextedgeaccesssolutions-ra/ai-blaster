# AI client compatibility

The canonical shared skills live in `.agents/skills/`. Current agent tools that support this layout include Claude Code, Codex/OpenAI agent workflows, Qwen Code, and Manus. The project also includes `CLAUDE.md`, `AGENTS.md`, `QWEN.md`, and `MANUS.md` for host-specific context.

Qwen Code supports project skills from `.agents/skills/` and `.qwen/skills/`; its documented shared-skills guidance recommends `.agents/skills/` for Claude Code, Codex, and Qwen Code. Manus supports the same Agent Skills open standard and can import skills from GitHub or a project skill library. OpenAI/Codex can additionally use `.codex/skills/`.
