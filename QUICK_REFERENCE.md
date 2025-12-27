# 📃 CHARLES.AI Quick Reference Card

**Print this page or bookmark for quick access!**

---

## ⚡ 3-Step Startup

### Step 1: Set API Keys (One-Time)

```powershell
# Open PowerShell as Administrator:
[Environment]::SetEnvironmentVariable("CHARLES_PPLX_KEY", "your-key", "User")
```

**Get keys:**
- **Perplexity**: https://www.perplexity.ai/api
- **OpenAI**: https://platform.openai.com/api-keys
- **Anthropic**: https://console.anthropic.com

### Step 2: Launch

```powershell
powershell -ExecutionPolicy Bypass -File "charles-ai-ultra-core.ps1"
```

### Step 3: Click "Launch Browser" Button

Then start typing commands!

---

## 🏡 UI Layout

```
┌─────────────────────────────────────────────┐
│ CHARLES.AI - Ultra v3.0 | Status: Ready                │
├─────────────────────────────────────────────┤
│📊 LEFT      │         🗻 CENTER           │        🎈 RIGHT  │
│ Metrics   │       Chat & Reasoning        │      Controls  │
│           │                           │                 │
│ Completed │  [15:32] [YOU] Explain...   │  🌐 Launch      │
│ Tokens    │  [🛸 Planning]             │  🤖 AI Query   │
│ Success%  │  [🛸 Observing]             │  💾 Memory    │
│ Memory    │  [🤖 AI] Response...        │  🔐 Vault      │
│           │                           │  📊 Stats    │
│           │                           │  🗑️ Clear      │
│           │                           │  ❌ Exit       │
├─────────────────────────────────────────────┤
│ 💬 Command Input (Ctrl+Enter to send)                 │
│ [What would you like CHARLES to do?]                     │
└─────────────────────────────────────────────┘
```

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| **Ctrl+Enter** | Send command |
| **Alt+L** | Launch browser |
| **Alt+A** | Run AI query |
| **Alt+M** | Save memory |
| **Alt+S** | Show stats |
| **Alt+C** | Clear chat |
| **Alt+X** | Exit |

---

## 💬 Example Commands

### General Knowledge
```
"Explain machine learning"
"What is blockchain?"
"Compare TypeScript vs Go"
```

### Web Automation
```
"Navigate to github.com"
"Find the login button and click it"
"Type my email into the form"
```

### Memory
```
"Remember: I prefer dark mode"
"What did we discuss earlier?"
"List all my preferences"
```

### Code & Development
```
"Build me a todo list app"
"Create a function to calculate Fibonacci"
"Fix this bug in my code"
```

### Analysis
```
"Analyze this market data"
"Summarize the latest AI news"
"Compare these two algorithms"
```

---

## 📊 Button Quick Reference

### 🌐 Launch Browser
- Starts Microsoft Edge with debugging enabled
- Port: 9222
- Command: Creates new browser instance

### 🤖 Run AI Query
- Sends current text to Perplexity API
- Falls back to OpenAI/Anthropic if needed
- Tracks token usage automatically

### 💾 Save Memory
- Persists important data to vault
- Uses AES-256 encryption
- Retrieves on next session

### 🔐 Vault Status
- Shows vault health metrics
- Displays encryption status
- Lists stored data categories

### 📊 Show Stats
- Completed tasks
- Failed tasks
- Success rate
- Tokens used
- Memory size
- Session duration

### 🗑️ Clear Chat
- Clears all chat history from UI
- Does NOT delete memories
- Helpful for starting fresh conversation

### ❌ Exit
- Gracefully closes application
- Saves all memories
- Archives logs
- Closes browser connection

---

## 📊 Status Indicators

| Icon | Meaning |
|------|----------|
| 🛸 GREEN | System ready, all good |
| 🟡 YELLOW | Waiting for response |
| 🟠 RED | Error occurred |
| 🔄 SPINNER | Processing... |
| ✅ CHECK | Task completed |
| ❌ X | Task failed |

---

## 🔐 API Status Legend

```
✅ Perplexity   (Primary)   - Cheapest, fastest
🔄 OpenAI      (Fallback 1) - GPT-4, more capable
🔄 Anthropic   (Fallback 2) - Claude, very safe
🛸 Local       (Fallback 3) - No API needed
```

---

## 💾 Data Locations

```
Logs:      %APPDATA%\CharlesAI\sessions.log
Archive:   %APPDATA%\CharlesAI\Archive\
Vault:     In-memory (session) + encrypted file
Config:    %APPDATA%\CharlesAI\config.json (future)
```

**To open folder:**
```powershell
Start-Process "%APPDATA%\CharlesAI"
```

---

## 🛠️ Common Issues (Quick Fixes)

### "API Key Invalid"

```powershell
# Check key is set:
echo $env:CHARLES_PPLX_KEY

# If empty, restart PowerShell after setting
```

**Fix**: Set environment variable again, restart PowerShell

### "Browser Not Connected"

```powershell
# Port 9222 might be in use:
netstat -ano | findstr :9222

# Kill existing:
Get-Process msedge | Stop-Process -Force
```

**Fix**: Click "Launch Browser" button or restart Edge

### "Slow Responses"

**Check internet connection**

```powershell
Test-Connection perplexity.ai
```

**Check API quota:**
- Perplexity: https://www.perplexity.ai/settings
- OpenAI: https://platform.openai.com/account/usage/overview
- Anthropic: https://console.anthropic.com/account

**Fix**: Reduce `PplxMaxTokens` from 2000 to 1000 in script

### "High Memory Usage"

**Clear chat**: Click "Clear Chat" button

**Reduce memory**: Edit script Section 1:
```powershell
MemoryShortTermMax = 20  # Was 50
MemoryLongTermMax = 100  # Was 500
```

### "Can't Start PowerShell"

```powershell
# Set execution policy:
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
```

---

## 💰 Token Cost Estimator

**Cost per 1,000 tokens:**
- Perplexity: $0.003
- OpenAI: $0.015
- Anthropic: $0.015

**Example:**
- 100 queries × 500 tokens = 50,000 tokens
- Cost: 50,000 × $0.003 = $0.15 (Perplexity)

**Monthly estimate** (100 queries/day):
- Perplexity: ~$4.50
- OpenAI: ~$22.50
- Anthropic: ~$22.50

---

## 📚 Quick Configuration Changes

### Disable API (Use Local Mode Only)

Edit `charles-ai-ultra-core.ps1`, Section 1:
```powershell
$Config.PplxTimeout = 0  # Disables external APIs
```

### Increase Memory Limits

```powershell
$Config.MemoryLongTermMax = 1000  # From 500
$Config.MemoryShortTermMax = 100  # From 50
```

### Change UI Refresh Rate

```powershell
$Config.UIRefreshMs = 50  # From 100 (faster/more CPU)
```

### Adjust Browser Timeout

```powershell
$Config.BrowserTimeout = 5000  # From 10000 (milliseconds)
```

---

## 📄 File Structure

```
charles-ai-ultra-exe/
├── charles-ai-ultra-core.ps1    ← Main app
├── build-exe.ps1                ← Build script
├── README.md                    ← Project overview
├── QUICK_START.md               ← Getting started
├── SETUP_GUIDE.md               ← Detailed setup
├── QUICK_REFERENCE.md           ← This file
├── builds/
│  └── charles-ai-ultra-v3.exe   ← Compiled version
├── docs/
│  ├── README.md                  ← Doc index
│  ├── ARCHITECTURE.md            ← Technical design
│  ├── MEMORY_SYSTEM.md           ← Memory details
│  ├── VAULT_SECURITY.md          ← Encryption
│  └── MONETIZATION.md            ← Business roadmap
└── .github/
   └── workflows/
      └── build.yml                ← CI/CD (future)
```

---

## 🔐 Security Checklist

- ✅ API keys stored in **Environment Variables** (not in code)
- ✅ Vault uses **AES-256** encryption
- ✅ Keys rotated **per session** automatically
- ✅ Sensitive data **never logged**
- ✅ Browser runs in **isolated mode** (no persistence)
- ✅ Memory **persists encrypted** locally only

**Never:**
- ❌ Share API keys in logs
- ❌ Commit keys to GitHub
- ❌ Run on untrusted networks (VPN recommended)
- ❌ Grant arbitrary file access

---

## 📚 Learning Resources

- **30 seconds**: [QUICK_START.md](./QUICK_START.md)
- **5 minutes**: [SETUP_GUIDE.md](./SETUP_GUIDE.md)
- **15 minutes**: [docs/ARCHITECTURE.md](./docs/README.md)
- **1 hour**: Full [docs/](./docs/) folder

---

## 👤 Support

**Issue?** Check [SETUP_GUIDE.md Troubleshooting](./SETUP_GUIDE.md#%EF%B8%8F-troubleshooting)

**Bug Report?** [GitHub Issues](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/issues)

**Feature Request?** [GitHub Discussions](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/discussions)

**Security Issue?** See [VAULT_SECURITY.md](./docs/VAULT_SECURITY.md#reporting-vulnerabilities)

---

**Printed**: Print Ctrl+P or Save as PDF  
**Bookmarked**: Pin this tab or save link  
**Version**: 3.0-Ultra | **Updated**: Jan 2, 2025
