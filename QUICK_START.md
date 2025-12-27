# 🚀 CHARLES.AI - Quick Start (5 Minutes)

## 🎉 What You're Getting

- 🤖 **Advanced AI Agent** with memory & reasoning
- 🌐 **Browser Automation** for web tasks
- 💾 **Encrypted Memory System** (short-term + long-term)
- 🔍 **Semantic Search** across memories
- 🚀 **AI Orchestrator** with 3 fallback models
- 🗑️ **Rotating Logs** & session management
- 🔐 **OBELISK Vault** with AES-256 encryption
- 🎆 **Professional 3-Panel UI** (metrics, chat, controls)

---

## ⚡ Step 1: Set Your API Keys (2 minutes)

**Open PowerShell as Administrator** and run:

```powershell
# Perplexity (Primary)
[Environment]::SetEnvironmentVariable("CHARLES_PPLX_KEY", "your-key-here", "User")

# OpenAI (Fallback)
[Environment]::SetEnvironmentVariable("CHARLES_OPENAI_KEY", "your-key-here", "User")

# Anthropic (Fallback)
[Environment]::SetEnvironmentVariable("CHARLES_ANTHROPIC_KEY", "your-key-here", "User")
```

**Where to get API keys:**

| Service | Where | Free Tier |
|---------|-------|----------|
| **Perplexity** | https://www.perplexity.ai/api | $5 credit |
| **OpenAI** | https://platform.openai.com/api-keys | $5 credit |
| **Anthropic** | https://console.anthropic.com | $5 credit |

> 💡 You only need **ONE** API key to start. Perplexity is recommended (cheapest & fastest).

---

## ⚡ Step 2: Run CHARLES.AI

### Option A: Direct PowerShell (Fastest)

```powershell
powershell -ExecutionPolicy Bypass -File "charles-ai-ultra-core.ps1"
```

### Option B: Build Custom .EXE (Recommended for Distribution)

```powershell
# From repository root:
.\build-exe.ps1

# Output: builds\charles-ai-ultra-v3.exe
```

> 📐 See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed build instructions.

---

## ⚡ Step 3: Use It

### UI Buttons

| Button | Action |
|--------|--------|
| 🌐 **Launch Browser** | Start Edge with debugging enabled |
| 🤖 **Run AI Query** | Send prompt to AI (with memory) |
| 💾 **Save Memory** | Persist data to vault |
| 🔐 **Vault Status** | Check encryption & storage |
| 📊 **Show Stats** | View metrics & token usage |
| 🗑️ **Clear Chat** | Flush conversation history |
| ❌ **Exit** | Close gracefully with cleanup |

### Chat Commands

```
👤 Try these:
  "navigate to github.com"
  "what is quantum computing?"
  "build me a todo list app"
  "analyze this market data"
  "remember: I prefer dark mode"
```

> Press **Ctrl+Enter** to send commands.

---

## 🇲🍔 What Happens When You Run It

```
Startup:
✅ Logger initialized
✅ OBELISK Vault created (AES-256)
✅ Memory system started
✅ AI Orchestrator ready (Perplexity + 3 fallbacks)
✅ Browser CDP client connected
✅ Professional UI loaded

🤖 When you send a command:
1. [📀 SHORT-TERM] Stores query in session memory (TTL: 5 min)
2. [🧠 AI PLANNING] Sends to Perplexity API
3. [💾 LONG-TERM] Saves response to vault (persistent)
4. [🔍 SEMANTIC] Indexes for future searches
5. [📊 METRICS] Updates UI with stats

🗣️ Response appears in chat instantly
```

---

## 📊 Sample Output

```
[🚀 HEADER]
  Version: 3.0-Ultra
  Session: a1b2c3d4
  Status: 🛸 READY

[📋 LEFT PANEL - METRICS]
  Tasks Completed: 5
  Tasks Failed: 0
  Success Rate: 100%
  Tokens Used: 1,247
  Memory: 3 ST / 12 LT

[🗻 CENTER PANEL - CHAT]
  [15:32:18] [YOU]: explain machine learning
  [🛸 OBSERVING] 📀 Observing page state...
  [🛸 PLANNING] 🤖 AI planning and reasoning...
  [🛸 AI] Machine learning is...
  ✅ Task completed successfully

[🎈 RIGHT PANEL - CONTROLS]
  [Buttons for all actions]
```

---

## 🔧 Troubleshooting

### "API Key Invalid"

```powershell
# Check keys are set:
echo $env:CHARLES_PPLX_KEY

# If empty: Restart PowerShell after setting env vars
```

### "Browser not connected"

```powershell
# Click "Launch Browser" button in UI
# Or manually start Edge:
Start-Process -FilePath "msedge.exe" -ArgumentList "--remote-debugging-port=9222"
```

### "Module not found: ps2exe"

```powershell
# For building EXE, install once:
Install-Module -Name ps2exe -Force
```

> 📐 Full troubleshooting: [SETUP_GUIDE.md](./SETUP_GUIDE.md#%EF%B8%8F-troubleshooting)

---

## 📚 Architecture Overview

```
╓═════════════════════════════╕
║       USER INTERFACE (3-Panel)        ║
║  [Metrics] [Chat] [Controls]          ║
╙═════════════════════════════╜
         │
╓═════════════════════════════╕
║     COMET AGENT (Controller)         ║
║    - Task Orchestration               ║
║    - Error Handling & Retry           ║
╙═════════════════════════════╜
       │   │   │
════════  ═══════  ═════════
║ CDP     ║  ║ AI    ║  ║ Memory  ║
║Browser  ║  ║Orch.  ║  ║System  ║
║Automation║ ║Fallback ║ ║Semantic║
╙═════════  ╙═══════  ╙════════╜
       │          │          │
╓═════════════════════════════╕
║     OBELISK VAULT (AES-256)         ║
║    Encrypted Data Storage            ║
╙═════════════════════════════╜
       │
╓═════════════════════════════╕
║   LOGGER (Rotating Sessions)       ║
║ %APPDATA%\CharlesAI\sessions.log   ║
╙═════════════════════════════╜
```

---

## 🔐 Data Storage

**All data stored locally (no cloud):**

```
%APPDATA%\CharlesAI\
├── sessions.log              # Current session logs
├── Archive/
│  └── sessions_YYYY.log      # Archived logs (30-day retention)
├── vault.db                # Encrypted memory storage
└── config.json             # User settings
```

> 🔐 All encryption is **client-side** (AES-256-CBC)

---

## 💰 When You're Ready to Monetize

Currently personal-use only. To add API input for other users (v3.1+):

```powershell
# Edit charles-ai-ultra-core.ps1, Section 1:
$Config.MonetizationEnabled = $true
$Config.APIInputMode = $true
$Config.SessionValueUSD = 5.00

# Then users provide their own keys at startup
```

See [MONETIZATION.md](./docs/MONETIZATION.md) for details.

---

## 📚 Documentation

| Document | Purpose |
|----------|----------|
| [SETUP_GUIDE.md](./SETUP_GUIDE.md) | Detailed setup with troubleshooting |
| [ARCHITECTURE.md](./docs/ARCHITECTURE.md) | Technical deep-dive |
| [MEMORY_SYSTEM.md](./docs/MEMORY_SYSTEM.md) | Multi-tier memory explained |
| [VAULT_SECURITY.md](./docs/VAULT_SECURITY.md) | Encryption & security |
| [BROWSER_EXAMPLES.md](./docs/BROWSER_EXAMPLES.md) | CDP automation examples |

---

## 🚀 What's Next

1. ✅ Set API keys
2. ✅ Launch CHARLES.AI
3. ✅ Test a command ("explain ML")
4. ✅ Check metrics to see it working
5. 📦 Build custom .EXE for friends (optional)
6. 💰 Add monetization when ready (v3.1+)

---

## 💫 Need Help?

- **Quick issues**: Check [SETUP_GUIDE.md](./SETUP_GUIDE.md#%EF%B8%8F-troubleshooting)
- **Logs location**: `%APPDATA%\CharlesAI\sessions.log`
- **GitHub Issues**: [Report bug](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/issues)

---

**Version**: 3.0-Ultra | **Status**: ✅ Production Ready | **Last Updated**: Jan 2, 2025
