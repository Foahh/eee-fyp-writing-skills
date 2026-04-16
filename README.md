# EEE FYP Writing Skills

Claude skills and Typst templates for Electrical and Electronic Engineering (EEE)
Final Year Project writing at HKU.

## Contents

```
eee-fyp-writing-assistant/   # Claude skill (single combined skill, three modes)
  SKILL.md                   #   - mode router + cross-cutting rules
  references/
    common-language-style.md #     style, citations, abbr escape rules (paper + report)
    paper-typst-syntax.md    #     ieee/lib.typ + akatable usage
    paper-structure.md       #     paper section frameworks
    paper-from-report.md     #     report-to-paper transformation guide
    report-typst-syntax.md   #     ilm/lib.typ usage
    report-structure.md      #     report section frameworks
    presentation-aea-touying.md #  Touying + Assertion-Evidence Approach

templates/                   # Typst templates (modified from upstream)
  ieee/lib.typ               #   technical paper, two-column IEEE style
  ilm/lib.typ                #   FYP final report
```

## The skill — three modes

| Mode | Artifact | Length | Template |
|---|---|---|---|
| `report` | FYP Final Report | ≤ 100 pages | `templates/ilm/lib.typ` |
| `paper` | Technical Paper | 9–12 pages, two-column | `templates/ieee/lib.typ` + `@preview/akatable` |
| `presentation` | Oral Presentation | ~10 min, 10–13 slides | Touying (`@preview/touying`) |

The skill auto-detects mode from cues in the user's content and confirms before
making structural changes.

## Installing the skill

Symlink or copy `eee-fyp-writing-assistant/` into the Claude skills directory for
your environment (e.g. `~/.claude/skills/` for Claude Code).

## Using the templates

Copy the relevant template into your project's `assets/` directory:

```bash
cp -r templates/ieee /path/to/your/paper/assets/   # for a paper
cp -r templates/ilm  /path/to/your/report/assets/  # for a report
```

Then import in your `.typ` source — see the "Template Header" section in the
corresponding reference (`paper-typst-syntax.md` or `report-typst-syntax.md`)
for the exact invocation, including `abbr` setup.
