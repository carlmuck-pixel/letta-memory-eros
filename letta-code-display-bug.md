---
name: letta-code-display-bug
description: Recurring harness bug — long Eros responses render as just "I" in Carl's client; recover by re-sending a compact version.
---

# Letta Code response-truncation bug

Observed Nov 13, 2026: Carl reported (saying "again") that my long replies render in his client
as only the single character "I" — the streamed response is eaten by the display layer.
Version 0.34.36, macOS CLI.

## How to handle when it happens
1. Acknowledge briefly; it's a harness display bug, not lost work.
2. Re-send the same content in compact form (tables/bullets, less prose) — don't just say "sorry,
   can you see it now?"
3. Offer to file it with the Letta team via the `submitting-feedback` skill (ask first; don't auto-submit).
4. If it persists, suggest Carl restart the local inference server — that cleared it once and the
   re-sent reply went through; a CLI session restart is the fallback.
