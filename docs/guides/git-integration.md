# 🔄 Git Integration with APEX

Master Git workflows with APEX Enhanced's intelligent version control integration.

## APEX Git Philosophy

APEX treats Git as a communication tool:
- **Atomic Commits**: Each commit does one thing
- **Meaningful Messages**: Tell the story of why
- **Clean History**: Easy to understand and debug
- **Smart Branching**: Organized development flow

## Intelligent Commit Creation

### APEX Analyzes Your Changes

```bash
You: "APEX, help me commit these changes"

AI: "I've analyzed your changes:

📁 Files Modified:
- src/components/UserProfile.tsx (45 lines)
- src/api/users.ts (12 lines)
- src/types/user.ts (5 lines)
- tests/userProfile.test.tsx (30 lines)

I suggest 3 atomic commits:

1️⃣ feat(types): add avatar URL to user type
2️⃣ feat(api): add endpoint for avatar upload
3️⃣ feat(profile): implement avatar upload UI

Would you like me to create these commits?"
```

### Atomic Commit Examples

```bash
# APEX creates focused commits
git add src/types/user.ts
git commit -m "feat(types): add avatar URL to user type

- Add optional avatarUrl field
- Add avatarUpdatedAt timestamp
- Update UserProfile interface

Preparing for avatar upload feature"

git add src/api/users.ts tests/api/users.test.ts
git commit -m "feat(api): add endpoint for avatar upload

- POST /api/users/:id/avatar endpoint
- Validates image format and size
- Returns presigned S3 URL
- Includes comprehensive tests

Part of avatar feature implementation"

git add src/components/UserProfile.tsx tests/userProfile.test.tsx
git commit -m "feat(profile): implement avatar upload UI

- Add AvatarUpload component
- Show preview before upload
- Loading and error states
- Accessibility compliant

Closes #234"
```

## Conventional Commits

APEX follows conventional commit format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types and Examples

```bash
# Feature
feat(auth): add two-factor authentication

# Bug Fix
fix(cart): prevent negative quantities in cart items

# Documentation
docs(api): update authentication endpoints

# Style (formatting, missing semicolons, etc)
style(button): fix inconsistent padding

# Refactoring
refactor(user-service): extract validation logic

# Performance
perf(search): optimize query with database index

# Test
test(checkout): add edge cases for payment flow

# Build
build(deps): update React to v18.2.0

# CI
ci(github): add automated security scanning

# Chore (maintenance)
chore(scripts): update deployment script
```

## Branch Management

### APEX Branch Naming

```bash
# Feature branches
feature/user-avatar-upload
feature/payment-stripe-integration

# Bug fixes
fix/login-validation-error
fix/cart-total-calculation

# Hotfixes (urgent production fixes)
hotfix/payment-processing-timeout

# Experiments
experiment/new-search-algorithm

# Refactoring
refactor/extract-auth-service
```

### Branch Workflow

```bash
# APEX guides branch creation
You: "I need to implement user search"

AI: "I'll help you set up the branch:

git checkout main
git pull origin main
git checkout -b feature/user-search

Branch 'feature/user-search' created and checked out.
Ready to start implementation!"
```

## Interactive Rebasing

### Cleaning Up History

```bash
You: "APEX, help me clean up my commits before PR"

AI: "I see 8 commits on this branch. Let me analyze...

Current commits:
1. WIP: started user search
2. add search component
3. fix typo
4. implement search logic
5. oops, forgot to add file
6. add tests
7. fix test
8. update documentation

I'll help you create a clean history:

git rebase -i main

# APEX suggests this reorganization:
pick 1234567 feat(search): add user search component
squash 2345678 implement search logic
squash 3456789 add search tests
pick 4567890 docs(search): add search documentation

This will result in 2 clean commits. Proceed?"
```

### Rewriting Commit Messages

```bash
# During rebase, APEX helps write better messages
# Original: "fix stuff"
# APEX suggestion:
fix(search): handle special characters in search queries

- Escape regex special characters
- Add test cases for symbols
- Prevent query injection

Fixes #456
```

## Handling Merge Conflicts

### APEX Conflict Resolution

```bash
You: "Help! Merge conflict in UserService.ts"

AI: "I'll help you resolve this conflict. Let me analyze...

🔍 Conflict Analysis:
- Your branch: Added updateUserAvatar() method
- Main branch: Refactored updateUser() method

The conflict is in the same area but different functionality.
Here's my suggested resolution:

<<<<<<< HEAD (your changes)
  async updateUserAvatar(userId: string, avatarUrl: string) {
    const user = await this.findById(userId);
    if (!user) throw new NotFoundError('User not found');
    
    return this.userRepository.update(userId, {
      avatarUrl,
      avatarUpdatedAt: new Date()
    });
  }
=======
  async updateUser(userId: string, updates: Partial<User>) {
    const user = await this.findById(userId);
    if (!user) throw new NotFoundError('User not found');
    
    // Validate updates
    const validated = await this.validateUserUpdates(updates);
    
    return this.userRepository.update(userId, {
      ...validated,
      updatedAt: new Date()
    });
  }
>>>>>>> main

Resolution: Keep both methods as they serve different purposes:

  async updateUser(userId: string, updates: Partial<User>) {
    const user = await this.findById(userId);
    if (!user) throw new NotFoundError('User not found');
    
    // Validate updates
    const validated = await this.validateUserUpdates(updates);
    
    return this.userRepository.update(userId, {
      ...validated,
      updatedAt: new Date()
    });
  }

  async updateUserAvatar(userId: string, avatarUrl: string) {
    const user = await this.findById(userId);
    if (!user) throw new NotFoundError('User not found');
    
    return this.userRepository.update(userId, {
      avatarUrl,
      avatarUpdatedAt: new Date()
    });
  }

After resolving:
git add src/services/UserService.ts
git commit -m 'merge: resolve conflict between avatar and user update methods'
"
```

## Git Hooks with APEX

### Pre-commit Hook

```bash
#!/bin/sh
# .git/hooks/pre-commit

# Run APEX quality checks
echo "🔍 APEX: Running pre-commit checks..."

# Check for console.logs
if grep -r "console\.log" src/; then
  echo "❌ APEX: Found console.log statements. Please remove them."
  exit 1
fi

# Run tests for changed files
npm test -- --findRelatedTests $(git diff --cached --name-only)

# Check commit message format
commit_regex='^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?: .{1,50}'
if ! grep -qE "$commit_regex" "$1"; then
  echo "❌ APEX: Commit message doesn't follow conventional format"
  echo "Format: <type>(<scope>): <subject>"
  exit 1
fi

echo "✅ APEX: All checks passed!"
```

### Commit Message Template

```bash
# .gitmessage

# <type>(<scope>): <subject>
#
# <body>
#
# <footer>

# Type: feat, fix, docs, style, refactor, perf, test, build, ci, chore
# Scope: component or area affected
# Subject: imperative mood, don't capitalize, no period
# Body: explain what and why vs. how
# Footer: breaking changes, issue references

# Example:
# feat(auth): add remember me functionality
#
# Add checkbox to login form that sets a persistent cookie
# when checked. Cookie expires after 30 days of inactivity.
#
# Closes #123
```

## Advanced Git Workflows

### Feature Flags with Git

```bash
# APEX manages feature flags in commits
git commit -m "feat(search): add advanced search (behind flag)

- Implement advanced search UI and logic
- Hidden behind ADVANCED_SEARCH feature flag
- Set flag in .env to enable

Feature flag: ADVANCED_SEARCH=true
Documentation: docs/features/advanced-search.md"
```

### Stacked PRs

```bash
You: "I need to implement a large feature in pieces"

AI: "I'll help you create stacked PRs for easier review:

# Base branch for the feature
git checkout -b feature/payment-system

# Stack 1: Data models
git checkout -b feature/payment-system-models
# ... implement models ...
git push origin feature/payment-system-models
# Create PR: payment-system-models → payment-system

# Stack 2: API endpoints (depends on models)
git checkout -b feature/payment-system-api
# ... implement API ...
git push origin feature/payment-system-api
# Create PR: payment-system-api → payment-system-models

# Stack 3: UI (depends on API)
git checkout -b feature/payment-system-ui
# ... implement UI ...
git push origin feature/payment-system-ui
# Create PR: payment-system-ui → payment-system-api

This creates reviewable chunks:
PR #1: Models (200 lines)
PR #2: API (300 lines)
PR #3: UI (400 lines)

Instead of one 900-line PR!"
```

### Cherry-picking Fixes

```bash
You: "I need to apply this bug fix to multiple branches"

AI: "I'll help you cherry-pick safely:

# First, identify the commit
git log --oneline | grep "fix.*validation"
abc123 fix(form): correct email validation regex

# Cherry-pick to release branch
git checkout release/v2.1
git cherry-pick abc123

# If conflicts occur, I'll help resolve them
# Then update commit message for context
git commit --amend -m "fix(form): correct email validation regex

Cherry-picked from main (abc123)
Original PR: #456

Fixes email validation allowing spaces"

# Repeat for other branches
git checkout release/v2.0
git cherry-pick abc123"
```

## Git Aliases for APEX Workflow

```bash
# Add to ~/.gitconfig
[alias]
    # APEX-style commits
    feat = "!f() { git commit -m \"feat($1): $2\" -m \"$3\"; }; f"
    fix = "!f() { git commit -m \"fix($1): $2\" -m \"$3\"; }; f"
    
    # Quick status
    st = status -sb
    
    # Pretty log
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
    
    # Show files in last commit
    last = show --name-only
    
    # Undo last commit (keep changes)
    undo = reset HEAD~1 --soft
    
    # Amend without editing message
    amend = commit --amend --no-edit
    
    # Interactive rebase
    cleanup = "!git rebase -i $(git merge-base HEAD main)"

# Usage:
git feat auth "add login endpoint" "Implements POST /api/login with JWT"
git fix cart "prevent negative quantities" "Validates quantity > 0"
```

## GitHub Integration

### PR Templates with APEX

```markdown
<!-- .github/pull_request_template.md -->
## Summary
<!-- Brief description of changes -->

## Type of Change
- [ ] 🐛 Bug fix (non-breaking change which fixes an issue)
- [ ] ✨ New feature (non-breaking change which adds functionality)
- [ ] 💥 Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] 📚 Documentation update

## Changes Made
<!-- APEX auto-fills this section -->
- 
- 
- 

## Testing
<!-- How has this been tested? -->
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where needed
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective
- [ ] New and existing unit tests pass locally

## Screenshots (if applicable)
<!-- Add screenshots here -->

## Performance Impact
<!-- Describe any performance implications -->

## Security Considerations
<!-- Note any security implications -->

## Related Issues
Closes #
```

### Automating PR Creation

```bash
You: "Create PR for this feature"

AI: "I'll create a comprehensive PR:

gh pr create \
  --title "feat(search): add real-time user search" \
  --body "## Summary
This PR implements real-time user search with debouncing and caching.

## Changes Made
- Add SearchBar component with 300ms debounce
- Implement search API with Redis caching
- Add keyboard navigation for results
- Include comprehensive test coverage (94%)

## Technical Details
- **Debouncing**: Prevents API spam during typing
- **Caching**: 5-minute TTL for identical queries
- **Accessibility**: Full keyboard and screen reader support

## Performance
- Search response: <100ms (cached), <300ms (uncached)
- Bundle size impact: +2.1KB gzipped

## Testing
- ✅ Unit tests: 94% coverage
- ✅ E2E tests: All user flows
- ✅ Manual testing: Chrome, Firefox, Safari
- ✅ Accessibility: WCAG 2.1 AA compliant

## Screenshots
![Search Demo](./docs/images/search-demo.gif)

## Security
- Input sanitization prevents XSS
- Rate limiting: 30 requests/minute

Closes #234" \
  --assignee @me \
  --label "enhancement,frontend" \
  --milestone "v2.1.0"
```

## Troubleshooting Git Issues

### Recovering Lost Commits

```bash
You: "I accidentally reset --hard and lost commits!"

AI: "Don't panic! Git keeps a reflog. Let's recover:

# See all recent operations
git reflog

# You'll see something like:
abc123 HEAD@{0}: reset: moving to HEAD~3
def456 HEAD@{1}: commit: feat(search): add tests
ghi789 HEAD@{2}: commit: feat(search): implement logic

# Recover to before the reset
git reset --hard HEAD@{1}

# Or cherry-pick specific commits
git cherry-pick def456

Your commits are recovered! 
Pro tip: Use 'git reset --soft' next time to keep changes."
```

### Fixing Wrong Branch

```bash
You: "I committed to main instead of my feature branch!"

AI: "I'll help you move those commits:

# First, note the commits on main
git log --oneline -3
abc123 feat: new feature (oops!)
def456 fix: related fix (oops!)
ghi789 Last legitimate main commit

# Reset main to the correct commit
git reset --hard ghi789

# Switch to your feature branch
git checkout feature/my-feature

# Cherry-pick your commits
git cherry-pick abc123 def456

Done! Your commits are now on the feature branch
and main is clean."
```

## Git Best Practices with APEX

### 1. Commit Early and Often

```bash
# APEX encourages frequent commits
"Implemented basic structure" ✅
"Added validation" ✅
"Added tests" ✅

# Not one giant commit
"Implemented entire feature" ❌
```

### 2. Pull Before Push

```bash
# APEX reminder before pushing
AI: "Before pushing, let's sync with remote:

git pull --rebase origin main
# Resolve any conflicts
git push origin feature/your-branch"
```

### 3. Never Force Push Main

```bash
# APEX prevents dangerous operations
You: "git push --force origin main"

AI: "⚠️ DANGER: Force pushing to main can break the repository
for all team members. 

If you really need to fix main, consider:
1. Creating a fix commit instead
2. Discussing with the team first
3. Using 'git revert' for public commits

Are you sure you want to proceed?"
```

### 4. Use Git Stash Effectively

```bash
You: "I need to switch branches but have uncommitted changes"

AI: "I'll help you stash properly:

# Stash with a descriptive message
git stash push -m 'WIP: user search component'

# See all stashes
git stash list
stash@{0}: On feature/search: WIP: user search component
stash@{1}: On fix/validation: debugging form issue

# Switch branches
git checkout fix/urgent-bug

# Later, restore your work
git checkout feature/search
git stash pop stash@{0}"
```

## Integrating with CI/CD

### Automated Checks on Push

```yaml
# .github/workflows/pr-checks.yml
name: PR Checks

on:
  pull_request:
    types: [opened, synchronize]

jobs:
  commit-lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
          
      - name: Check commit messages
        run: |
          commits=$(git log --format=%s origin/main..HEAD)
          pattern='^(feat|fix|docs|style|refactor|perf|test|build|ci|chore)(\(.+\))?: .+'
          
          while IFS= read -r commit; do
            if ! echo "$commit" | grep -qE "$pattern"; then
              echo "Invalid commit message: $commit"
              echo "Expected format: type(scope): subject"
              exit 1
            fi
          done <<< "$commits"
```

## Next Steps

- Master [PR Reviews](pr-reviews.md)
- Learn [Troubleshooting](troubleshooting.md)
- Explore [Team Workflows](../workflows/team-collaboration.md)

---

Remember: Good Git hygiene is about communication. Each commit tells a story, and APEX helps you tell it clearly!