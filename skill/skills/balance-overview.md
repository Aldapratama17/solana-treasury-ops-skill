# Balance Overview

Goal: show what a multisig treasury currently holds, grouped in a way a
non-technical contributor can scan in a few seconds.

## Inputs needed from the user

- The multisig address (`multisigPda`), OR the `createKey` used to derive it
- Which vault index to check (default to index 0 if not specified — this is
  the default vault for most Squads setups)
- Optionally: an RPC URL (default to a public mainnet RPC if not provided,
  but warn the user that public RPCs rate-limit and a dedicated RPC
  endpoint like Helius is recommended for repeated use)

## Steps

1. Derive the vault PDA from the multisig PDA:
   ```ts
   import * as multisig from "@sqds/multisig";
   const [vaultPda] = multisig.getVaultPda({ multisigPda, index: 0 });

