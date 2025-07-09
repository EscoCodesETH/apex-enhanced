# APEX Task Command

Show current progress and manage task execution with intelligent tracking.

## Process

1. **Load current feature plan** from context
2. **Display progress** with visual indicators
3. **Proceed with next task** if requested
4. **Run quality checks** automatically
5. **Update progress** after each task

## Progress Display Format

```
📊 Feature Progress: [Feature Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Progress: ████████████░░░░░░░░ 60% (3/5 tasks)
Time: 1h 23m elapsed | ~45m remaining
Quality: 94/100 ✅

📋 Task Breakdown:
✅ 1. Setup Components (18m)
   └─ Quality: A+ | Tests: 100% | Complexity: Low
   
✅ 2. Core Logic (45m)
   └─ Quality: A | Tests: 96% | Complexity: Medium
   
🔄 3. API Integration (in progress - 35%)
   ├─ ✅ Endpoint creation
   ├─ 🔄 Data validation
   └─ ⏳ Error handling
   
⏳ 4. Testing Suite (not started)
   └─ Estimated: 30m
   
⏳ 5. Polish & Deploy (not started)
   └─ Estimated: 15m

📊 Metrics:
- Test Coverage: 94% ↗️
- Code Complexity: 4.2/10 ✅
- Type Safety: 100% ✅
- Bundle Impact: +2.3KB ✅

🎯 Current Focus: Implementing data validation for API
💡 Next Step: Complete validation, then error handling
```

## Task Execution

When continuing tasks:

1. **Start with TDD**:
   ```
   🧪 Writing tests for [current task]...
   [Show test code]
   ```

2. **Implement to pass tests**:
   ```
   ✍️ Implementing [current task]...
   [Show implementation]
   ```

3. **Run quality checks**:
   ```
   🔍 Running quality analysis...
   ✅ Complexity: OK
   ✅ Test Coverage: 96%
   ✅ Performance: No issues
   ```

4. **Update progress**:
   ```
   ✅ Task 3 complete!
   Progress updated: 80% complete
   ```

## Smart Features

### Time Estimation
- Track actual vs estimated time
- Adjust future estimates based on velocity
- Warn if significantly over estimate

### Quality Tracking
- Maintain quality score across tasks
- Flag if quality drops below threshold
- Suggest improvements proactively

### Intelligent Next Steps
- Recommend task order based on dependencies
- Identify blockers early
- Suggest parallel work when possible

## Usage

When user says:
- "/apex task"
- "show progress"
- "continue with next task"
- "what's next?"
- "task status"

Respond with current progress and offer to continue.