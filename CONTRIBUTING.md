# Contributing

Zero Vault is a security-focused Flutter project. Contributions should prioritize correctness, clarity, and maintainability over speed or unnecessary complexity.

## Ground Rules

- Keep the zero-knowledge model intact. Plaintext secrets and master passwords must never be sent to the backend.
- Prefer small, focused pull requests.
- Do not mix visual refactors, architecture changes, and security-sensitive logic in one PR unless they are tightly related.
- Add or update tests when touching crypto, auth, sync, storage, or state-management flows.
- Keep local secrets, Supabase keys, and device-specific config out of git.

## Development Setup

Install dependencies:

```bash
flutter pub get
```

Run the project locally:

```bash
flutter run
```

Run with Supabase configuration:

```bash
flutter run --dart-define-from-file=env/supabase.local.json
```

## Project Standards

- Follow the existing clean architecture boundaries in `core`, `data`, `domain`, and `presentation`.
- Keep crypto and security-critical logic explicit and testable.
- Prefer ASCII-only edits unless a file already clearly requires Unicode.
- Avoid committing generated noise unless it is required for the app to build.
- Keep UI work aligned with the current visual direction instead of introducing unrelated design systems.

## Before Opening A Pull Request

Run:

```bash
dart analyze lib test
flutter test
```

If a change affects cloud sync, also validate:

- sign-in flow
- upload and download flow
- local merge behavior
- locked-session behavior after app resume

## Pull Request Checklist

- The change is scoped and explained clearly.
- Tests were added or updated where needed.
- The README still matches the current behavior.
- No secrets or local config files were committed.
- Security-sensitive changes include rationale in the PR description.

## High-Value Contribution Areas

- stronger sync conflict resolution
- TOTP support
- integration and widget tests
- accessibility improvements
- release engineering and CI polish
- security hardening and review
