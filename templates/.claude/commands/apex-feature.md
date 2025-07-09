# APEX Feature Command

Start a new feature using the APEX Enhanced workflow with adaptive complexity.

## Process

1. **Analyze the feature request** to determine complexity:
   - Simple: UI tweaks, minor changes (< 2 hours)
   - Standard: Business logic, new components (2-6 hours)
   - Complex: System changes, integrations (6+ hours)

2. **Ask clarifying questions** based on complexity:
   - Simple: 2-3 quick questions
   - Standard: 4-6 detailed questions
   - Complex: 8-10 comprehensive questions

3. **Generate feature plan** including:
   - Goal and success criteria
   - Implementation tasks (scaled to complexity)
   - Technical considerations
   - Risk assessment

4. **Get approval** before proceeding to implementation

## Adaptive Complexity

### Lightweight Mode (Simple Features)
```markdown
Feature: [Name]
Goal: [One sentence]
Tasks:
1. Implementation (30 min)
2. Testing (15 min)
3. Polish (15 min)
```

### Standard Mode (Most Features)
```markdown
Feature: [Name]
Goal: [Clear description]
Success Criteria:
- [ ] Criterion 1
- [ ] Criterion 2
Tasks:
1. Setup (X min)
2. Core Logic (X min)
3. Testing (X min)
4. Polish (X min)
Technical Notes: [Key considerations]
```

### Robust Mode (Critical Features)
Full PRD-style documentation with:
- Detailed requirements
- Security analysis
- Performance considerations
- Rollback plan
- Monitoring strategy

## Usage

When user says any variation of:
- "implement [feature] with APEX"
- "new feature: [description]"
- "/apex feature [description]"
- "let's build [feature]"

Respond with:
```
🚀 APEX Feature Analysis

I'll help you implement [feature]. Let me analyze the complexity...

This appears to be a [SIMPLE/STANDARD/COMPLEX] feature.

A few clarifying questions:
1. [Relevant question based on complexity]
2. [Another question]
...
```

Then generate appropriate feature plan based on responses.