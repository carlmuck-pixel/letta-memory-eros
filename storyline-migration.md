---
name: storyline-migration
description: Confirmed decisions for the Whispers → StoryLine (Obsidian plugin) migration, Nov 2026.
---

# Whispers → StoryLine migration decisions (Nov 13, 2026)

Goal: make *Whispers* work with the Obsidian StoryLine plugin (docs at
`../StoryLine/.obsidian/plugins/obsidian-storyline/` — HELP.md, two conversion templates).

**Destination:** the staging vault `whispers/obsidian-story-line/whispers/` (plugin installed,
enabled). Original `whispers/` vault is never touched — `kb/`, `work/`, `manuscript/` stay as
agent infrastructure. Rollback = delete the new `StoryLine/` folder.

**Confirmed decisions:**
1. Migrate into the staging vault only.
2. Dual-POV scenes → `pov:` takes first-listed name; full original preserved in `notes:`.
3. Off-spec statuses (`proposed_edit`, `draft_redraft_marymchugh_*`, `review_required`) → StoryLine
   enum via lookup map; original recorded in `notes:`.
4. One world entity named **"Echoes"** contains all locations (option B). Its
   Beliefs & Mythology / History & Lore fields host the mythic overlay (regional: Morrigan,
   Dagda, Cailleach). Townhouse rooms nest via `parent:`.
5. Tailmatter (`## Revision Notes`, `## Continuity Checklist`, `## Created`) → `notes:`
   frontmatter; body becomes pure prose (no H1).

**Build order:** project file → Codex (world, locations+hierarchy, characters, Lore/Items/Mythic)
→ entity registry (names+aliases) → scene conversion of the 140 scene files → validation that all
`characters`/`pov`/`location` refs resolve.

**Key facts:** 140 scenes, 30 chapters (scene IDs NN.M must survive as `scene_id:` custom field —
kb/canon cites them). Custom frontmatter keys survive plugin saves (MetadataParser.updateFrontmatter
merges). Scene naming: `Scenes/NN-MM Title.md`. Project file uses `type: storyline`.
Characters/Locations without worlds are allowed ("standalone") but we use one world.
Agents (judgment: character consolidation, location registry) vs. deterministic script (the 140
scene transforms — must be identical, not re-imagined per file).
