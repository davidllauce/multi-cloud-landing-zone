# policy

Policy-as-code (OPA/Conftest) enforced in CI. Every created resource must carry
the mandatory labels — `dll-cost-center`, `dll-team`, `dll-owner`, `env` — as
GCP `labels` or AWS `tags`; violations reject the PR.

The policy reads a Terraform **plan JSON** (`resource_changes`), the production
pattern. Test against the committed fixtures:

```bash
# compliant plan (expects no violations)
conftest test tests/fixtures/plan_valid.json --policy terraform/modules/policy

# non-compliant plan (expects a violation)
conftest test tests/fixtures/plan_invalid.json --policy terraform/modules/policy
```

Static checks (label presence in modules) also run in `tests/test_policy.py`.
