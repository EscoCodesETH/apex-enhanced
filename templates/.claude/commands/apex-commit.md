# APEX Commit Command

Create intelligent, atomic commits with meaningful messages and PR descriptions.

## Commit Process

1. **Analyze changes** to group logically
2. **Create atomic commits** with clear purpose
3. **Write descriptive messages** following conventions
4. **Generate PR description** with full context
5. **Link issues** automatically

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only
- **style**: Formatting, missing semicolons, etc
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **test**: Adding missing tests
- **chore**: Maintenance tasks
- **perf**: Performance improvements

### Examples

```bash
# Feature commit
git commit -m "feat(auth): add two-factor authentication

- Implement TOTP generation and validation
- Add QR code generation for authenticator apps
- Include backup codes (10 single-use codes)
- Add rate limiting (5 attempts per 15 min)

Security: follows OWASP guidelines
Testing: 98% coverage including edge cases
Breaking: requires users to re-authenticate

Closes #234"

# Fix commit
git commit -m "fix(api): handle special characters in passwords

- Properly escape regex special characters
- Add comprehensive test cases
- Maintain backward compatibility

Previously failed with passwords containing: ^$.*+?()[]{}|\\

Fixes #789"

# Refactor commit
git commit -m "refactor(payment): extract validation logic

- Move validation to dedicated PaymentValidator class
- Improve testability and reusability
- No functional changes

Part of technical debt reduction (see #456)"
```

## Smart Commit Creation

APEX analyzes your changes and suggests:

```
📝 APEX Commit Analysis

I've analyzed your changes and suggest 3 atomic commits:

1️⃣ **Feature: User avatar upload**
   Files: AvatarUpload.tsx, avatar.utils.ts
   - Component with preview functionality
   - Image validation (size/format)
   - Upload progress tracking

2️⃣ **Feature: Avatar image processing**
   Files: imageResize.ts, s3Upload.ts
   - Automatic resizing to 200x200
   - S3 integration with presigned URLs
   - Fallback for local development

3️⃣ **Tests: Avatar upload test suite**
   Files: *.test.ts
   - Unit tests for validation
   - Component interaction tests
   - Upload integration tests

Would you like me to create these commits?
```

## PR Description Generation

```markdown
## 🎯 Summary
[Concise description of what this PR accomplishes]

## 🔄 Changes
- ✅ [Major change 1] - [brief detail]
- ✅ [Major change 2] - [brief detail]
- ✅ [Test coverage: X%]

## 🏗️ Technical Implementation
[Key technical decisions and why]

### Architecture Decisions
- **[Decision]**: [Reasoning]
- **[Decision]**: [Reasoning]

### Performance Considerations
- [Impact on load time]
- [Database query changes]
- [Caching strategy]

## 🧪 Testing
- **Unit Tests**: [What's covered]
- **Integration Tests**: [What's covered]
- **Manual Testing**: [Browsers/devices tested]
- **Edge Cases**: [Special scenarios handled]

## 📸 Screenshots/Demo
[Include relevant visuals]

## 🚨 Breaking Changes
[List any breaking changes or "None"]

## 🔐 Security Considerations
[Security measures taken or "N/A"]

## 📋 Deployment Notes
[Special deployment steps or "Standard deployment"]

## ✅ Checklist
- [ ] Tests pass locally
- [ ] No console errors
- [ ] Responsive design verified
- [ ] Accessibility checked
- [ ] Documentation updated

Closes #[issue]
```

## Intelligent Features

### Change Grouping
- Groups related changes together
- Suggests logical commit boundaries
- Identifies feature vs fix vs refactor

### Message Enhancement
- Adds missing context
- Includes technical details
- References relevant standards

### Issue Linking
- Automatically finds related issues
- Uses correct closing keywords
- Cross-references related PRs

## Usage

When user says:
- "/apex commit"
- "create commits"
- "help with commit message"
- "generate PR description"
- "prepare for PR"

Analyze changes and provide intelligent commit strategy.