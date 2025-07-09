# ⚙️ Configuring APEX Enhanced

Learn how to customize APEX Enhanced to match your project's needs and team preferences.

## Configuration Overview

APEX Enhanced can be configured at multiple levels:

1. **Project Level** - Tech stack, testing frameworks
2. **Complexity Rules** - When to use each mode
3. **Quality Standards** - Coverage thresholds, complexity limits
4. **Git Conventions** - Commit formats, PR templates
5. **AI Behavior** - How much autonomy to give AI

## Basic Configuration

### Project Settings

Add to your `apex.md`:

```markdown
## Project Configuration
STACK: TypeScript, React, Node.js, PostgreSQL
TESTING: Jest, React Testing Library, Cypress
STYLE: Prettier, ESLint (Airbnb config)
ARCHITECTURE: Clean Architecture, DDD
DEPLOYMENT: AWS, Docker, GitHub Actions
```

### Team Preferences

```markdown
## Team Conventions
NAMING: camelCase for functions, PascalCase for components
EXPORTS: Named exports preferred (no default exports)
IMPORTS: Absolute imports from @/
COMMENTS: JSDoc for public APIs only
PR_SIZE: Max 400 lines changed
```

## Complexity Configuration

### Default Complexity Rules

```markdown
## Complexity Thresholds
SIMPLE:
  - Time: < 2 hours
  - Examples: UI tweaks, copy changes, simple bugs
  - Process: Minimal planning, basic tests

STANDARD:
  - Time: 2-6 hours  
  - Examples: New features, API endpoints, refactors
  - Process: Full APEX workflow

COMPLEX:
  - Time: 6+ hours
  - Examples: Auth, payments, migrations, integrations
  - Process: Detailed planning, security review
```

### Custom Complexity Triggers

```markdown
## Complexity Keywords
ALWAYS_COMPLEX: payment, auth, security, migration, integration
ALWAYS_SIMPLE: typo, color, spacing, copy, label
NEEDS_REVIEW: delete, remove, deprecate, breaking
```

## Quality Standards

### Code Metrics

```markdown
## Quality Thresholds
TEST_COVERAGE: 85          # Minimum acceptable
COMPLEXITY_WARN: 10        # Cyclomatic complexity warning
COMPLEXITY_ERROR: 15       # Cyclomatic complexity error
METHOD_LENGTH: 20          # Maximum lines per method
FILE_LENGTH: 300          # Maximum lines per file
DUPLICATION: 3            # Max duplicate code blocks
```

### Sandi Metz Rules (Adjustable)

```markdown
## Sandi Metz Rules
CLASS_LENGTH: 100         # Default: 100 lines
METHOD_LENGTH: 5          # Default: 5 lines
PARAMS_COUNT: 4           # Default: 4 parameters
INSTANCE_VARS: 1          # Default: 1 per view

# To disable a rule, set to 0
# To make stricter, reduce the number
```

## Git Configuration

### Commit Conventions

```markdown
## Git Commit Rules
FORMAT: conventional       # conventional | semantic | custom
TYPES: feat,fix,docs,style,refactor,test,chore,perf
SCOPE_REQUIRED: false     # Require scope in commits
BREAKING_PREFIX: "!"      # Symbol for breaking changes
MAX_SUBJECT_LENGTH: 72    # Character limit
SIGN_COMMITS: false       # GPG signing
```

### Custom Commit Template

```markdown
## Custom Commit Format
<emoji> <type>(<scope>): <subject>

<body>

<footer>

EMOJI_MAP:
  feat: ✨
  fix: 🐛
  docs: 📚
  style: 💎
  refactor: 🔨
  test: 🧪
  chore: 📦
```

### PR Templates

```markdown
## PR Description Rules
REQUIRE_ISSUE_LINK: true
REQUIRE_TESTS: true
REQUIRE_SCREENSHOTS: true  # For UI changes
CHECKLIST_ITEMS:
  - Tests pass
  - Documentation updated
  - No console.logs
  - Accessibility checked
```

## AI Behavior Configuration

### Autonomy Levels

```markdown
## AI Autonomy
PLANNING: interactive      # interactive | autonomous | manual
TESTING: autonomous        # AI writes tests without asking
IMPLEMENTATION: guided     # guided | autonomous | manual
COMMITS: suggested         # suggested | autonomous | manual
REVIEWS: automatic         # automatic | on-request | disabled
```

### Decision Points

```markdown
## AI Decision Rules
AUTO_APPROVE:
  - Complexity < 3
  - Test coverage > 90%
  - No security implications

ALWAYS_ASK:
  - Database schema changes
  - API breaking changes
  - Dependency updates
  - Performance optimizations
```

## Environment-Specific Config

### Development vs Production

```yaml
# .apex-config.yml
environments:
  development:
    quality:
      test_coverage: 70    # Lower for rapid iteration
      allow_console: true
    git:
      allow_wip_commits: true
      
  production:
    quality:
      test_coverage: 90
      allow_console: false
    git:
      require_pr_review: true
      protected_branches: [main, production]
```

### Per-Feature Overrides

```markdown
## Feature-Specific Rules

FEATURE: payment-processing
  MIN_COVERAGE: 95
  REQUIRE_SECURITY_REVIEW: true
  MAX_COMPLEXITY: 5
  REQUIRE_INTEGRATION_TESTS: true

FEATURE: marketing-pages
  MIN_COVERAGE: 60
  ALLOW_INLINE_STYLES: true
  SKIP_ACCESSIBILITY: false
```

## Tool-Specific Configuration

### Claude Projects

```markdown
## Claude-Specific Settings
COMMAND_PREFIX: /apex      # or @ or !
MEMORY_ENABLED: true       # Remember patterns
AUTO_CONTEXT: true         # Load related files
```

### Cursor

```markdown
## Cursor Settings
AUTOCOMPLETE_STYLE: apex   # How to complete code
EXPLAIN_LEVEL: detailed    # How much to explain
ASSUME_KNOWLEDGE: senior   # junior | mid | senior
```

### GitHub Copilot

```markdown
## Copilot Settings
SUGGESTION_LENGTH: medium  # short | medium | long
COMMENT_STYLE: minimal     # minimal | detailed
TEST_FIRST: always        # always | prompt | never
```

## Advanced Configuration

### Custom Workflows

```markdown
## Custom Workflow: Hotfix
TRIGGER: "hotfix"
PROCESS:
  1. Minimal planning (5 min max)
  2. Fix with test
  3. Deploy immediately
  4. Full test suite after
COMMIT_PREFIX: "hotfix: "
BYPASS_REVIEW: true
```

### Integration Hooks

```markdown
## External Integrations
JIRA:
  ENABLED: true
  PROJECT_KEY: APEX
  AUTO_LINK: true
  
SLACK:
  ENABLED: true
  CHANNEL: #apex-prs
  NOTIFY_ON: [pr_created, pr_merged]
  
SENTRY:
  ENABLED: true
  PROJECT: apex-app
  AUTO_TAG: true
```

### Performance Budgets

```markdown
## Performance Requirements
BUNDLE_SIZE:
  WARNING: 500KB
  ERROR: 1MB
  
LOAD_TIME:
  WARNING: 3s
  ERROR: 5s
  
API_RESPONSE:
  WARNING: 200ms
  ERROR: 1000ms
```

## Configuration Validation

APEX can validate your configuration:

```bash
# In your AI assistant
"Validate my APEX configuration"

# Response
✅ Stack configuration valid
⚠️ Test coverage (70%) below recommendation (85%)
✅ Git conventions properly formatted
❌ Missing required: ARCHITECTURE setting
```

## Best Practices

1. **Start with Defaults**
   - Use standard configuration
   - Customize only what's needed

2. **Document Decisions**
   ```markdown
   ## Configuration Rationale
   - Lower coverage for UI (70%): Rapid iteration priority
   - Strict complexity (5): Maintainability focus
   ```

3. **Version Control Config**
   - Commit configuration changes
   - Document why in commit message

4. **Team Agreement**
   - Discuss changes with team
   - Update gradually

5. **Regular Review**
   - Review config quarterly
   - Adjust based on pain points

## Troubleshooting

### Config Not Loading

1. Check file location
2. Verify syntax (YAML/Markdown)
3. Restart AI tool
4. Clear AI cache/memory

### Conflicts

If config conflicts with code:
```markdown
## Resolution Order
1. Inline code comments (highest priority)
2. Feature-specific config
3. Project config
4. APEX defaults (lowest priority)
```

## Examples

### Startup Config (Move Fast)

```markdown
## Startup Configuration
TEST_COVERAGE: 60
COMPLEXITY_LIMIT: 15
PR_SIZE_LIMIT: 1000
PLANNING_DEPTH: minimal
DEPLOY_CHECKS: basic
```

### Enterprise Config (Safety First)

```markdown
## Enterprise Configuration
TEST_COVERAGE: 95
COMPLEXITY_LIMIT: 8
PR_SIZE_LIMIT: 200
PLANNING_DEPTH: comprehensive
DEPLOY_CHECKS: exhaustive
REQUIRE_SECURITY_REVIEW: true
REQUIRE_PERFORMANCE_REVIEW: true
```

## Next Steps

1. Start with default configuration
2. Identify your team's pain points
3. Adjust one setting at a time
4. Monitor the impact
5. Iterate based on results

---

Remember: The best configuration is the one your team actually follows!