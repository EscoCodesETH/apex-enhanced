# 🧪 Test-Driven Development with APEX

Master the art of Test-Driven Development (TDD) using APEX Enhanced's intelligent testing capabilities.

## Why TDD in APEX?

APEX Enhanced makes TDD mandatory because:
- **Better Design**: Writing tests first forces better API design
- **Confidence**: Know your code works before shipping
- **Documentation**: Tests document intended behavior
- **Refactoring Safety**: Change code without fear
- **AI Learning**: AI learns patterns from your tests

## The TDD Cycle

```
   🔴 Red
Write failing test
      ↓
   🟢 Green  
Make test pass
      ↓
   🔵 Refactor
Improve code
      ↺
```

## Basic TDD Example

Let's build a password strength checker:

### Step 1: Write Failing Test (Red)

```typescript
// AI writes test first
describe('Password Strength Checker', () => {
  it('rates weak passwords as weak', () => {
    expect(checkPasswordStrength('123456')).toBe('weak');
    expect(checkPasswordStrength('password')).toBe('weak');
  });
});

// Running test: FAIL ❌
// checkPasswordStrength is not defined
```

### Step 2: Make Test Pass (Green)

```typescript
// AI implements minimal code
function checkPasswordStrength(password: string): string {
  const weakPasswords = ['123456', 'password'];
  if (weakPasswords.includes(password)) {
    return 'weak';
  }
  return 'strong';
}

// Running test: PASS ✅
```

### Step 3: Refactor (Blue)

```typescript
// AI improves implementation
type PasswordStrength = 'weak' | 'medium' | 'strong';

function checkPasswordStrength(password: string): PasswordStrength {
  // Check common weak passwords
  if (COMMON_WEAK_PASSWORDS.includes(password)) {
    return 'weak';
  }
  
  // Check length
  if (password.length < 8) {
    return 'weak';
  }
  
  // Will add more rules as tests require
  return 'strong';
}
```

## Advanced TDD Patterns

### Pattern 1: Triangulation

Don't generalize until you have multiple examples:

```typescript
// First test
it('adds two positive numbers', () => {
  expect(add(2, 3)).toBe(5);
});

// Don't generalize yet, just return 5
function add(a: number, b: number): number {
  return 5;
}

// Second test forces generalization
it('adds different numbers', () => {
  expect(add(1, 1)).toBe(2);
});

// Now generalize
function add(a: number, b: number): number {
  return a + b;
}
```

### Pattern 2: Obvious Implementation

When the implementation is obvious, write it:

```typescript
it('converts celsius to fahrenheit', () => {
  expect(celsiusToFahrenheit(0)).toBe(32);
  expect(celsiusToFahrenheit(100)).toBe(212);
});

// Obvious formula, implement directly
function celsiusToFahrenheit(celsius: number): number {
  return (celsius * 9/5) + 32;
}
```

### Pattern 3: Fake It Till You Make It

Start with hardcoded values, then generalize:

```typescript
// Test 1
it('greets user by name', () => {
  expect(greet('Alice')).toBe('Hello, Alice!');
});

// Fake it
function greet(name: string): string {
  return 'Hello, Alice!';
}

// Test 2 forces real implementation
it('greets different users', () => {
  expect(greet('Bob')).toBe('Hello, Bob!');
});

// Make it real
function greet(name: string): string {
  return `Hello, ${name}!`;
}
```

## Testing Complex Features

### Example: Shopping Cart with TDD

```typescript
// Start with behavior tests
describe('Shopping Cart', () => {
  describe('adding items', () => {
    it('starts empty', () => {
      const cart = new ShoppingCart();
      expect(cart.isEmpty()).toBe(true);
      expect(cart.itemCount()).toBe(0);
    });

    it('contains items after adding', () => {
      const cart = new ShoppingCart();
      cart.add({ id: '1', name: 'Book', price: 10 });
      
      expect(cart.isEmpty()).toBe(false);
      expect(cart.itemCount()).toBe(1);
    });

    it('increases quantity for duplicate items', () => {
      const cart = new ShoppingCart();
      const book = { id: '1', name: 'Book', price: 10 };
      
      cart.add(book);
      cart.add(book);
      
      expect(cart.itemCount()).toBe(2);
      expect(cart.getQuantity('1')).toBe(2);
    });
  });

  describe('calculating totals', () => {
    it('calculates subtotal correctly', () => {
      const cart = new ShoppingCart();
      cart.add({ id: '1', name: 'Book', price: 10 });
      cart.add({ id: '2', name: 'Pen', price: 2 });
      
      expect(cart.subtotal()).toBe(12);
    });

    it('applies percentage discounts', () => {
      const cart = new ShoppingCart();
      cart.add({ id: '1', name: 'Book', price: 100 });
      cart.applyDiscount({ type: 'percentage', value: 10 });
      
      expect(cart.total()).toBe(90);
    });
  });
});
```

Implementation emerges from tests:

```typescript
class ShoppingCart {
  private items: Map<string, CartItem> = new Map();
  private discount: Discount | null = null;

  isEmpty(): boolean {
    return this.items.size === 0;
  }

  itemCount(): number {
    return Array.from(this.items.values())
      .reduce((sum, item) => sum + item.quantity, 0);
  }

  add(product: Product): void {
    const existing = this.items.get(product.id);
    if (existing) {
      existing.quantity++;
    } else {
      this.items.set(product.id, {
        product,
        quantity: 1
      });
    }
  }

  getQuantity(productId: string): number {
    return this.items.get(productId)?.quantity ?? 0;
  }

  subtotal(): number {
    return Array.from(this.items.values())
      .reduce((sum, item) => sum + (item.product.price * item.quantity), 0);
  }

  applyDiscount(discount: Discount): void {
    this.discount = discount;
  }

  total(): number {
    const subtotal = this.subtotal();
    if (!this.discount) return subtotal;

    if (this.discount.type === 'percentage') {
      return subtotal * (1 - this.discount.value / 100);
    }
    
    return subtotal;
  }
}
```

## Testing Async Code

### Promise-Based Testing

```typescript
describe('User Service', () => {
  it('fetches user by id', async () => {
    const user = await fetchUser('123');
    
    expect(user).toEqual({
      id: '123',
      name: 'Alice',
      email: 'alice@example.com'
    });
  });

  it('throws when user not found', async () => {
    await expect(fetchUser('nonexistent'))
      .rejects
      .toThrow('User not found');
  });

  it('retries on network failure', async () => {
    // Mock network failure then success
    mockApi
      .onFirstCall().rejects(new Error('Network error'))
      .onSecondCall().resolves({ id: '123', name: 'Alice' });
    
    const user = await fetchUserWithRetry('123');
    
    expect(user.name).toBe('Alice');
    expect(mockApi).toHaveBeenCalledTimes(2);
  });
});
```

### Testing Event Emitters

```typescript
describe('Event System', () => {
  it('notifies subscribers of events', (done) => {
    const emitter = new EventEmitter();
    
    emitter.on('user:login', (user) => {
      expect(user.id).toBe('123');
      done();
    });
    
    emitter.emit('user:login', { id: '123' });
  });

  it('handles multiple subscribers', () => {
    const emitter = new EventEmitter();
    const handler1 = jest.fn();
    const handler2 = jest.fn();
    
    emitter.on('event', handler1);
    emitter.on('event', handler2);
    emitter.emit('event', 'data');
    
    expect(handler1).toHaveBeenCalledWith('data');
    expect(handler2).toHaveBeenCalledWith('data');
  });
});
```

## Testing React Components

### Component TDD

```typescript
describe('LoginForm', () => {
  it('renders email and password fields', () => {
    render(<LoginForm />);
    
    expect(screen.getByLabelText('Email')).toBeInTheDocument();
    expect(screen.getByLabelText('Password')).toBeInTheDocument();
  });

  it('shows validation errors', async () => {
    render(<LoginForm />);
    
    // Submit without filling fields
    await userEvent.click(screen.getByRole('button', { name: 'Login' }));
    
    expect(screen.getByText('Email is required')).toBeInTheDocument();
    expect(screen.getByText('Password is required')).toBeInTheDocument();
  });

  it('calls onSubmit with credentials', async () => {
    const handleSubmit = jest.fn();
    render(<LoginForm onSubmit={handleSubmit} />);
    
    await userEvent.type(screen.getByLabelText('Email'), 'user@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'password123');
    await userEvent.click(screen.getByRole('button', { name: 'Login' }));
    
    expect(handleSubmit).toHaveBeenCalledWith({
      email: 'user@example.com',
      password: 'password123'
    });
  });

  it('disables form during submission', async () => {
    const handleSubmit = jest.fn(() => new Promise(resolve => setTimeout(resolve, 100)));
    render(<LoginForm onSubmit={handleSubmit} />);
    
    const submitButton = screen.getByRole('button', { name: 'Login' });
    await userEvent.click(submitButton);
    
    expect(submitButton).toBeDisabled();
    expect(screen.getByLabelText('Email')).toBeDisabled();
    expect(screen.getByLabelText('Password')).toBeDisabled();
  });
});
```

## Testing Best Practices

### 1. Test Behavior, Not Implementation

```typescript
// ❌ Bad: Testing implementation details
it('sets state.isLoading to true', () => {
  const component = shallow(<UserList />);
  component.instance().fetchUsers();
  expect(component.state('isLoading')).toBe(true);
});

// ✅ Good: Testing behavior
it('shows loading indicator while fetching users', () => {
  render(<UserList />);
  expect(screen.getByText('Loading...')).toBeInTheDocument();
});
```

### 2. Use Descriptive Test Names

```typescript
// ❌ Bad: Vague names
it('works', () => {});
it('handles errors', () => {});

// ✅ Good: Descriptive names
it('calculates compound interest correctly for annual compounding', () => {});
it('displays error message when API returns 404', () => {});
```

### 3. Arrange-Act-Assert Pattern

```typescript
it('applies coupon discount to order total', () => {
  // Arrange
  const order = new Order();
  order.addItem({ price: 100, quantity: 2 });
  const coupon = new Coupon('SAVE10', 0.1);
  
  // Act
  order.applyCoupon(coupon);
  
  // Assert
  expect(order.total()).toBe(180); // 200 - 10%
});
```

### 4. One Assertion Per Test (When Possible)

```typescript
// ❌ Bad: Multiple unrelated assertions
it('user service works', () => {
  const user = createUser({ name: 'Alice' });
  expect(user.name).toBe('Alice');
  expect(user.id).toBeDefined();
  expect(user.createdAt).toBeInstanceOf(Date);
  expect(validateEmail(user.email)).toBe(true);
});

// ✅ Good: Focused tests
it('creates user with provided name', () => {
  const user = createUser({ name: 'Alice' });
  expect(user.name).toBe('Alice');
});

it('generates unique id for new users', () => {
  const user1 = createUser({ name: 'Alice' });
  const user2 = createUser({ name: 'Bob' });
  expect(user1.id).not.toBe(user2.id);
});
```

### 5. Test Edge Cases

```typescript
describe('divide function', () => {
  it('divides two numbers', () => {
    expect(divide(10, 2)).toBe(5);
  });

  // Edge cases
  it('returns Infinity when dividing by zero', () => {
    expect(divide(10, 0)).toBe(Infinity);
  });

  it('handles negative numbers', () => {
    expect(divide(-10, 2)).toBe(-5);
    expect(divide(10, -2)).toBe(-5);
    expect(divide(-10, -2)).toBe(5);
  });

  it('handles decimal results', () => {
    expect(divide(3, 2)).toBe(1.5);
  });
});
```

## Property-Based Testing

APEX can generate property-based tests:

```typescript
import fc from 'fast-check';

describe('String utilities', () => {
  // Traditional test
  it('reverses a string', () => {
    expect(reverse('hello')).toBe('olleh');
  });

  // Property-based test
  it('reversing twice returns original', () => {
    fc.assert(
      fc.property(fc.string(), (str) => {
        expect(reverse(reverse(str))).toBe(str);
      })
    );
  });

  it('reversed string has same length', () => {
    fc.assert(
      fc.property(fc.string(), (str) => {
        expect(reverse(str).length).toBe(str.length);
      })
    );
  });
});

describe('Sorting', () => {
  it('maintains array length', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        expect(sort(arr).length).toBe(arr.length);
      })
    );
  });

  it('produces ordered output', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        const sorted = sort(arr);
        for (let i = 1; i < sorted.length; i++) {
          expect(sorted[i]).toBeGreaterThanOrEqual(sorted[i - 1]);
        }
      })
    );
  });
});
```

## Testing Database Operations

### Repository Testing

```typescript
describe('UserRepository', () => {
  let repo: UserRepository;
  let db: TestDatabase;

  beforeEach(async () => {
    db = await createTestDatabase();
    repo = new UserRepository(db);
  });

  afterEach(async () => {
    await db.cleanup();
  });

  it('creates and retrieves users', async () => {
    // Create
    const user = await repo.create({
      name: 'Alice',
      email: 'alice@example.com'
    });

    expect(user.id).toBeDefined();

    // Retrieve
    const retrieved = await repo.findById(user.id);
    expect(retrieved).toEqual(user);
  });

  it('updates user data', async () => {
    const user = await repo.create({
      name: 'Alice',
      email: 'alice@example.com'
    });

    await repo.update(user.id, { name: 'Alice Smith' });

    const updated = await repo.findById(user.id);
    expect(updated.name).toBe('Alice Smith');
    expect(updated.email).toBe('alice@example.com'); // Unchanged
  });

  it('enforces unique email constraint', async () => {
    await repo.create({
      name: 'Alice',
      email: 'alice@example.com'
    });

    await expect(repo.create({
      name: 'Bob',
      email: 'alice@example.com'
    })).rejects.toThrow('Email already exists');
  });
});
```

## Mocking Strategies

### When to Mock

```typescript
// Mock external services
jest.mock('./emailService');

describe('User Registration', () => {
  it('sends welcome email after registration', async () => {
    const mockSendEmail = jest.mocked(sendEmail);
    
    await registerUser({
      name: 'Alice',
      email: 'alice@example.com'
    });

    expect(mockSendEmail).toHaveBeenCalledWith({
      to: 'alice@example.com',
      subject: 'Welcome to Our App!',
      template: 'welcome'
    });
  });
});

// Don't mock what you own - use real implementations
describe('Order Calculator', () => {
  it('calculates order total with tax', () => {
    // Use real TaxCalculator, not mock
    const calculator = new OrderCalculator(new TaxCalculator());
    
    const total = calculator.calculateTotal({
      subtotal: 100,
      taxRate: 0.08
    });

    expect(total).toBe(108);
  });
});
```

## Test Organization

### Nested Describes

```typescript
describe('ShoppingCart', () => {
  describe('constructor', () => {
    it('creates empty cart', () => {
      const cart = new ShoppingCart();
      expect(cart.isEmpty()).toBe(true);
    });
  });

  describe('add()', () => {
    let cart: ShoppingCart;

    beforeEach(() => {
      cart = new ShoppingCart();
    });

    it('adds new items', () => {
      cart.add({ id: '1', price: 10 });
      expect(cart.itemCount()).toBe(1);
    });

    it('increases quantity for existing items', () => {
      const item = { id: '1', price: 10 };
      cart.add(item);
      cart.add(item);
      expect(cart.getQuantity('1')).toBe(2);
    });
  });

  describe('remove()', () => {
    // Remove tests...
  });
});
```

## Common TDD Mistakes

### 1. Writing Too Many Tests at Once

```typescript
// ❌ Bad: Writing all tests before any implementation
describe('Calculator', () => {
  it('adds numbers');
  it('subtracts numbers');
  it('multiplies numbers');
  it('divides numbers');
  it('handles decimals');
  it('handles negative numbers');
  // ... 20 more pending tests
});

// ✅ Good: One test at a time
describe('Calculator', () => {
  it('adds two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });
  // Implement add(), then write next test
});
```

### 2. Testing Implementation Details

```typescript
// ❌ Bad: Testing private methods
it('_calculateTax returns correct amount', () => {
  const order = new Order();
  expect(order._calculateTax(100)).toBe(8);
});

// ✅ Good: Testing through public interface
it('includes tax in order total', () => {
  const order = new Order();
  order.addItem({ price: 100 });
  expect(order.total()).toBe(108); // Includes 8% tax
});
```

### 3. Overspecification

```typescript
// ❌ Bad: Brittle test
it('formats error message', () => {
  const error = formatError('Invalid input');
  expect(error).toBe('Error: Invalid input. Please try again.');
});

// ✅ Good: Testing what matters
it('includes error message in output', () => {
  const error = formatError('Invalid input');
  expect(error).toContain('Invalid input');
});
```

## APEX TDD Commands

When using APEX Enhanced:

```
You: "Implement password validation with TDD"

AI: "I'll use TDD to implement password validation. Starting with tests:

1. What are the password requirements?
   - Minimum length?
   - Special characters required?
   - Common password checking?

You: "8+ chars, 1 uppercase, 1 number, check common passwords"

AI: "Perfect. Let me write the tests first..."
[AI proceeds with red-green-refactor cycle]
```

## Integration with CI/CD

### Continuous Testing

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node
      uses: actions/setup-node@v3
      with:
        node-version: 18
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: npm test -- --coverage
      
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      
    - name: Check coverage threshold
      run: |
        coverage=$(cat coverage/coverage-summary.json | jq '.total.lines.pct')
        if (( $(echo "$coverage < 85" | bc -l) )); then
          echo "Coverage ${coverage}% is below 85% threshold"
          exit 1
        fi
```

## Next Steps

- Learn about [Git Integration](git-integration.md)
- Master [PR Reviews](pr-reviews.md)
- Explore [Advanced Testing Patterns](../examples/)

---

Remember: TDD isn't about testing, it's about design. Let the tests guide your implementation to better, more maintainable code!