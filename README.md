# 🚀 CHARLES.AI Ultra v3.0 - Production .EXE Build

> **Advanced AI Agent with Browser Automation, Memory Systems, & Enterprise Encryption**

![Status](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-0078D4)
![License](https://img.shields.io/badge/License-Proprietary-red)

---

## ✨ Features

### Core Systems
✅ **Advanced Memory** - Multi-tier semantic search (short-term + long-term)  
✅ **Resilient Browser Control** - Chrome DevTools Protocol (CDP) with 4-level retry logic  
✅ **AI Orchestration** - Perplexity (primary) + OpenAI (fallback 1) + Anthropic (fallback 2) + Local (fallback 3)  
✅ **OBELISK Encryption Vault** - AES-256 encrypted credential storage  
✅ **Thread-Safe Logging** - Rotating logs with auto-archive  
✅ **Professional UI** - 3-Panel dark-mode interface (Metrics | Chat | Controls)  
✅ **Session Management** - Unique session IDs + persistent logs  

### Browser Automation
- Navigate to URLs
- Click elements by selector
- Type text into forms
- Wait for selectors
- Extract visible text (DOM)
- Screenshot capture (base64)
- CDP connection with auto-retry

### AI Integration
- Multi-model fallback chain
- Conversation history (semantic context)
- Token usage tracking
- Real-time response streaming
- Automatic error recovery

### Security & Encryption
- PBKDF2 key derivation (10,000 iterations)
- AES-256-GCM encryption
- Credential vault with salt management
- Session-based key rotation
- Secure environment variable handling

---

## 🔧 System Requirements

- **OS**: Windows 10/11 (64-bit recommended)
- **PowerShell**: 5.1 or higher (built-in on Win10+)
- **.NET Framework**: 4.7.2+ (usually pre-installed)
- **RAM**: 4GB minimum, 8GB+ recommended
- **Disk Space**: 50MB for app + logs
- **Browser**: Microsoft Edge (with remote debugging enabled)
- **Internet**: Required for API connectivity

### Pre-Check Script
Run this in PowerShell before installation:

```powershell
# Check Windows version
Write-Host "Windows Version: $(Get-WmiObject Win32_OperatingSystem).Caption"

# Check PowerShell version
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"

# Check .NET Framework
$dotnet = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue
Write-Host ".NET Framework: $($dotnet.Release)"

# Check available RAM
$memory = [Math]::Round((Get-WmiObject Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
Write-Host "Available RAM: ${memory}GB"
```

---

## 📦 Installation

### Option 1: Download Pre-Compiled .EXE (Recommended)

1. **Go to [Releases](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/releases)**
2. **Download** `charles-ai-ultra-v3.0.exe`
3. **Run** the .EXE directly (no installation needed)
4. **First Launch**:
   - App will create `%APPDATA%\CharlesAI\` directory
   - Logs stored in `%APPDATA%\CharlesAI\sessions.log`
   - Vault initialized with password: `CHARLES_ULTRA_[DATE]`

### Option 2: Compile Yourself

#### Prerequisites
```powershell
# Install PS2EXE (one-time)
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
Install-Module -Name ps2exe -Repository PSGallery -Force
```

#### Compile
```powershell
# 1. Clone this repo
git clone https://github.com/POWDER-RANGER/charles-ai-ultra-exe.git
cd charles-ai-ultra-exe

# 2. Run compiler script
.\Build-Charles.ps1

# 3. .EXE will be created in .\builds\charles-ai-ultra-v3.0.exe
```

---

## 🚀 Quick Start

### Launch the Application
```powershell
.\charles-ai-ultra-v3.0.exe
```

### First Run Checklist
- [ ] Verify status shows "🟢 READY"
- [ ] Browser port (9222) is available
- [ ] API keys are configured in code
- [ ] Log directory created at `%APPDATA%\CharlesAI\`

### Basic Commands
```
navigate to github.com
explain quantum computing
build me a calculator
find product reviews
summarize this article
```

---

## ⚙️ Configuration

### Edit API Keys (Before Compilation)

Edit `charles-ai-ultra-core.ps1` **SECTION 1: API & CONFIGURATION**:

```powershell
$PPLX_KEY = "your-perplexity-key-here"
$OPENAI_KEY = $env:OPENAI_API_KEY ?? "your-openai-key"
$ANTHROPIC_KEY = $env:ANTHROPIC_API_KEY ?? "your-anthropic-key"
```

### Advanced Settings

In **SECTION 1**, modify:

| Setting | Default | Purpose |
|---------|---------|---------|
| `PplxTimeout` | 30s | Perplexity API timeout |
| `PplxMaxTokens` | 2000 | Max response tokens |
| `BrowserPort` | 9222 | Chrome DevTools Protocol port |
| `MemoryShortTermMax` | 50 | Short-term memory entries |
| `MemoryLongTermMax` | 500 | Long-term memory entries |
| `MaxTaskSteps` | 15 | Max automation steps per task |

---

## 📊 UI Breakdown

### Left Panel - Metrics 📊
- Tasks Completed / Failed
- Success Rate %
- Token Usage
- Memory Stats (ST/LT)
- Session Duration

### Center Panel - Chat 💬
- Real-time conversation
- AI reasoning steps
- System notifications
- Color-coded output

### Right Panel - Controls 🎮
- 🌐 Launch Browser
- 🤖 Run AI Query
- 💾 Save Memory
- 🔐 Vault Status
- 📊 Show Stats
- 🗑️ Clear Chat
- ❌ Exit

### Bottom - Command Input 💭
- Ctrl+Enter to send commands
- Multi-line input support
- Real-time feedback

---

## 🔐 Security Notes

⚠️ **API Keys in Code** (Current):
- Keys are embedded in the .EXE
- Suitable for **personal use only**
- For distribution, implement external config with encryption

**Future Migration Plan**:
1. Move keys to encrypted config file
2. Add first-run credential wizard
3. Implement secure vault with master password
4. Support environment variable overrides

---

## 📋 Features Roadmap

### v3.0 (Current)
- ✅ Multi-model AI orchestration
- ✅ Advanced memory systems
- ✅ Browser automation (CDP)
- ✅ OBELISK vault
- ✅ Thread-safe logging
- ✅ Professional UI

### v3.1 (Planned)
- 🔄 External config file support
- 🔄 User credential wizard
- 🔄 System tray icon
- 🔄 Auto-update mechanism
- 🔄 Plugin architecture

### v4.0 (Future)
- 🔄 GitHub API integration
- 🔄 Scheduled tasks
- 🔄 Web dashboard
- 🔄 Multi-user support
- 🔄 Monetization hooks

---

## 🐛 Troubleshooting

### "Browser not connected" Error
```powershell
# 1. Ensure Edge is installed
# 2. Check port 9222 is available
netstat -ano | findstr :9222

# 3. Launch browser manually first
msedge.exe --remote-debugging-port=9222
```

### "API Key Invalid" Error
- Verify key format in code
- Test key with curl: `curl -H "Authorization: Bearer YOUR_KEY" https://api.perplexity.ai/health`
- Check internet connectivity

### "Vault initialization failed" Error
- Verify admin permissions
- Check `%APPDATA%\CharlesAI\` exists
- Clear vault files and restart

### High Memory Usage
- Clear chat history (🗑️ button)
- Reduce `MemoryLongTermMax` setting
- Restart application

---

## 📚 Documentation

- [Architecture Guide](./docs/ARCHITECTURE.md)
- [API Reference](./docs/API_REFERENCE.md)
- [Memory System Deep Dive](./docs/MEMORY_SYSTEM.md)
- [OBELISK Vault Guide](./docs/VAULT_SECURITY.md)
- [Browser Automation Examples](./docs/BROWSER_EXAMPLES.md)

---

## 📝 License

**Proprietary** - For authorized use only. Not for redistribution.

---

## 👨‍💻 Author

**Curtis Farrar** | G6B Elite Gaming Systems  
Independent Systems Engineer & AI Security Architect

---

## 🤝 Support & Feedback

- 📧 Email: [your-email]
- 🐙 GitHub Issues: [Report bugs here]
- 💬 Discord: [Community server]

---

## ⭐ Acknowledgments

- **Perplexity AI** - sonar-pro model integration
- **OpenAI** - GPT-4 Turbo fallback
- **Anthropic** - Claude 3 Opus fallback
- **Microsoft** - Edge CDP, PowerShell, .NET

---

**Last Updated**: January 2, 2025  
**Status**: 🟢 Production Ready
