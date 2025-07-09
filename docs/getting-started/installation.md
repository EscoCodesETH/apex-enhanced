# 📦 Installing APEX Enhanced

This guide will help you set up APEX Enhanced for your AI coding assistant in under 5 minutes.

## Prerequisites

- Git installed on your system
- An AI coding assistant (Claude, Cursor, GitHub Copilot, etc.)
- A project where you want to use APEX

## Installation Methods

### Method 1: Automatic Setup (Recommended) 🚀

1. **Clone the APEX repository**
   ```bash
   git clone https://github.com/yourusername/apex-enhanced.git
   cd apex-enhanced
   ```

2. **Navigate to your project**
   ```bash
   cd /path/to/your-project
   ```

3. **Run the setup script**
   
   **Mac/Linux:**
   ```bash
   /path/to/apex-enhanced/scripts/setup.sh
   ```
   
   **Windows:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File \path\to\apex-enhanced\scripts\setup.ps1
   ```

4. **Follow the prompts**
   - The script will detect your AI tool
   - If not detected, select from the menu
   - Files will be copied automatically

### Method 2: Manual Installation 📋

#### For Claude Projects

1. Create the configuration directory:
   ```bash
   mkdir -p claude/commands
   # Note: Use .claude if your system supports it
   ```

2. Copy the APEX files:
   ```bash
   cp apex-enhanced/templates/.claude/apex.md claude/
   cp apex-enhanced/templates/.claude/commands/*.md claude/commands/
   ```

3. In Claude:
   - Open your project
   - Go to Project Knowledge
   - Add the `claude/` folder

#### For Cursor

1. Copy the rules file:
   ```bash
   cp apex-enhanced/templates/cursor/.cursorrules .cursorrules
   ```

2. Restart Cursor to load the rules

#### For GitHub Copilot

1. Create the directory:
   ```bash
   mkdir -p .github/copilot
   ```

2. Copy the instructions:
   ```bash
   cp apex-enhanced/templates/.github/copilot/instructions.md .github/copilot/
   ```

3. Commit and push (Copilot reads from repository)

### Method 3: Direct Download 💾

If you can't use Git:

1. Download the files from GitHub
2. Extract to a folder
3. Follow Method 2 (Manual Installation)

## Verification

After installation, verify APEX is working:

1. **Open your AI assistant**
2. **Type**: "Are you configured with APEX Enhanced?"
3. **Expected response**: AI should acknowledge APEX configuration

### Test Commands

Try these commands to ensure everything works:

```
"Let's implement a hello world feature using APEX Enhanced"
```

The AI should:
- Ask clarifying questions
- Determine complexity (simple)
- Use lightweight mode
- Guide you through TDD

## Configuration

### Customizing APEX

Edit the `apex.md` file to adjust:

```markdown
## Project Configuration
STACK: TypeScript, React, Node.js  # Your tech stack
TESTING: Jest                      # Your test framework
STYLE: Prettier, ESLint           # Your tools
```

### Complexity Thresholds

Adjust when to use each mode:

```markdown
## Complexity Rules
Simple: < 2 hours, UI only, no business logic
Standard: 2-6 hours, business logic, APIs
Complex: 6+ hours, payments, auth, migrations
```

## Troubleshooting

### AI Not Recognizing APEX

1. **Check file location**
   - Claude: `claude/apex.md` or `.claude/apex.md`
   - Cursor: `.cursorrules` in project root
   - Copilot: `.github/copilot/instructions.md`

2. **Restart your AI tool**
   - Some tools cache configurations

3. **Verify file contents**
   - Ensure files copied correctly
   - Check for encoding issues

### Commands Not Working

If `/apex feature` doesn't work:
- Use natural language: "implement X using APEX Enhanced"
- Check if commands are in `commands/` folder
- Some AI tools don't support slash commands

### Windows Issues

- Use PowerShell as Administrator
- If script blocked, run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Use forward slashes in paths

### Permission Errors

Mac/Linux:
```bash
chmod +x /path/to/apex-enhanced/scripts/setup.sh
```

## Updating APEX

To get the latest version:

1. **Pull updates**
   ```bash
   cd apex-enhanced
   git pull origin main
   ```

2. **Re-run setup**
   ```bash
   ./scripts/setup.sh
   ```

## Uninstalling

To remove APEX:

1. **Delete configuration files**
   - Claude: Remove `claude/` or `.claude/`
   - Cursor: Delete `.cursorrules`
   - Copilot: Remove `.github/copilot/instructions.md`

2. **Restart your AI tool**

## Next Steps

✅ Installation complete! Now:

1. Read [Your First Feature](first-feature.md) guide
2. Learn about [Configuration](configuration.md) options
3. Try a simple feature with APEX

## Getting Help

- 📚 [Documentation](https://github.com/yourusername/apex-enhanced)
- 💬 [Discord Community](https://discord.gg/apex-enhanced)
- 🐛 [Report Issues](https://github.com/yourusername/apex-enhanced/issues)

---

**Pro Tip**: Start with a simple feature to get familiar with APEX before tackling complex ones!