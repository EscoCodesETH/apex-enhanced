# APEX Enhanced Core Rules

## Quick Reference
- **Simple features**: Use lightweight mode (15 min planning)
- **Standard features**: Use balanced mode (20-30 min)
- **Critical features**: Use robust mode (45+ min)
- **Always**: TDD, quality gates, smart commits

## Core Principles

### 1. Adaptive Complexity
Analyze each feature and adapt the process:
- Simple UI changes → Lightweight process
- Business logic → Standard process  
- Payment/Security → Robust process

### 2. Test-Driven Development (Mandatory)
- Write tests FIRST, always
- Tests document behavior
- Implementation satisfies tests
- Coverage minimum: 85%

### 3. Quality Gates (Automatic)
After each implementation phase:
- Complexity check (cyclomatic < 10)
- Test coverage check (> 85%)
- Security scan for vulnerabilities
- Performance impact assessment

### 4. Smart Git Integration
- Atomic commits with clear messages
- Conventional commit format
- PR descriptions auto-generated
- Link issues automatically

### 5. Continuous Learning
- Remember patterns from codebase
- Learn from PR feedback
- Adapt to team preferences
- Improve suggestions over time

## Workflow Commands

### Start a Feature
```
/apex feature "description"
# or
"Let's implement [feature] using APEX Enhanced"
```

### Check Progress
```
/apex task
# or
"Show current APEX progress"
```

### Code Review
```
/apex review
# or
"Review this code using Sandi Metz principles"
```

### Create PR
```
/apex pr
# or  
"Create PR with APEX-style description"
```

## Implementation Flow

### Phase 1: Understand (5-15 min)
- Analyze requirements
- Ask clarifying questions
- Identify complexity level
- Choose appropriate mode

### Phase 2: Plan (5-30 min)
- Generate feature plan
- Define success criteria
- Break into tasks
- Get approval to proceed

### Phase 3: Test (10-20 min)
- Write comprehensive tests
- Cover edge cases
- Include integration tests
- Verify tests fail

### Phase 4: Implement (30-90 min)
- Code to pass tests
- Follow existing patterns
- Apply quality gates
- Refactor as needed

### Phase 5: Polish (10-20 min)
- Add error handling
- Improve UX
- Update documentation
- Performance optimization

### Phase 6: Ship (5-10 min)
- Create atomic commits
- Generate PR description
- Link related issues
- Request reviews

## Quality Standards

### Code Quality (Sandi Metz Rules)
- Classes < 100 lines
- Methods < 5 lines  
- Parameters ≤ 4
- Single responsibility

### Testing Standards
- Tests can actually fail
- Test behavior, not implementation
- Clear test descriptions
- No test coupling

### Documentation
- Self-documenting code preferred
- Comments for "why" not "what"
- API documentation for public methods
- Update README when needed

### Security
- Input validation always
- No secrets in code
- Security headers for web
- Principle of least privilege

## Complexity Modes

### Lightweight Mode
**When**: Simple features, UI tweaks, prototypes
**Process**: Minimal planning, basic tests, quick iteration
**Time**: 30-60 minutes total

### Standard Mode  
**When**: Most features, business logic, APIs
**Process**: Balanced planning, comprehensive tests, quality gates
**Time**: 2-4 hours total

### Robust Mode
**When**: Payments, auth, critical systems, data migrations  
**Process**: Detailed planning, security review, extensive tests
**Time**: 4-8 hours total

## Git Commit Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: feat, fix, docs, style, refactor, test, chore

Example:
```
feat(auth): add two-factor authentication

- Implement TOTP generation
- Add QR code for authenticator apps
- Include backup codes
- 96% test coverage

Closes #234
```

## PR Description Template

```markdown
## Summary
[What this PR does in 1-2 sentences]

## Changes
- ✅ [Major change 1]
- ✅ [Major change 2]
- ✅ [Test coverage: X%]

## Technical Details
[Any important implementation details]

## Testing
[How this was tested]

## Screenshots/Demo
[If applicable]

## Breaking Changes
[If any]

Closes #[issue]
```

## Remember

1. **Quality > Speed**: Better to do it right than do it twice
2. **Tests First**: TDD is not optional in APEX
3. **Human Judgment**: AI suggests, human decides
4. **Continuous Improvement**: Every PR makes us better

---

*APEX Enhanced: Where AI meets excellence in development*