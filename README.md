# PC Hardware Diagnostic Expert System

**Course:** COMP 474/6741: Intelligent Systems  
**Term:** Winter 2026  
**Team Members:** Robert Stacey, Victor Okoro, David Makary

## GitHub Submission Details

- **GitHub username:** `sonicman674`
- **Repository URL:** `https://github.com/sonicman674/PC_Hardware_Diagnostic_Expert_System_Stacey_Makary_Oktoro_COMP474`
- **Canonical project title:** `PC Hardware Diagnostic Expert System`

This repository is the canonical source archive for the project deliverables. The teaching assistants should use the repository URL above to access the code and supporting source documentation independently.

### Access Notes for Evaluators

- The deliverable source artifacts are stored at the repository root.
- The key files for grading are `facts.txt`, `rules.txt`, `driver.clp`, `design.txt`, and `test-cases.txt`.
- If the repository is private at grading time, course staff must be granted read access to this exact repository before evaluation.
- The repository URL above should be included in the deliverable submission so the project can be processed independently.

## Project Overview

This project implements a CLIPS-based expert system for diagnosing common PC hardware failures. The knowledge domain focuses on practical desktop troubleshooting for:

- power delivery and motherboard behavior,
- display and graphics issues,
- memory problems, and
- storage failures.

The system began as a Deliverable 1 knowledge base for certain knowledge and was extended in Deliverable 2 with:

- probabilistically uncertain reasoning using **Certainty Factors**, and
- possibilistically uncertain reasoning using **Fuzzy Logic**.

## Knowledge Domain, Goal, and User

### Knowledge Domain (D)

The knowledge domain is a subset of personal computer hardware diagnostics covering:

- power supply and motherboard behavior such as POST, power delivery, and CMOS faults,
- display output and GPU failure modes,
- RAM detection, seating, and stability issues,
- storage detection, boot, and degradation issues.

This domain was chosen because it has publicly available authoritative references and because practical diagnostic knowledge is useful to many PC builders and hobbyists.

### Goal (G)

The project goal is to develop a CLIPS expert system that helps users identify likely PC hardware failures and next-step actions using an explainable, modular, and testable knowledge base.

### Potential User (U)

The primary user is a home PC builder or hobbyist who:

- understands basic hardware components,
- wants help diagnosing faults without immediate professional repair,
- benefits from step-by-step guidance before replacing expensive parts.

## Deliverable 2 Summary

Deliverable 2 extends the knowledge base with uncertain knowledge and addresses feedback from Deliverable 1.

### D2 TODO 1

- `design.txt` contains the itemized D1 feedback summary.
- `design.txt` also explains the concrete D2 changes made in response and how each change can be verified independently.

### D2 TODO 2

- Probabilistic uncertainty is implemented using **Certainty Factors**.
- `facts.txt` includes `cf-evidence` facts with numeric weights and rationales.
- `rules.txt` includes `cf-*` rules for single-evidence and combined-evidence inference.

### D2 TODO 3

- Possibilistic uncertainty is implemented using **Fuzzy Logic**.
- `facts.txt` includes `fuzzy-variable` and `fuzzy-set` definitions.
- `rules.txt` includes fuzzification plus `fuzzy-*` inference rules.

### D2 TODO 4

- `design.txt` documents four selected quality attributes:
  - explainability,
  - maintainability,
  - consistency,
  - traceability.
- It also explains where the corresponding quality guidelines were applied and what impact they had on the knowledge base.

## Current Knowledge Base Structure

The knowledge base `K` is the combination of:

- `facts.txt` for the factbase `F`
- `rules.txt` for the rulebase `R`

The implementation is modular and keeps facts separate from rules.

### Factbase Highlights

`facts.txt` currently includes:

- 13 `deftemplate` definitions,
- D1 crisp knowledge such as symptoms, failure scenarios, and symptom indicators,
- D2 probabilistic knowledge through `cf-evidence`,
- D2 fuzzy knowledge through `fuzzy-variable` and `fuzzy-set`,
- runtime-facing structures such as `reported-symptom`, `sensor-reading`, `fuzzy-assessment`, and `diagnostic-conclusion`.

### Rulebase Highlights

`rules.txt` currently includes 34 rules total:

- baseline D1 session and crisp diagnosis rules,
- crisp strengthening rules that fix the old multi-symptom limitation,
- 13 Certainty Factor rules (`cf-*`),
- 12 fuzzy rules in the fuzzy section, including fuzzification and 11 `fuzzy-*` rules,
- summary and helper rules for traceable output and verification prompts.

### Supporting Deliverable Files

- `driver.clp`: interactive diagnosis driver for D2 symptom certainty factors and optional quantitative readings
- `design.txt`: evaluator-facing D2 design document and improvement report
- `test-cases.txt`: reproducible validation and verification procedure
- `finalfeed.txt`: feedback transcript used as a source for the D1 improvement summary

## Usage

### CLIPS Load Sequence

```clips
(load "/path/to/facts.txt")
(load "/path/to/rules.txt")
(load "/path/to/driver.clp")
(reset)
(run-diagnosis)
```

### Interactive Flow

When `run-diagnosis` is called, the driver will:

1. ask the user to choose observed symptoms,
2. ask for a certainty factor for each selected symptom from `0.0` to `1.0`,
3. ask for optional quantitative readings for fuzzy reasoning,
4. allow `-1` to skip any quantitative reading,
5. run the expert system and print traceable conclusions.

### Quantitative Readings Used by Fuzzy Logic

The fuzzy input workflow supports:

- `cpu-temperature`
- `gpu-temperature`
- `voltage-stability`
- `storage-health`
- `boot-time`

### Symptom IDs

- **Power and motherboard:** `no-power-at-all`, `shutdown-under-load`, `post-beep-codes`, `intermittent-power`, `time-date-reset`, `system-freezes-under-load`
- **Display and graphics:** `no-display-output`, `screen-artifacts`, `monitor-not-detected`, `driver-crash-recovery`
- **Memory and storage:** `ram-not-in-bios`, `blue-screen-crashes`, `storage-not-detected`, `boot-device-not-found`, `slow-storage-access`

## Validation and Verification

Validation and verification are documented in `test-cases.txt` as a reproducible procedure instead of only a narrative list of outcomes.

The current verification document includes:

- D1 regression tests,
- Certainty Factor tests,
- Fuzzy Logic tests,
- cross-theory tests,
- driver integration tests,
- negative and edge-case tests.

There are currently 22 documented test scenarios in `test-cases.txt`.

## Individual Contributions

- **Robert Stacey:** power and motherboard diagnostics
- **Victor Okoro:** display and graphics diagnostics
- **David Makary:** memory and storage diagnostics

## Debugging Support

Useful CLIPS debugging commands:

```clips
(watch facts)
(watch rules)
(watch activations)
(facts)
(agenda)
```

## References

1. CLIPS Reference Manual, Version 6.4, Interfaces Guide  
   https://www.clipsrules.net/documentation/v642/ig642.pdf
2. CLIPS 6.4 User's Guide  
   https://www.clipsrules.net/documentation/v642/ug642.pdf
3. CLIPS Reference Manual, Version 6.4, Basic Programming Guide  
   https://www.clipsrules.net/documentation/v642/bpg642.pdf
4. Corsair, *How to Test a PSU (Power Supply Unit)*  
   https://www.corsair.com/ca/en/explorer/diy-builder/power-supply-units/how-to-test-a-psu-power-supply-unit/?srsltid=AfmBOorw2poPsa2xrylx9dER60jnG0xP9v9yaM8HBx_MZT8U19JaHUei
5. MemTest86, *Technical Information*  
   https://www.memtest86.com/technical.htm
6. CrystalDiskInfo, *S.M.A.R.T. HDD/SSD Monitoring Utility*  
   https://crystalmark.info/en/software/crystaldiskinfo/
7. HP, *Troubleshooting Guide for Business Desktops*  
   https://h10032.www1.hp.com/ctg/Manual/c00189283.pdf
8. Dell, *Understanding Beep Codes on Dell Desktop PCs*  
   https://www.dell.com/support/kbdoc/en-ca/000124349/understanding-beep-codes-on-a-dell-desktop-pc
9. Display Driver Uninstaller (DDU)  
   https://www.wagnardsoft.com/display-driver-uninstaller-DDU-
