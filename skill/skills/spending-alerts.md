# Spending Alerts

Goal: surface outgoing transactions worth a second look — large transfers,
or transfers to a destination the vault hasn't paid before. This is a
lightweight heuristic check, not a security audit.

## Inputs needed from the user

- The multisig/vault address
- A threshold amount (in USD or in a specified token) above which a
  transaction should be flagged. If not given, propose a reasonable
  default (e.g. flag anything above 10% of average monthly burn) and
  state that you're using a default.
- Optional: a lookback window (default 30 days)

## Steps

1. Fetch executed vault transactions in the lookback window. Vault
   transaction history can be read via the multisig's transaction index
   and `multisig.accounts.VaultTransaction` / proposal accounts, or via
   `connection.getSignaturesForAddress(vaultPda)` plus parsing for
   transfer instructions.
2. For each outgoing transfer, extract: amount, asset, destination
   address, timestamp, and (if available) which member proposed/approved
   it.
3. Build a simple destination history: has this vault sent funds to this
   exact address before in past activity?
4. Flag a transaction if either is true:
   - Amount exceeds the threshold
   - Destination has never been paid before by this vault
5. Do not flag normal recurring payments (e.g. same destination, similar
   amount, regular interval) as new-destination risk after the first
   occurrence — only the first payment to a new address should be flagged
   on that basis.

## Output format
## Notes

- This is a heuristic, not a fraud detector. Frame flags as "worth a
  second look," not as accusations.
- Never claim a transaction is malicious. Just surface the facts (amount,
  destination, novelty) and let the human decide.
- If transaction history can't be fully retrieved (e.g. RPC limitations),
  say so explicitly rather than presenting a partial list as complete.
