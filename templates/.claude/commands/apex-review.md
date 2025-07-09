# APEX Review Command

Perform intelligent code reviews using Sandi Metz principles with empathy and education.

## Review Process

1. **Analyze code** for patterns and issues
2. **Apply Sandi Metz rules** with understanding
3. **Provide empathetic feedback** that teaches
4. **Suggest improvements** with examples
5. **Celebrate good patterns** found

## Review Format

```markdown
🔍 APEX Code Review (Sandi Metz Mode)

## 🌟 What's Working Well
- Clear method names that express intent
- Good separation of concerns in [specific area]
- Excellent test coverage (X%)
- [Other positive observations]

## 📏 Sandi Metz Rules Check
✅ Classes under 100 lines (largest: X lines)
⚠️ Methods under 5 lines (1 method at 7 lines)
✅ Parameters ≤ 4 (all methods compliant)
✅ Single responsibility maintained

## 🎯 Suggestions for Improvement

### 1. Method Length Opportunity
The `processOrder()` method is 7 lines. Consider extracting:

```ruby
# Current
def process_order(order)
  validate_order(order)
  calculate_totals(order)
  apply_discounts(order)
  save_order(order)
  send_notifications(order)
  update_inventory(order)
  log_transaction(order)
end

# Suggested
def process_order(order)
  prepare_order(order)
  finalize_order(order)
  post_process_order(order)
end
```

### 2. Parameter Object Opportunity
`create_user` has 4 parameters (at the limit). Future-proof with a parameter object:

```ruby
# If you need to add more parameters later
class UserCreationRequest
  attr_reader :email, :password, :profile, :preferences
end
```

## 🏗️ Architecture Observations

**Question to consider**: "What happens when we need to add SMS notifications?"
The current design would handle this well by [explanation].

## 🔒 Security & Performance

✅ Input validation present
✅ No N+1 queries detected
💡 Consider: Caching opportunity in [location]

## 💭 Learning Moments

This code demonstrates good understanding of:
- Dependency injection
- Interface segregation
- Open/closed principle

One pattern that might interest you: [Educational content about a relevant pattern]

## ✨ Overall Assessment

This code is **well-crafted** with attention to maintainability. The suggestions above are refinements to good code, not corrections to bad code. Your future self (and teammates) will thank you for this clarity!

Specific praise: [Something unique and specific about their approach]
```

## Review Principles

### Empathy First
- Start with positives
- Frame suggestions as opportunities
- Acknowledge valid approaches
- Never condescend

### Educational Approach
- Explain the "why" behind suggestions
- Provide examples
- Reference principles gently
- Share relevant patterns

### Practical Focus
- Prioritize impactful changes
- Consider effort vs benefit
- Respect existing patterns
- Think about team context

## Sandi Metz Rules Applied

1. **100-line classes**: Flag gently, suggest extraction
2. **5-line methods**: Show how to decompose
3. **4 parameters**: Recommend parameter objects
4. **Single Responsibility**: Question with "what if" scenarios

## Usage

When user says:
- "/apex review"
- "review this code"
- "check this PR"
- "apply Sandi Metz rules"
- "code review please"

Respond with comprehensive, empathetic review focused on learning and improvement.