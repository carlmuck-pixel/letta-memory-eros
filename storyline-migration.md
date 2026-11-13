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

**Plugin facts (from source reading):**
- Codex category IDs are lowercase (`items`, `creatures`, `lore`, `organizations`, `culture`,
  `systems`) and equal the entry's frontmatter `type:` value; folders use the capitalized name
  (`Codex/Lore/`, `type: lore`). Using built-ins avoids per-project category config.
- The plugin derives the project folder from the project file's basename, so a project file nested
  inside its folder works — plugin settings (`data.json` `activeProjectFile`) point to
  `StoryLine/Whispers/Whispers.md`, which is the layout used here.
- Timeline view keys on `storyDate`; `timeline_mode: flashback` can be set without
  `chronologicalOrder`.

**Scene-data quirks (verified, not re-derivable cheaply):**
- `act:` frontmatter is stale junk (ch 29–30 marked act 1) — always derive act from chapter via
  `kb/plot`: A1 = ch 1–5 (The Shattering), A2a = 6–12 (The Gap), A2b = 13–24 (Descent &
  Rewilding), bridge = 26–28, A3 = 25 + 29–30. Use numeric acts for board columns and tags for
  fine-grained labels (e.g. `act-2a-gap`).
- Chapter 27/28 directories are empty placeholders — 28 chapters actually contain scenes; report
  the gap, don't fill blanks.
- ~84 distinct raw location strings across scenes; only 7 of 9 characters have full
  `kb/characters/<slug>/` sheets (Elara Hamilton, Mira Santoni lack them).

**Execution artifacts:** deterministic converter `whispers/work/storyline_convert.py` and validator
`whispers/work/storyline_validate.py` (re-run these instead of re-writing). Judgment work (9
character consolidations, location registry, Lore/Items/Echoes profile) runs as parallel shadow
agents that write vault files directly and return compact receipts + registry entries.

**Open continuity contradictions flagged during consolidation:** Finn = husband (vocab.md) vs
partner (kb); Jonas status contradictory in Elena's sources; Elena missing from vocab.md.
