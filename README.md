# /team-develop — Virtual IT Team Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A skill that assembles a virtual IT team to take a feature from idea to implementation. Each team member is a specialized subagent with a focused role, working as a pipeline with user approval at every stage.

**Supported platforms:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | [OpenCode](https://opencode.ai) | [OpenAI Codex](https://developers.openai.com/codex)

> **[Русская версия ниже / Russian version below](#team-develop--виртуальная-it-команда)**

---

## Quick Start

### Claude Code / OpenCode

```bash
# One-line install (Claude Code + OpenCode)
curl -fsSL https://raw.githubusercontent.com/Aligery/ai-team-develop-skill/main/install.sh | bash
```

Then start a new session and type:

```
/team-develop
```

### OpenAI Codex

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Copy skill files to user-level Codex skills directory
mkdir -p ~/.agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* ~/.agents/skills/team-develop/
```

Then start a Codex session and type:

```
$team-develop
```

## Team Roles

| Role | Responsibility |
|------|---------------|
| **Team Lead** | You (AI in main conversation). Orchestrates the pipeline, delegates work, never writes code. |
| **Product Engineer** | Defines product value, user stories, acceptance criteria. Cuts scope ruthlessly (YAGNI). |
| **Analyst** | Decomposes requirements into bite-sized implementation tasks with exact file paths and TDD steps. |
| **UX Designer** | Validates user flows, defines UI states, adds accessibility and interaction criteria. |
| **QA Engineer** | Defines Definition of Done per task, writes test scenarios (Given/When/Then). |
| **Software Engineer** | Implements code following TDD. Commits after each task. Builds exactly what's specified. |

## Pipeline

```
/team-develop (or $team-develop in Codex)
    |
    Phase 0: Discovery (brainstorming) ── CHECKPOINT
    |
    Phase 1: Product Engineer ── CHECKPOINT
    |
    Phase 2: Analyst ── CHECKPOINT
    |
    Phase 3: UX Designer ── CHECKPOINT
    |
    Phase 4: QA Engineer ── CHECKPOINT
    |
    Phase 5: Software Engineer ── CHECKPOINT (per task)
    |
    Phase 6: QA + UX Validation ── CHECKPOINT
    |
    Done!
```

Every checkpoint presents the stage output to you and waits for approval. You can approve, request changes, or skip any stage.

## Installation

### Automatic (Claude Code + OpenCode)

```bash
curl -fsSL https://raw.githubusercontent.com/Aligery/ai-team-develop-skill/main/install.sh | bash
```

The script auto-detects your platform (Claude Code, OpenCode, or both) and installs skill files and slash commands to the correct locations.

Options:

```bash
# Install for Claude Code only
./install.sh --claude

# Install for OpenCode only
./install.sh --opencode

# Install for both (default)
./install.sh

# Uninstall
./install.sh --uninstall
```

### Manual: Claude Code

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Copy skill files
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Copy slash command
mkdir -p ~/.claude/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md
```

### Manual: OpenCode

OpenCode discovers skills from `~/.claude/skills/` automatically. The only difference is the command location:

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Copy skill files (shared path with Claude Code)
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Copy slash command (OpenCode-specific path)
mkdir -p ~/.config/opencode/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Manual: OpenAI Codex

Codex discovers skills from `~/.agents/skills/` (user-level) or `.agents/skills/` (project-level). The SKILL.md format is already compatible — no adaptation needed.

#### User-level (available in all projects)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Copy skill files
mkdir -p ~/.agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* ~/.agents/skills/team-develop/
```

#### Project-level (available only in this repo)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Copy skill files into your project
mkdir -p .agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* .agents/skills/team-develop/
```

> **Note:** Codex does not use slash commands (`/`). Skills are invoked via `$team-develop` or activated implicitly when the task matches the skill description. There is no need to copy files from the `commands/` directory.

#### Verify installation

Start a new Codex session and type:

```
$team-develop
```

The skill should activate and begin the discovery phase.

### Symlink (for development)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git ~/team-develop-skill

# Skill — Claude Code / OpenCode
ln -s ~/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Skill — Codex
ln -s ~/team-develop-skill/skills/team-develop ~/.agents/skills/team-develop

# Command — Claude Code
ln -s ~/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md

# Command — OpenCode
ln -s ~/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Verify installation

Start a new session and type:

| Platform | Command |
|----------|---------|
| Claude Code | `/team-develop` |
| OpenCode | `/team-develop` |
| Codex | `$team-develop` |

You should see the skill activate and begin the discovery phase.

## File Structure

```
team-develop-skill/
├── install.sh                                 # Automatic installer
├── README.md                                  # Documentation (EN + RU)
├── commands/
│   └── team-develop.md                        # Slash command entry point (Claude Code / OpenCode)
└── skills/
    └── team-develop/
        ├── SKILL.md                           # Main orchestration logic
        ├── role-product-engineer.md           # Product Engineer prompt
        ├── role-analyst.md                    # Analyst prompt
        ├── role-ux-designer.md                # UX Designer prompt
        ├── role-qa-engineer.md                # QA Engineer prompt
        ├── role-software-engineer.md          # Software Engineer prompt
        └── role-validators.md                 # QA + UX validation prompts
```

## Platform Compatibility

| Feature | Claude Code | OpenCode | Codex |
|---------|-------------|----------|-------|
| Skill discovery | `~/.claude/skills/` | `~/.claude/skills/` | `~/.agents/skills/` |
| Slash commands | `~/.claude/commands/` | `~/.config/opencode/commands/` | N/A |
| Skill invocation | `/team-develop` | `/team-develop` | `$team-develop` |
| Implicit activation | Yes | Yes | Yes |
| SKILL.md format | `name` + `description` | `name` + `description` | `name` + `description` |
| Subagents (Task tool) | Yes | Yes | Yes |

## Artifacts

During execution, the skill creates planning documents in your project:

```
docs/plans/
├── YYYY-MM-DD-<feature>-design.md             # Brainstorming output
├── YYYY-MM-DD-<feature>-product-spec.md       # User stories & acceptance criteria
├── YYYY-MM-DD-<feature>-tasks.md              # Implementation plan
├── YYYY-MM-DD-<feature>-ux-criteria.md        # UX requirements
├── YYYY-MM-DD-<feature>-test-plan.md          # Test scenarios & DoD
└── YYYY-MM-DD-<feature>-validation.md         # Final validation report
```

## Recommended Skills

The team agents auto-discover and apply available skills. For best results, install:

- [superpowers](https://github.com/obra/superpowers) — provides brainstorming, writing-plans, TDD, verification, debugging
- [web-design-guidelines](https://github.com/vercel-labs/agent-skills) — UX Designer uses this for validation (`npx skills add vercel-labs/agent-skills --skill web-design-guidelines`)

## Customization

Each role prompt is a separate markdown file. To customize a role:

1. Edit the corresponding `role-*.md` file
2. Modify the output format, instructions, or quality checklist
3. The orchestration (SKILL.md) stays unchanged

To add a new role:

1. Create `role-new-role.md` following the same template structure
2. Add the phase to SKILL.md's pipeline
3. Update the checkpoint flow

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [OpenCode](https://opencode.ai), or [OpenAI Codex](https://developers.openai.com/codex) CLI
- No additional dependencies — the skill uses only built-in tools (Task, Read, Write, Glob)

## License

MIT

---

# /team-develop — Виртуальная IT-команда

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Скилл, который собирает виртуальную IT-команду для проектирования и реализации фичи от идеи до готового кода. Каждый участник команды — специализированный субагент с фокусной ролью. Команда работает как конвейер с утверждением пользователем на каждом этапе.

**Поддерживаемые платформы:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | [OpenCode](https://opencode.ai) | [OpenAI Codex](https://developers.openai.com/codex)

> **[English version above / Английская версия выше](#team-develop--virtual-it-team-skill)**

## Быстрый старт

### Claude Code / OpenCode

```bash
# Установка одной командой (Claude Code + OpenCode)
curl -fsSL https://raw.githubusercontent.com/Aligery/ai-team-develop-skill/main/install.sh | bash
```

Затем начните новую сессию и введите:

```
/team-develop
```

### OpenAI Codex

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла в пользовательскую директорию Codex
mkdir -p ~/.agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* ~/.agents/skills/team-develop/
```

Затем начните сессию Codex и введите:

```
$team-develop
```

## Роли команды

| Роль | Ответственность |
|------|----------------|
| **Тимлид** | Вы (AI в основной сессии). Оркестрирует конвейер, делегирует работу, никогда не пишет код сам. |
| **Продакт-инженер** | Определяет продуктовую ценность, пользовательские истории, критерии приемки. Безжалостно режет скоуп (YAGNI). |
| **Аналитик** | Декомпозирует требования в мелкие задачи с точными путями файлов и TDD-шагами. |
| **UX-дизайнер** | Валидирует пользовательские потоки, определяет состояния UI, добавляет критерии доступности и взаимодействия. |
| **QA-инженер** | Определяет Definition of Done для каждой задачи, пишет тест-сценарии (Given/When/Then). |
| **Разработчик** | Реализует код по TDD. Коммит после каждой задачи. Строит ровно то, что указано в спецификации. |

## Конвейер

```
/team-develop (или $team-develop в Codex)
    |
    Фаза 0: Исследование (брейншторм) ── ЧЕКПОЙНТ
    |
    Фаза 1: Продакт-инженер ── ЧЕКПОЙНТ
    |
    Фаза 2: Аналитик ── ЧЕКПОЙНТ
    |
    Фаза 3: UX-дизайнер ── ЧЕКПОЙНТ
    |
    Фаза 4: QA-инженер ── ЧЕКПОЙНТ
    |
    Фаза 5: Разработчик ── ЧЕКПОЙНТ (на каждую задачу)
    |
    Фаза 6: QA + UX валидация ── ЧЕКПОЙНТ
    |
    Готово!
```

На каждом чекпойнте результат этапа показывается вам. Можно утвердить, запросить изменения или пропустить этап.

## Установка

### Автоматическая (Claude Code + OpenCode)

```bash
curl -fsSL https://raw.githubusercontent.com/Aligery/ai-team-develop-skill/main/install.sh | bash
```

Скрипт автоматически определяет вашу платформу (Claude Code, OpenCode или обе) и устанавливает файлы скиллов и команд в нужные директории.

Опции:

```bash
# Установить только для Claude Code
./install.sh --claude

# Установить только для OpenCode
./install.sh --opencode

# Установить для обоих (по умолчанию)
./install.sh

# Удалить
./install.sh --uninstall
```

### Ручная: Claude Code

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Копируем slash-команду
mkdir -p ~/.claude/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md
```

### Ручная: OpenCode

OpenCode автоматически находит скиллы в `~/.claude/skills/`. Единственное отличие — путь для команд:

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла (общий путь с Claude Code)
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Копируем slash-команду (путь для OpenCode)
mkdir -p ~/.config/opencode/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Ручная: OpenAI Codex

Codex находит скиллы в `~/.agents/skills/` (пользовательский уровень) или `.agents/skills/` (уровень проекта). Формат SKILL.md уже совместим — адаптация не требуется.

#### Пользовательский уровень (доступен во всех проектах)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла
mkdir -p ~/.agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* ~/.agents/skills/team-develop/
```

#### Уровень проекта (доступен только в этом репозитории)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла в проект
mkdir -p .agents/skills/team-develop
cp /tmp/team-develop-skill/skills/team-develop/* .agents/skills/team-develop/
```

> **Примечание:** Codex не использует slash-команды (`/`). Скиллы вызываются через `$team-develop` или активируются неявно, когда задача совпадает с описанием скилла. Копировать файлы из директории `commands/` не нужно.

#### Проверка установки

Запустите новую сессию Codex и введите:

```
$team-develop
```

Скилл должен активироваться и начать фазу исследования.

### Симлинк (для разработки)

```bash
git clone https://github.com/Aligery/ai-team-develop-skill.git ~/team-develop-skill

# Скилл — Claude Code / OpenCode
ln -s ~/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Скилл — Codex
ln -s ~/team-develop-skill/skills/team-develop ~/.agents/skills/team-develop

# Команда — Claude Code
ln -s ~/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md

# Команда — OpenCode
ln -s ~/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Проверка установки

Запустите новую сессию и введите:

| Платформа | Команда |
|-----------|---------|
| Claude Code | `/team-develop` |
| OpenCode | `/team-develop` |
| Codex | `$team-develop` |

Скилл должен активироваться и начать фазу исследования.

## Структура файлов

```
team-develop-skill/
├── install.sh                                 # Автоматический установщик
├── README.md                                  # Документация (EN + RU)
├── commands/
│   └── team-develop.md                        # Slash-команда (Claude Code / OpenCode)
└── skills/
    └── team-develop/
        ├── SKILL.md                           # Основная логика оркестрации
        ├── role-product-engineer.md           # Промпт Продакт-инженера
        ├── role-analyst.md                    # Промпт Аналитика
        ├── role-ux-designer.md                # Промпт UX-дизайнера
        ├── role-qa-engineer.md                # Промпт QA-инженера
        ├── role-software-engineer.md          # Промпт Разработчика
        └── role-validators.md                 # Промпты QA + UX валидации
```

## Совместимость платформ

| Возможность | Claude Code | OpenCode | Codex |
|-------------|-------------|----------|-------|
| Обнаружение скиллов | `~/.claude/skills/` | `~/.claude/skills/` | `~/.agents/skills/` |
| Slash-команды | `~/.claude/commands/` | `~/.config/opencode/commands/` | Нет |
| Вызов скилла | `/team-develop` | `/team-develop` | `$team-develop` |
| Неявная активация | Да | Да | Да |
| Формат SKILL.md | `name` + `description` | `name` + `description` | `name` + `description` |
| Субагенты (Task) | Да | Да | Да |

## Артефакты

Во время работы скилл создает документы планирования в вашем проекте:

```
docs/plans/
├── YYYY-MM-DD-<feature>-design.md             # Результат брейншторма
├── YYYY-MM-DD-<feature>-product-spec.md       # Пользовательские истории и критерии
├── YYYY-MM-DD-<feature>-tasks.md              # План реализации
├── YYYY-MM-DD-<feature>-ux-criteria.md        # UX-требования
├── YYYY-MM-DD-<feature>-test-plan.md          # Тест-сценарии и DoD
└── YYYY-MM-DD-<feature>-validation.md         # Финальный отчет валидации
```

## Рекомендуемые скиллы

Агенты автоматически находят и применяют доступные скиллы. Для лучших результатов установите:

- [superpowers](https://github.com/obra/superpowers) — брейншторм, планы, TDD, верификация, дебаг
- [web-design-guidelines](https://github.com/vercel-labs/agent-skills) — UX-дизайнер использует для валидации (`npx skills add vercel-labs/agent-skills --skill web-design-guidelines`)

## Кастомизация

Каждый промпт роли — отдельный markdown-файл. Чтобы настроить роль:

1. Отредактируйте соответствующий файл `role-*.md`
2. Измените формат вывода, инструкции или чеклист качества
3. Оркестрация (SKILL.md) остается без изменений

Чтобы добавить новую роль:

1. Создайте `role-new-role.md` по тому же шаблону
2. Добавьте фазу в конвейер SKILL.md
3. Обновите поток чекпойнтов

## Требования

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [OpenCode](https://opencode.ai) или [OpenAI Codex](https://developers.openai.com/codex) CLI
- Никаких дополнительных зависимостей — скилл использует только встроенные инструменты (Task, Read, Write, Glob)

## Лицензия

MIT
