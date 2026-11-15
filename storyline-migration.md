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

## Execution status (Nov 13, 2026) — BUILD COMPLETE, awaiting Carl's review

Delivered in staging vault: 140 scenes + project file + 94 Codex entities (9 characters,
72 locations incl. 37 parented children + Echoes.md world file, 11 Lore + Holloway Journal).
Validator baseline: 26 "unresolved" refs are intended plain-text bit-parts (Jamie, Lydia,
Sophie, Julian, George, Isabel, Alfred, Lady Elizabeth, Mrs. Murray/Madge, Sir Alistair,
Neighbor, Finn, "The Coven (Nurses)", "The Photo Family", "Nicholas (The Stranger)",
"The Cailleach (Hag)"); 2 pov warnings (plain-text collectives); all else clean.

**Converter quirks (verified, encoded in the script):** 3 ch24 files use dash filenames
`Scene 24.1-Title.md` (no spaces); source corruption `Aoife O''Reilly` (double apostrophe)
in several files; template tailmatter (stock 3-item continuity checklist + empty HTML
comments) stripped from notes; only 2 flashbacks exist (Cannes 2022-05-20, Maldives
2019-07-02); act overrides applied on 95 scenes (frontmatter act was stale).

**Carl's decision queue:** (1) 10 scenes with `pov: null` — ch18 (18-03,05,06,07,08),
ch29 (all four), 24-03. (2) `Nicholas (The Stranger)` (17-07) intentionally unmapped —
maybe Nick in disguise? (3) Chosen resolutions: Clive age 42 (sheet's 32 stale per
CORE_TRUTH b.1983), Aoife 40 (vs 39), Monica physicals per newer More Detail, Roisin–Finn
= partner, Jonas left as Elena's boyfriend per her sheet (contradicts ch23), Pact of Kings
authorship unreconciled (Clive vs Aoife-as-Auditor). (4) vocab.md lacks Elena + Justine
rows — offered to patch. (5) Ch 27/28 dirs genuinely empty (placeholders).

**Volatile risk:** converter reads `/tmp/storyline_registry/*.yaml` (agent-built registry)
and reports live there — copy registry + reports into `whispers/work/` to survive a reboot.

## Lead box / hall clock lore (13 Nov late — co-authoring mode with Carl)

**ESCALATION LAW (Carl, governs ALL scene edits):** story opens grounded — dissolving
sexual relationship finding its exit; The Shattering is catalyst; lore objects (clock,
lead box, papyrus, porphyry) are set dressing early; mythic/occult minimal to start,
growing into the climax. Codified in Hall Clock codex custom + kb page Decisions #4.

**Decided:** clock ran perfectly until Holland House raid night **27/28 Sept 1940**
(verified via Survey of London vol. 37 / MOI-IWM HU 94331: ten-hour **incendiary** raid,
oil bomb + "Molotov breadbasket" — the popular **"parachute mine" is unsupported**, all
mine mentions scrubbed; no time-of-night on record, so Mistral's 3:17 fully retired;
master-timeline 1941 row corrected; hands frozen that night); Francis Jr. repaired
repeatedly, **never reliable**, journal entries until 1995; Arthur never tried ("the
pile"); **clock restarts at the resolution — someone barely touches the pendulum**
(who/why open, Act III plot). Early ticking = **Clive's modern mechanical office clock**
(showpiece intro deferred to an office scene; 1.6/1.7 stripped to bare tick).
Inscription: **"Picts and barbarians"** (Picti et barbari — implies late-3rd-c.
withdrawal). Papyrus = many hands: **Etruscan, Latin, Brythonic/Celtic, rune-like**;
Etruscan = **Mira's hook** (Tuscany). Artifacts: `kb/world/lore/lead-box-and-hall-clock.md`
+ `Codex/Items/Holloway Hall Clock.md` (95 entities); registry lore.yaml has clock
aliases; Echoes + Kensington lore + journal codex updated; converter/validator re-run
clean (140 scenes / 95 entities).

**Awaiting Carl:** vocab.md patch (Elena/Justine rows + clock/box terms) still unapproved;
pendulum-toucher parked for Act III; validator's remaining unresolved refs Julian/Isabel/
Alfred/Lady Elizabeth (from the known-26 list).

**Settled (Carl, round 2 — 13 Nov):** journal+DBS ~2001 from the Guardian just before his
death (2003), as Clive left for American college; journal **left at the house, ignored by
Arthur**; Clive handles it **from founding his own firm**. **Arthur died 2023** — 12–15 mo
renovation (basement gym, master penthouse suite), resident late 2024, ~6 mo by Apr 2025;
**Monica falters + proposal pressure during the residence**. Second James: **dies beside
Francis Jr., North Africa 1942, blood on the journal page** (timeline 1942 row added;
Echoes fixed; military notice kept); Francis meets **Genevieve Tuscany at war's end**.
Cotswolds: Builder built it for his wife (+ lovers); stayed family; **Arthur's wife —
Clive's mother — raised Clive there**. **14.3 digital clock stays** (gallery/gym, not
office). **Nicholas (The Stranger) ≠ Nick Hardaway** (Carl): 17.7 first-class seatmate,
cosmic-joke name device — own codex entry + `char_nicholas_stranger.yaml` (96 entities).
Justine + Elena already had full codex sheets (agents built them); Elena beefed with
onscreenDates + scene sources.
