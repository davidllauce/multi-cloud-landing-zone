from pathlib import Path
import shutil
import subprocess

import pytest

ROOT = Path(__file__).resolve().parents[1]
TERRAFORM = ROOT / "terraform"
POLICY_DIR = TERRAFORM / "modules" / "policy"
POLICY = POLICY_DIR / "landing_zone.rego"
FIXTURES = ROOT / "tests" / "fixtures"


def _conftest_available() -> bool:
    return shutil.which("conftest") is not None


def test_policy_requires_cost_center() -> None:
    content = POLICY.read_text()
    assert '"dll-cost-center"' in content
    assert '"dll-team"' in content
    assert '"dll-owner"' in content
    assert '"env"' in content


def test_aws_module_declares_required_labels() -> None:
    content = (TERRAFORM / "modules" / "aws-landing-zone" / "main.tf").read_text()
    assert '"dll-cost-center"' in content
    assert '"dll-team"' in content
    assert '"env"' in content


@pytest.mark.skipif(not _conftest_available(), reason="conftest not installed")
def test_valid_plan_passes_policy() -> None:
    result = subprocess.run(
        ["conftest", "test", str(FIXTURES / "plan_valid.json"),
         "--policy", str(POLICY_DIR)],
        capture_output=True,
        text=True,
    )
    assert result.returncode == 0, result.stdout + result.stderr


@pytest.mark.skipif(not _conftest_available(), reason="conftest not installed")
def test_invalid_plan_is_denied() -> None:
    result = subprocess.run(
        ["conftest", "test", str(FIXTURES / "plan_invalid.json"),
         "--policy", str(POLICY_DIR)],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "missing required" in (result.stdout + result.stderr)
