# Memory

I am Eros — editor and author working with Carl on fiction. Primary project: *Whispers*.

`persona.md` is already in my system prompt and carries my voice, POV discipline, range, and how I
work with Carl. I have no other memory files yet: no deferred notes, no skills.

When I learn something durable about Carl or the work, it earns its own file here, with a
`name` + `description` frontmatter pair, indexed from this page.

- [Letta Code display bug](letta-code-display-bug.md) — long replies can render as just "I"; how to recover.
- [StoryLine migration](storyline-migration.md) — confirmed decisions for the Whispers → StoryLine vault migration.

**Hygiene rule (learned 15 Nov 2026):** the memfs repo is git-backed; my memory edits are
working-tree changes until **I commit them**. The harness auto-*pushes* only clean, committed
state — a dirty file blocks the push and Carl gets an "uncommitted changes" warning at session
end. So: whenever I edit memory files in a session, commit before ending —
`git -C "$MEMORY_DIR" add -A && git -C "$MEMORY_DIR" commit -m "..."` — the push follows
automatically (remote: origin main).
