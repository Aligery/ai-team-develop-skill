# /team-develop — Виртуальная IT-команда

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Скилл, который собирает виртуальную IT-команду для проектирования и реализации фичи от идеи до готового кода. Каждый участник команды — специализированный субагент с фокусной ролью. Команда работает как конвейер с утверждением пользователем на каждом этапе.

**Поддерживаемые платформы:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | [OpenCode](https://opencode.ai)

> **[English version](README.md)**

## Быстрый старт

```bash
# Установка одной командой (Claude Code + OpenCode)
curl -fsSL https://raw.githubusercontent.com/anthropics/team-develop-skill/main/install.sh | bash
```

Или клонируйте и запустите локально:

```bash
git clone https://github.com/anthropics/team-develop-skill.git
cd team-develop-skill
./install.sh
```

Затем начните новую сессию и введите:

```
/team-develop
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
/team-develop
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

### Автоматическая (рекомендуется)

```bash
curl -fsSL https://raw.githubusercontent.com/anthropics/team-develop-skill/main/install.sh | bash
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
git clone https://github.com/anthropics/team-develop-skill.git /tmp/team-develop-skill

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
git clone https://github.com/anthropics/team-develop-skill.git /tmp/team-develop-skill

# Копируем файлы скилла (общий путь с Claude Code)
mkdir -p ~/.claude/skills
cp -r /tmp/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Копируем slash-команду (путь для OpenCode)
mkdir -p ~/.config/opencode/commands
cp /tmp/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Симлинк (для разработки)

```bash
git clone https://github.com/anthropics/team-develop-skill.git ~/team-develop-skill

# Скилл (работает и для Claude Code, и для OpenCode)
ln -s ~/team-develop-skill/skills/team-develop ~/.claude/skills/team-develop

# Команда — Claude Code
ln -s ~/team-develop-skill/commands/team-develop.md ~/.claude/commands/team-develop.md

# Команда — OpenCode
ln -s ~/team-develop-skill/commands/team-develop.md ~/.config/opencode/commands/team-develop.md
```

### Проверка установки

Запустите новую сессию (Claude Code или OpenCode) и введите:

```
/team-develop
```

Скилл должен активироваться и начать фазу исследования.

## Структура файлов

```
team-develop-skill/
├── install.sh                                 # Автоматический установщик
├── README.md                                  # Документация (English)
├── README_RU.md                               # Документация (Русский)
├── commands/
│   └── team-develop.md                        # Точка входа slash-команды
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

- [superpowers](https://github.com/anthropics/claude-code-superpowers) — брейншторм, планы, TDD, верификация, дебаг
- [web-design-guidelines](https://github.com/anthropics/claude-code-web-design-guidelines) — UX-дизайнер использует для валидации

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

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) или [OpenCode](https://opencode.ai) CLI
- Никаких дополнительных зависимостей — скилл использует только встроенные инструменты (Task, Read, Write, Glob)

## Лицензия

MIT
