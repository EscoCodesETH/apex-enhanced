# 🚀 Simple Features Workflow

Learn how to use APEX Enhanced lightweight mode for simple features that can be completed in under 2 hours.

## What Are Simple Features?

Simple features typically include:
- UI tweaks and styling changes
- Copy or label updates  
- Bug fixes with clear solutions
- Adding simple validations
- Small refactors
- Documentation updates

## The Lightweight Process

```
Planning: 5-10 minutes
Testing: 10-15 minutes  
Implementation: 20-30 minutes
Total: 35-55 minutes
```

## Example 1: Add Loading Spinner

Let's walk through adding a loading spinner to a form:

### Step 1: Start the Feature

```
You: "Add loading spinner to login form using APEX"

AI: "I'll help you add a loading spinner. This appears to be a simple UI feature.

Quick questions:
1. Should the spinner appear on the button or overlay the form?
2. Do you have an existing spinner component?
3. Any specific animation preference?

You: "On the button, we have a Spinner component, keep it simple"
```

### Step 2: Lightweight Plan

```
AI: "Here's my lightweight plan:

Feature: Login Button Loading Spinner
Goal: Show loading state during authentication
Time: ~45 minutes

Tasks:
1. Add loading state to login component (15 min)
2. Quick tests for loading behavior (10 min)  
3. Update button to show spinner (15 min)

Shall I start with the tests?"
```

### Step 3: Quick TDD

```typescript
// AI writes focused tests
describe('Login Loading State', () => {
  it('shows spinner when loading', () => {
    const { getByRole } = render(<LoginForm />);
    const button = getByRole('button', { name: /login/i });
    
    fireEvent.click(button);
    
    expect(getByRole('progressbar')).toBeInTheDocument();
    expect(button).toBeDisabled();
  });

  it('hides spinner after login', async () => {
    const { getByRole, queryByRole } = render(<LoginForm />);
    
    fireEvent.click(getByRole('button', { name: /login/i }));
    
    await waitFor(() => {
      expect(queryByRole('progressbar')).not.toBeInTheDocument();
    });
  });
});
```

### Step 4: Simple Implementation

```typescript
// AI implements minimal code
const LoginForm = () => {
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    
    try {
      await login(email, password);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      {/* ... other fields ... */}
      
      <Button type="submit" disabled={isLoading}>
        {isLoading ? <Spinner size="sm" /> : 'Login'}
      </Button>
    </form>
  );
};
```

### Step 5: Quick Commit

```bash
git add .
git commit -m "feat(auth): add loading spinner to login button

- Show spinner during authentication
- Disable button while loading
- Add tests for loading states"
```

## Example 2: Fix Validation Bug

### The Bug Report

```
Issue #234: Email validation allows spaces
Users can enter "user @example.com" which fails on backend
```

### APEX Lightweight Approach

```
You: "Fix email validation bug #234 with APEX"

AI: "I see this is a simple validation fix. 

Quick check: Should we trim spaces or show an error for spaces?"

You: "Show error - spaces aren't valid in emails"
```

### Fast Test-First Fix

```typescript
// Test first (5 minutes)
test('rejects email with spaces', () => {
  const result = validateEmail('user @example.com');
  expect(result.valid).toBe(false);
  expect(result.error).toBe('Email cannot contain spaces');
});

// Quick fix (5 minutes)
export function validateEmail(email: string) {
  if (email.includes(' ')) {
    return { valid: false, error: 'Email cannot contain spaces' };
  }
  
  // existing validation...
  return { valid: true };
}
```

### Done in 15 Minutes

```bash
git commit -m "fix(validation): reject emails with spaces

- Add explicit check for spaces in email
- Show clear error message
- Add test case

Fixes #234"
```

## Example 3: Update Button Colors

### Brand Color Update

```
You: "Update all primary buttons to new brand color #2563EB with APEX"

AI: "Simple styling update detected. Using lightweight mode.

I'll update the button styles. Do you want to:
1. Update the CSS/theme variable?
2. Find and replace all instances?"

You: "Update the theme variable"
```

### Minimal Process

```scss
// AI goes straight to implementation
// theme.scss
:root {
  // --color-primary: #3B82F6; // old
  --color-primary: #2563EB; // new brand color
}

// Quick visual test
// AI: "This will affect all primary buttons. The color has good contrast
// with white text (WCAG AA compliant). Ready to commit?"
```

### 5-Minute Fix

```bash
git commit -m "style: update primary brand color

- Change from #3B82F6 to #2563EB
- Affects all primary buttons
- Maintains WCAG AA compliance"
```

## When to Use Lightweight Mode

### ✅ Perfect For:

1. **Clear Requirements**
   - "Change button text from 'Submit' to 'Save'"
   - "Add phone number to user profile display"
   - "Fix typo in error message"

2. **Isolated Changes**
   - Single component updates
   - Style adjustments
   - Simple bug fixes

3. **Low Risk**
   - No data changes
   - No security implications
   - No breaking changes

### ❌ Not Suitable For:

1. **Unclear Requirements**
   - "Make the form better"
   - "Improve performance"
   - "Fix all the issues"

2. **System-Wide Changes**
   - Database schema updates
   - API changes
   - Authentication logic

3. **High Risk**
   - Payment processing
   - User permissions
   - Data migrations

## Lightweight Mode Best Practices

### 1. Skip Unnecessary Planning

```
❌ Don't: Write a 5-paragraph plan for changing a color
✅ Do: Jump straight to implementation with a quick confirmation
```

### 2. Minimal But Sufficient Tests

```typescript
// ❌ Don't: Write 10 tests for a button color change

// ✅ Do: Write 1-2 tests that matter
test('displays loading spinner when clicked', () => {
  // Just test the actual behavior
});
```

### 3. Fast Iterations

```
1. Quick test (2 min)
2. Implementation (5 min)
3. Verify (1 min)
4. Commit (2 min)
Total: 10 minutes
```

### 4. Clear Communication

```
You: "Fix the login button color"

AI: "I'll change the login button to use the primary color. 
     This is a simple change, so I'll use lightweight mode.
     Current: gray, New: primary blue. Correct?"

You: "Yes"

[AI proceeds directly to implementation]
```

## Common Lightweight Patterns

### Pattern 1: UI State Addition

```typescript
// Adding a simple UI state
const [showDetails, setShowDetails] = useState(false);

return (
  <div>
    <Button onClick={() => setShowDetails(!showDetails)}>
      {showDetails ? 'Hide' : 'Show'} Details
    </Button>
    {showDetails && <Details />}
  </div>
);
```

### Pattern 2: Simple Validation

```typescript
// Adding a required field check
if (!formData.phoneNumber) {
  errors.phoneNumber = 'Phone number is required';
}
```

### Pattern 3: Style Updates

```css
/* Updating spacing or colors */
.card {
  /* padding: 1rem; */
  padding: 1.5rem; /* Increased for better readability */
}
```

## Transitioning to Standard Mode

Sometimes a "simple" feature reveals complexity:

```
You: "Add email validation"

AI: "Starting with lightweight... wait, I notice your app has:
- Multiple email input locations
- Custom validation framework  
- Internationalization needs

This is more complex than initially appeared. Should I switch to 
standard APEX mode for proper planning?"

You: "Yes, switch to standard"
```

## Quick Reference

| Aspect | Lightweight Mode |
|--------|-----------------|
| Planning | 5-10 minutes conversational |
| Tests | 1-3 focused tests |
| Implementation | Direct and minimal |
| Review | Quick self-check |
| Documentation | Update if needed |
| Commit | Single, clear message |

## Next Steps

- Try a simple feature in your project
- Read about [Standard Features](complex-features.md) for larger tasks
- Learn about [Bug Fixes](bug-fixes.md) workflow

---

Remember: Lightweight doesn't mean careless—it means efficient for appropriate tasks!