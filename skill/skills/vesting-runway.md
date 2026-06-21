# Vesting & Runway

Goal: estimate how many months of operating runway a treasury has left,
combining current balances, known vesting unlocks, and historical burn rate.

## Inputs needed from the user

- Current treasury balance (reuse balance-overview.md if not already known)
- Vesting schedule details, if any tokens are still locked/unlocking:
  - cliff date
  - unlock type (linear, or chunked/cliff-based)
  - total amount and end date
- A lookback window for burn rate calculation (default: last 90 days)

## Steps

1. If vesting inputs aren't provided, ask for them rather than assuming —
   runway numbers are meaningless without real vesting data, and a wrong
   guess here is worse than no answer.
2. Calculate burn rate:
   - Pull outgoing vault transactions over the lookback window (see
     spending-alerts.md for the transaction-fetching approach)
   - Sum outgoing value (in the treasury's primary spending asset, usually
     a stablecoin) over the window
   - Divide by number of months in the window to get average monthly burn
3. Calculate incoming unlocks over the same forward horizon as the runway
   estimate, based on the vesting schedule provided.
4. Project forward month by month:

Runway = first month where balance goes at or below zero, or "beyond
projection window" if it never does within a reasonable horizon (e.g.
36 months).
5. Always show the assumption set alongside the number — burn rate is
inherently a projection, not a fact. State the lookback window used and
flag if burn rate is volatile (e.g. one large one-off payment skewing
the average).

## Output format
## Notes

- This is a planning estimate, not financial advice — make that framing
  clear in the output rather than presenting the number as certain.
- If burn rate data is too sparse (e.g. multisig is brand new), say so
  instead of producing a number from too little data.
