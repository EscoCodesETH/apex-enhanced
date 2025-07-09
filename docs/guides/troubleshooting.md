# APEX Troubleshooting Guide

This guide helps you resolve common issues when using APEX Enhanced workflows with AI assistants.

## Common Issues and Solutions

### 1. AI Not Following APEX Workflow

**Symptoms:**
- AI skips test-first approach
- Implements features without planning
- Generates incomplete or untested code

**Solutions:**
```markdown
# Always start conversations with:
"I'm using APEX Enhanced workflow. Please follow the test-first approach."

# Reference the template explicitly:
"Follow the APEX template at .claude/apex.md for this feature."

# Use command templates:
"Use the apex-feature command to implement [feature name]"
```

### 2. Tests Not Running or Failing

**Symptoms:**
- Tests fail with import errors
- Mock data doesn't match implementation
- Integration tests timeout

**Solutions:**

#### Import Errors
```javascript
// ❌ Common mistake
import { Component } from './component';

// ✅ Correct approach
import { Component } from './component.js';  // Include extension
// Or ensure your test runner handles module resolution
```

#### Mock Data Issues
```javascript
// ❌ Outdated mock
const mockUser = { name: 'Test' };

// ✅ Complete mock matching implementation
const mockUser = {
  id: '123',
  name: 'Test User',
  email: 'test@example.com',
  createdAt: new Date().toISOString()
};
```

#### Integration Test Timeouts
```javascript
// ❌ No timeout handling
test('API call', async () => {
  const result = await fetchData();
});

// ✅ Proper timeout and error handling
test('API call', async () => {
  const result = await fetchData();
  expect(result).toBeDefined();
}, 10000); // 10 second timeout
```

### 3. Git Workflow Issues

**Symptoms:**
- Commits too large or unfocused
- Merge conflicts from poor branching
- Lost work from improper git usage

**Solutions:**

#### Atomic Commits
```bash
# ❌ Everything in one commit
git add .
git commit -m "Added feature"

# ✅ Separate logical changes
git add src/components/UserProfile.test.js
git commit -m "test: Add UserProfile component tests"

git add src/components/UserProfile.js
git commit -m "feat: Implement UserProfile component"

git add docs/components.md
git commit -m "docs: Document UserProfile usage"
```

#### Branch Management
```bash
# ❌ Working directly on main
git checkout main
# make changes

# ✅ Feature branch workflow
git checkout -b feature/user-profile
# make changes
git commit -m "feat: Add user profile"
git checkout main
git merge --no-ff feature/user-profile
```

### 4. AI Context Loss

**Symptoms:**
- AI forgets previous decisions
- Inconsistent code style
- Repeated explanations needed

**Solutions:**

#### Context Preservation
```markdown
# Start each session with context:
"Continuing work on the user authentication feature.
Previous decisions:
- Using JWT for tokens
- PostgreSQL for user data
- bcrypt for password hashing
Current task: Implement password reset flow"
```

#### Use Artifacts
```markdown
"Please create an artifact with the current implementation plan"
"Update the artifact with the test results"
```

### 5. Performance Issues

**Symptoms:**
- Slow test execution
- Development server lag
- Build times increasing

**Solutions:**

#### Test Performance
```javascript
// ❌ Unnecessary setup in each test
beforeEach(() => {
  setupDatabase();
  seedTestData();
  initializeApp();
});

// ✅ Optimize setup
beforeAll(() => {
  setupDatabase();
});

beforeEach(() => {
  seedTestData(); // Only if needed
});
```

#### Development Performance
```bash
# Use watch mode for faster feedback
npm test -- --watch
npm run dev -- --host

# Profile slow operations
console.time('DataProcessing');
processLargeDataset();
console.timeEnd('DataProcessing');
```

## Debugging Strategies

### 1. Test-First Debugging
When a feature isn't working:

```javascript
// 1. Write a failing test that reproduces the issue
test('should handle empty input gracefully', () => {
  expect(() => processInput('')).not.toThrow();
});

// 2. Fix the implementation
function processInput(input) {
  if (!input) return null; // Add guard clause
  // ... rest of implementation
}
```

### 2. AI Assistant Debugging

When AI gives incorrect solutions:

```markdown
"The implementation has a bug: [describe issue].
Let's debug step by step:
1. What does the failing test tell us?
2. What assumptions are we making?
3. How can we isolate the problem?"
```

### 3. Integration Debugging

For complex integration issues:

```javascript
// Add detailed logging
console.log('API Request:', {
  method,
  url,
  headers,
  body: JSON.stringify(body, null, 2)
});

// Use breakpoints effectively
debugger; // Pause execution here

// Validate at boundaries
assert(isValidInput(data), 'Invalid input data');
```

## Prevention Strategies

### 1. Clear Requirements
```markdown
# Before starting, always clarify:
- [ ] User stories and acceptance criteria
- [ ] Technical constraints
- [ ] Performance requirements
- [ ] Security considerations
```

### 2. Consistent Testing
```javascript
// Establish testing patterns
describe('Component', () => {
  describe('initialization', () => {
    // Group related tests
  });
  
  describe('user interactions', () => {
    // Separate concerns
  });
  
  describe('error handling', () => {
    // Always test edge cases
  });
});
```

### 3. Documentation
```markdown
# Document decisions in code
/**
 * We use a singleton pattern here because:
 * 1. Database connections should be reused
 * 2. Configuration is loaded once
 * 3. Prevents multiple initialization
 */
```

## Getting Help

### 1. Provide Context
When asking for help, include:
- The APEX workflow step you're on
- Relevant code snippets
- Error messages (complete)
- What you've already tried

### 2. Minimal Reproduction
```javascript
// Create minimal test case
test('reproduction of issue', () => {
  // Smallest code that shows the problem
  const result = problematicFunction('input');
  expect(result).toBe('expected');
  // Actual: 'unexpected'
});
```

### 3. Community Resources
- APEX Enhanced GitHub Discussions
- Stack Overflow with #apex-enhanced tag
- AI assistant prompts library

## Quick Reference

### Debug Commands
```bash
# Run specific test
npm test -- UserProfile.test.js

# Run tests in debug mode
node --inspect-brk node_modules/.bin/jest

# Check test coverage
npm test -- --coverage

# Lint issues
npm run lint -- --fix
```

### AI Prompts for Debugging
```markdown
"Debug this test failure using APEX workflow"
"Explain why this integration test is flaky"
"Refactor this code following APEX patterns"
"Add error handling using test-first approach"
```

Remember: Most issues stem from skipping APEX workflow steps. When in doubt, return to the fundamentals: test first, implement minimal, refactor, document.