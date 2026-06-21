# Solana Treasury Ops Skill

Helps founders, DAOs, and protocol teams monitor and report on a Squads
multisig treasury: balances, vesting runway, unusual outgoing transactions,
and recurring governance reports.

This file is the entry point. It routes to focused skill files below so
context is only loaded when it's actually needed.

## When to use this skill

Use this skill when the user asks about:
- Checking balances of a Squads multisig / DAO treasury vault
- How much runway a treasury has left given vesting and burn rate
- Spotting large or unusual outgoing transactions from a treasury
- Producing a periodic (weekly/monthly) treasury report for a community

## When NOT to use this skill

- Managing CLMM / LP positions (use position-manager-skill instead)
- Full security audits of program code (use solana-auditor-skill instead)
- Creating or configuring a brand-new multisig from scratch (this skill
  assumes a multisig already exists and is read-focused, not admin-focused)

## Routing

| User need | Load |
|---|---|
| "what's in our treasury", balances, token breakdown | skills/balance-overview.md |
| runway, burn rate, vesting schedule, how long until empty | skills/vesting-runway.md |
| large transfer, unusual destination, spending anomaly | skills/spending-alerts.md |
| monthly/weekly report, summary for governance/Discord | skills/governance-report.md |

Only load the specific skill file(s) needed for the user's request. Do not
load all four unless the request genuinely spans multiple areas (e.g. "give
me a full treasury health check" may need balance-overview + vesting-runway).

## Core concepts (apply across all sub-skills)

- This skill targets Squads Protocol v4 multisigs on Solana, accessed via
  the `@sqds/multisig` TypeScript SDK and a standard Solana RPC connection.
- A multisig is identified by its `multisigPda`. Funds live in a separate
  vault PDA derived from it (`getVaultPda`), not the multisig account
  itself. Always operate on the vault address for balance/transaction
  queries.
- This skill is READ-ONLY by design. It never constructs, signs, or
  proposes transactions. It only reads on-chain state and presents it.
  This keeps it safe to install and run without custodying any keys.
- All amounts should be displayed in human-readable units (divide by
  token decimals), never raw base units, unless the user asks for raw
  values explicitly.
