
# Aderyn Implementation Plan: Gas-Stipend-Aware Ether Transfer Detector - 2025-07-30 - Gemini

## Query

Make a new report, of where exactly the code will be edited to implement this new detector.

## Implementation Plan

To implement the new gas-stipend-aware Ether transfer detector, the following files will need to be created and/or modified:

### 1. New Detector File

A new file will be created at `aderyn_core/src/detect/low/gasless_send.rs`. This file will contain the core logic for the new detector.

```rust
// aderyn_core/src/detect/low/gasless_send.rs

use std::{collections::BTreeMap, error::Error};

use crate::ast::{{ASTNode, NodeID}};

use crate::{{
    capture,
    context::workspace::WorkspaceContext,
    detect::detector::{{IssueDetector, IssueDetectorNamePool, IssueSeverity}},
}};
use eyre::Result;

#[derive(Default)]
pub struct GaslessSendDetector {{
    found_instances: BTreeMap<(String, usize, String), NodeID>,
}}

impl IssueDetector for GaslessSendDetector {{
    fn detect(&mut self, context: &WorkspaceContext) -> Result<bool, Box<dyn Error>> {{
        for member_access in context.member_accesses() {{
            if member_access.member_name == "send" || member_access.member_name == "transfer" {{
                if let Some(ASTNode::FunctionCall(func_call)) = member_access.parent(context) {{
                    capture!(self, context, func_call);
                }}
            }}
        }}

        Ok(!self.found_instances.is_empty())
    }}

    fn severity(&self) -> IssueSeverity {{
        IssueSeverity::Low
    }}

    fn title(&self) -> String {{
        String::from("Use of `.send()` or `.transfer()`")
    }}

    fn description(&self) -> String {{
        String::from(
            "Using `.send()` or `.transfer()` forwards a fixed gas stipend of 2300, which may not be sufficient for the recipient's fallback function, leading to transaction failure. It is recommended to use `.call{{value: ...}}(\"\")` instead, which forwards all available gas."
        )
    }}

    fn instances(&self) -> BTreeMap<(String, usize, String), NodeID> {{
        self.found_instances.clone()
    }}

    fn name(&self) -> String {{
        IssueDetectorNamePool::GaslessSend.to_string()
    }}
}}

#[cfg(test)]
mod gasless_send_tests {{
    use crate::detect::{{detector::IssueDetector, low::gasless_send::GaslessSendDetector}};

    #[test]
    fn test_gasless_send() {{
        let context = crate::detect::test_utils::load_solidity_source_unit(
            "../tests/contract-playground/src/GaslessSend.sol",
        );

        let mut detector = GaslessSendDetector::default();
        let found = detector.detect(&context).unwrap();

        assert!(found);
        assert_eq!(detector.instances().len(), 2);
    }}
}}
```

### 2. Detector Registration

The new detector will be registered in `aderyn_core/src/detect/low.rs` so that it is included in the analysis.

```rust
// aderyn_core/src/detect/low.rs

// ... existing code ...
pub(crate) mod gasless_send;
// ... existing code ...

// ... existing code ...
pub use gasless_send::GaslessSendDetector;
// ... existing code ...
```

### 3. Detector Name Pool

The `IssueDetectorNamePool` enum in `aderyn_core/src/detect/detector.rs` will be updated to include the new detector.

```rust
// aderyn_core/src/detect/detector.rs

// ... existing code ...
pub enum IssueDetectorNamePool {{
    // ... existing enum values ...
    GaslessSend,
}}

impl std::fmt::Display for IssueDetectorNamePool {{
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {{
        match self {{
            // ... existing match arms ...
            IssueDetectorNamePool::GaslessSend => write!(f, "gasless-send"),
        }}
    }}
}}
```

By making these changes, the new detector will be fully integrated into Aderyn and will be able to identify the use of `send()` and `transfer()` in Solidity code.
