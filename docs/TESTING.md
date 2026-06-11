# Testing

Run from the repository root:

```bash
bash scripts/check.sh
git diff --check
git status --short
```

`scripts/check.sh` verifies required paths, skill frontmatter, forbidden local-state files, conflict markers, and trailing whitespace.

If `PyYAML` is installed, `scripts/check.sh` also runs Codex's `quick_validate.py` for each skill. If `PyYAML` is missing, the script reports that `quick_validate.py` was skipped and still runs its dependency-free frontmatter checks.

After install changes, dry-run review the installer manually before using it on another machine:

```bash
sed -n '1,220p' scripts/install.sh
bash scripts/install.sh --dry-run
bash scripts/install.sh --skills-only --skill ralph-loop --dry-run
```

Do not run install scripts in production-like or shared accounts without checking target paths first.
