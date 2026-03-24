# Security Policy

## Scope

Zero Vault is a portfolio-grade security-focused application. It is designed with zero-knowledge principles, but it has not been through a formal third-party security audit.

Vulnerabilities should be reported responsibly and not disclosed publicly before a fix is available.

## Supported Versions

At this stage, security fixes are expected only for the latest state of the default branch.

| Version | Supported |
| --- | --- |
| `main` | Yes |
| Older snapshots | No |

## Reporting A Vulnerability

Security issues should be reported privately through one of these channels:

- GitHub private security advisory, if enabled on the repository
- direct maintainer contact listed on the GitHub profile

Include:

- a short description of the issue
- affected files or flows
- reproduction steps
- impact assessment
- suggested remediation, if known

## What To Report

Relevant reports include:

- plaintext secret exposure
- master-password handling flaws
- broken encryption or key derivation assumptions
- auth bypass or biometric bypass
- insecure local persistence
- cross-user data access in Supabase or RLS misconfiguration
- sync logic that causes data disclosure or silent corruption

## Out Of Scope

The following are generally out of scope unless they create a direct security impact:

- missing optional hardening ideas without a practical exploit
- outdated screenshots or documentation mismatches
- UI bugs with no effect on secret handling or access control
- local development misconfiguration outside the repository defaults

## Security Notes For Reviewers

Current defensive controls in this repository include:

- local-only master password flow
- Argon2id key derivation
- AES-256-GCM encryption
- secure storage for local vault metadata
- biometric re-auth support
- clipboard auto-clear
- Supabase storage of encrypted blobs only

Known limitations:

- Dart `String` handling means secret zeroization is not absolute in all runtime cases
- web builds currently rely on an Isar generated-schema workaround for JavaScript-safe integers
- no formal external audit has been completed yet
