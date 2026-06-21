# solana-treasury-ops-skill

A read-only Solana AI Kit skill for monitoring a Squads multisig treasury:
balances, vesting runway, spending anomalies, and governance reporting.

## Problem it solves

Teams running a Squads multisig treasury (DAOs, protocols, grant-funded
projects) almost always end up tracking balances, burn rate, and runway by
hand in a spreadsheet, because there's no standard skill for an AI coding
agent to read this state directly and reason about it. This skill closes
that gap. It's read-only and never signs or proposes transactions, so it's
safe to install without custodying any keys.

## What it covers

- Balance overview - current SOL, stablecoin, and token holdings in a
  multisig vault, grouped for quick scanning.
- Vesting and runway - projects how many months of runway remain given
  current balance, vesting unlocks, and historical burn rate.
- Spending alerts - flags outgoing transactions that are unusually
  large or sent to a new, previously-unpaid destination.
- Governance report - assembles a short, copy-pasteable treasury
  update for a DAO forum or Discord post.

## Structure
Follows the progressive-loading pattern from solana-game-skill: SKILL.md
routes to the specific sub-skill needed instead of loading everything at
once.

## Install

```bash
git clone <this repo>
cd solana-treasury-ops-skill
./installer.sh

