# Contributing

Thanks for your interest in contributing.

## Development environment

See the [Quickstart](README.md#quickstart) and
[Prerequisites](README.md#prerequisites) sections of the README.

## Workflow

1. Create a branch from `main`.
2. Run `task check` before committing.
3. Keep Terraform modules in `terraform/modules/` and environment instances in
   `terraform/0-bootstrap/`, `terraform/1-landing-zone/` and
   `terraform/2-environments/`.
4. Every resource must carry the `dll-*` labels; OPA enforces this in CI.
5. Document meaningful decisions as an ADR in `ADRs/`.

## Commit messages

Follow [Conventional Commits](https://www.conventionalcommits.org/).
