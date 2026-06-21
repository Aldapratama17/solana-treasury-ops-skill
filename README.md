# solana-treasury-ops-skill

A read-only Solana AI Kit skill for monitoring a Squads multisig treasury:
balances, vesting runway, spending anomalies, and governance reporting.

Built for founders, DAO contributors, and protocol teams who currently
track treasury health by hand in a spreadsheet, and want an AI agent that
can read multisig state directly and reason about it.

## Table of contents

- [Problem it solves](#problem-it-solves)
- [What it covers](#what-it-covers)
- [Structure](#structure)
- [Quick start](#quick-start)
- [Manual install](#manual-install)
- [Example usage](#example-usage)
- [Requirements](#requirements)
- [Scope](#scope)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)
- [License](#license)

## Problem it solves

Teams running a Squads multisig treasury (DAOs, protocols, grant-funded
projects) almost always end up tracking balances, burn rate, and runway by
hand in a spreadsheet, because there's no standard skill for an AI coding
agent to read this state directly and reason about it. Dashboards like
Squads' own UI are built for humans clicking around, not for an agent that
needs to answer "how much runway do we have left" or "did anything unusual
go out last week" in one pass.

This skill closes that gap. It's read-only and never signs or proposes
transactions, so it's safe to install without custodying any keys.

## What it covers

- **Balance overview** — current SOL, stablecoin, and token holdings in a
  multisig vault, grouped for quick scanning instead of a raw list of
  mint addresses.
- **Vesting and runway** — projects how many months of runway remain given
  current balance, vesting unlocks, and historical burn rate, with
  assumptions stated alongside the number.
- **Spending alerts** — flags outgoing transactions that are unusually
  large or sent to a new, previously-unpaid destination. A heuristic
  check, not a security audit.
- **Governance report** — assembles a short, copy-pasteable treasury
  update for a DAO forum or Discord post.

## Structure

```

solana-treasury-ops-skill/
├── skill/
│   ├── SKILL.md              entry point / router
│   ├── skills/
│   │   ├── balance-overview.md
│   │   ├── vesting-runway.md
│   │   ├── spending-alerts.md
│   │   └── governance-report.md
│   └── agents/
│       └── treasury-analyst.md   optional agent persona
├── LICENSE
├── README.md
└── installer.sh
```

Follows the progressive-loading pattern from solana-game-skill: `SKILL.md`
routes to the specific sub-skill needed instead of loading everything into
context at once. Each file in `skills/` is self-contained and only gets
read when the routing table in `SKILL.md` points to it.

## Quick start

```bash
git clone https://github.com/Aldapratama17/solana-treasury-ops-skill.git
cd solana-treasury-ops-skill
./installer.sh
```

By default this installs into `~/.claude/skills/solana-treasury-ops-skill`.
To install somewhere else:

```bash
./installer.sh /path/to/your/skills/dir
```

To install as part of an existing Solana AI Kit checkout instead, add it
as a submodule:

```bash
git submodule add https://github.com/Aldapratama17/solana-treasury-ops-skill.git skills/treasury-ops
```

## Manual install

If you'd rather not run `installer.sh`, or you're integrating this into a
custom agent setup, you can copy the files yourself. The only folder that
matters at runtime is `skill/`.

```bash
# 1. Clone the repo
git clone https://github.com/Aldapratama17/solana-treasury-ops-skill.git
cd solana-treasury-ops-skill

# 2. Create the target skills directory if it doesn't exist
mkdir -p ~/.claude/skills/solana-treasury-ops-skill

# 3. Copy the skill/ contents (not the whole repo) into it
cp -r skill/* ~/.claude/skills/solana-treasury-ops-skill/

# 4. Confirm the entry point is in place
ls ~/.claude/skills/solana-treasury-ops-skill/SKILL.md
```

That's it — no build step, no dependencies to install for the skill files
themselves. If your agent host uses a different skills directory than
`~/.claude/skills/`, swap the path in step 2 and 3 for the correct one.

To remove it later:

```bash
rm -rf ~/.claude/skills/solana-treasury-ops-skill
```

## Example usage

Once installed, a few examples of what you can ask an agent that has this
skill loaded:

```
"What's our current treasury balance?"
→ routes to balance-overview.md

"How many months of runway do we have left at our current burn rate?"
→ routes to vesting-runway.md

"Did anything unusual go out of the treasury this week?"
→ routes to spending-alerts.md

"Write a treasury update I can post to our Discord for this month"
→ routes to governance-report.md
```

The agent will ask for the multisig address (and vault index, if not the
default) the first time it needs on-chain data, since this skill doesn't
store or guess that information.

## Requirements

- A Solana RPC endpoint. A dedicated provider (Helius, Triton, etc.) is
  recommended over a public RPC if you'll be running these checks
  regularly, since public RPCs rate-limit quickly.
- `@sqds/multisig` and `@solana/web3.js` if the host agent is executing
  TypeScript directly against the Squads v4 program. No other
  dependencies are required by the skill files themselves.

## Scope

This skill is intentionally read-only and treasury-level. It does not:

- Manage CLMM/LP positions
- Perform security audits of program code
- Create, configure, or administer a multisig
- Construct, sign, or execute any transaction

If you need any of the above, those are better suited to a dedicated
skill — this one is scoped narrowly on purpose so it stays simple to
audit and safe to install.

## Troubleshooting

**The agent can't resolve my multisig address.**
Double-check the address is the `multisigPda`, not the vault address.
Funds live at a vault PDA derived from the multisig PDA — the skill
derives this automatically once it has the multisig address.

**Balance or transaction data looks incomplete.**
Most likely a public RPC rate limit. Switch to a dedicated RPC endpoint
and retry.

**Runway numbers seem off.**
Runway is a projection based on a stated lookback window (90 days by
default) and whatever vesting schedule you provide. If burn rate has
recently changed (a one-off large payment, a new hire, etc.), the
projection will reflect the old average until the window rolls forward.

## FAQ

**Does this skill ever sign or send transactions?**
No. It's read-only by design — it only queries on-chain state and
presents it back. This is a deliberate scope decision, not a current
limitation to be removed later.

**Can it work with multisigs other than Squads?**
Not currently. It's built specifically against the Squads Protocol v4
SDK and PDA structure.

**Does it store any data?**
No. Every query re-reads current on-chain state. There's no local cache
or database.

## License

MIT — see [LICENSE](./LICENSE).
```

