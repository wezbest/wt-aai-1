# PR: Add createAccount documentation example

## Summary
Add comprehensive documentation example for `createAccount` function to improve developer onboarding experience.

## Changes
- **File**: `prt/src/viem/ServerActions.ts`
- **Lines**: 32-33 (replace "TODO" with working example)
- **Type**: Documentation improvement (no functional changes)

## Impact
- ✅ Replaces placeholder "TODO" with actionable code example
- ✅ Shows complete workflow from client setup to account creation
- ✅ Reduces developer friction for primary SDK entry point
- ✅ Based on actual test patterns for accuracy

## Example Added
```typescript
/**
 * Creates a new Porto Account using an ephemeral EOA.
 *
 * @example
 * ```typescript
 * import { createClient, http } from 'viem'
 * import { sepolia } from 'viem/chains'
 * import * as Key from 'porto/viem/Key'
 * import { createAccount } from 'porto/viem/ServerActions'
 * 
 * // 1. Create a client connected to Porto RPC server
 * const client = createClient({
 *   chain: sepolia,
 *   transport: http('https://rpc.porto.sh')
 * })
 * 
 * // 2. Create an admin key for the account
 * const adminKey = Key.createHeadlessWebAuthnP256()
 * 
 * // 3. Create the Porto account
 * const account = await createAccount(client, {
 *   authorizeKeys: [adminKey]
 * })
 * 
 * console.log('Account created:', account.address)
 * ```
 *
 * @param client - Client.
 * @param parameters - Parameters.
 * @returns Result.
 */
```

## Testing
- ✅ No new tests required (documentation-only change)
- ✅ Example validated against existing test patterns
- ✅ Uses same imports and patterns as `ServerActions.test.ts`

## Checklist
- [ ] Replace TODO on lines 32-33 in `prt/src/viem/ServerActions.ts`
- [ ] Verify existing tests still pass
- [ ] No breaking changes or new dependencies