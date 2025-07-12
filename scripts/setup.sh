#!/bin/bash

# APEX Enhanced Setup Script
# Automatically configures APEX for your AI coding assistant

set -e

echo "🚀 APEX Enhanced Setup"
echo "===================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Detect OS
OS="Unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    OS="Windows"
fi

echo -e "${BLUE}Detected OS:${NC} $OS"
echo ""

# Function to create directory if it doesn't exist
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo -e "${GREEN}✓${NC} Created $1"
    else
        echo -e "${YELLOW}→${NC} $1 already exists"
    fi
}

# Function to copy file if it doesn't exist
copy_file() {
    if [ ! -f "$2" ]; then
        cp "$1" "$2"
        echo -e "${GREEN}✓${NC} Installed $2"
    else
        echo -e "${YELLOW}→${NC} $2 already exists (skipping)"
    fi
}

# Check if we're in a git repository
if [ -d .git ]; then
    echo -e "${GREEN}✓${NC} Git repository detected"
else
    echo -e "${YELLOW}⚠${NC}  Not in a git repository (some features may be limited)"
fi
echo ""

# Detect AI tool
echo "Detecting AI tool configuration..."
TOOL="none"

if [ -d ".claude" ]; then
    TOOL="claude"
    echo -e "${GREEN}✓${NC} Claude project detected"
elif [ -f ".cursorrules" ]; then
    TOOL="cursor"
    echo -e "${GREEN}✓${NC} Cursor project detected"
elif [ -d ".github/copilot" ]; then
    TOOL="copilot"
    echo -e "${GREEN}✓${NC} GitHub Copilot detected"
elif [ -f ".continue/config.json" ]; then
    TOOL="continue"
    echo -e "${GREEN}✓${NC} Continue.dev detected"
fi

if [ "$TOOL" == "none" ]; then
    echo ""
    echo "Which AI tool are you using?"
    echo "1) Claude Projects"
    echo "2) Cursor"
    echo "3) GitHub Copilot"
    echo "4) Continue.dev"
    echo "5) Other/Manual setup"
    read -p "Select (1-5): " choice
    
    case $choice in
        1) TOOL="claude";;
        2) TOOL="cursor";;
        3) TOOL="copilot";;
        4) TOOL="continue";;
        5) TOOL="manual";;
        *) echo "Invalid choice"; exit 1;;
    esac
fi

echo ""
echo "Setting up APEX Enhanced for $TOOL..."
echo ""

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/../templates"

# Setup based on tool
case $TOOL in
    claude)
        create_dir ".claude"
        create_dir ".claude/commands"
        copy_file "$TEMPLATE_DIR/.claude/apex.md" ".claude/apex.md"
        copy_file "$TEMPLATE_DIR/.claude/commands/apex-feature.md" ".claude/commands/apex-feature.md"
        copy_file "$TEMPLATE_DIR/.claude/commands/apex-task.md" ".claude/commands/apex-task.md"
        copy_file "$TEMPLATE_DIR/.claude/commands/apex-review.md" ".claude/commands/apex-review.md"
        copy_file "$TEMPLATE_DIR/.claude/commands/apex-commit.md" ".claude/commands/apex-commit.md"
        ;;
        
    cursor)
        copy_file "$TEMPLATE_DIR/cursor/.cursorrules" ".cursorrules"
        echo -e "${BLUE}ℹ${NC}  Cursor will automatically load .cursorrules"
        ;;
        
    copilot)
        create_dir ".github"
        create_dir ".github/copilot"
        copy_file "$TEMPLATE_DIR/.github/copilot/instructions.md" ".github/copilot/instructions.md"
        ;;
        
    continue)
        echo -e "${YELLOW}⚠${NC}  Continue.dev support is community-maintained"
        echo "Please see the documentation for manual setup"
        ;;
        
    manual)
        echo "For manual setup, copy the appropriate files from:"
        echo "$TEMPLATE_DIR"
        echo ""
        echo "Available configurations:"
        echo "- Claude: .claude/apex.md and commands/"
        echo "- Cursor: cursor/.cursorrules"
        echo "- Copilot: .github/copilot/instructions.md"
        ;;
esac

echo ""
echo -e "${GREEN}✨ APEX Enhanced setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Restart your AI tool to load the new configuration"
echo "2. Try: 'Implement a simple feature using APEX Enhanced'"
echo "3. Check the docs at: https://github.com/yourusername/apex-enhanced"
echo ""
echo "Quick commands:"
echo "- Start feature: 'implement [feature] with APEX'"
echo "- Show progress: 'show APEX task progress'"
echo "- Code review: 'review with APEX Sandi Metz principles'"
echo "- Smart commit: 'create APEX commit'"
echo ""
echo -e "${BLUE}Happy coding with APEX Enhanced! 🚀${NC}"