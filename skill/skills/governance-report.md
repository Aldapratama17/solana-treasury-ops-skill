# Governance Report

Goal: produce a short, copy-pasteable treasury update suitable for posting
to a DAO forum, Discord, or governance call notes.

## Inputs needed from the user

- Reporting period (default: last calendar month)
- Whether to include runway projection (pulls from vesting-runway.md)
- Whether to include flagged transactions (pulls from spending-alerts.md)
- Tone/length preference if any (default: concise, plain text, no emojis
  unless the user's community style uses them)

## Steps

1. Pull balance snapshot at start and end of the reporting period (or
   current balance if historical snapshot isn't available — note this
   limitation if so).
2. Summarize inflows and outflows for the period, grouped by category if
   discernible (grants received, contributor payments, protocol revenue,
   swaps, etc.) — only categorize what's reasonably inferable from
   transaction memos or known destination labels; don't invent categories.
3. Pull runway estimate if requested (see vesting-runway.md).
4. Pull spending alerts if requested (see spending-alerts.md), but keep
   this section brief in the report — link out to detail rather than
   dumping the full list inline.
5. Assemble into a short markdown report.

## Output format
## Notes

- Keep it readable by non-technical community members — avoid raw
  addresses and transaction hashes in the main body; put those in an
  appendix or omit them if the user doesn't ask for full transparency
  detail.
- Don't editorialize about whether spending is "good" or "bad" — present
  numbers neutrally and let the community/governance process interpret.
