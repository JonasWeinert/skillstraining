# Exercise Skill Setup

This folder is intentionally empty at the start of the workshop.

For each exercise, copy only the skills needed for that role from `skills/` into
`.agents/skills/`. This lets participants compare agent behavior before and
after a focused skill set is available.

## Manager Deck Update

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/wb-do-file-reader .agents/skills/
cp -R skills/wb-powerpoint-updater .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Field Coordinator HFC Review

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/field-data-quality-hfc .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

## Research Assistant Analysis

```bash
mkdir -p .agents/skills
cp -R skills/agent-policy .agents/skills/
cp -R skills/reproducible-development-data-analysis .agents/skills/
cp -R skills/development-data-caution .agents/skills/
```

To reset between exercises:

```bash
rm -rf .agents/skills/*
```

