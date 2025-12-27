# 🚀 CHARLES.AI v3.0 - Setup & Build Guide

## ⚡ Quick Start (5 Minutes)

### Step 1: Set API Keys (Environment Variables)

**Windows PowerShell (Admin):**

```powershell
# Open PowerShell as Administrator and run:
[Environment]::SetEnvironmentVariable("CHARLES_PPLX_KEY", "your-perplexity-api-key", "User")
[Environment]::SetEnvironmentVariable("CHARLES_OPENAI_KEY", "your-openai-api-key", "User")
[Environment]::SetEnvironmentVariable("CHARLES_ANTHROPIC_KEY", "your-anthropic-api-key", "User")

# Verify (new PowerShell session):
echo $env:CHARLES_PPLX_KEY
```

**Windows CMD (Admin):**

```cmd
setx CHARLES_PPLX_KEY "your-perplexity-api-key"
setx CHARLES_OPENAI_KEY "your-openai-api-key"
setx CHARLES_ANTHROPIC_KEY "your-anthropic-api-key"

# Restart CMD for changes to take effect
```

### Step 2: Get API Keys

#### Perplexity (Primary)
1. Go to https://www.perplexity.ai/
2. Sign up / Log in
3. Navigate to API settings
4. Generate API key
5. Copy key to `CHARLES_PPLX_KEY`

#### OpenAI (Fallback 1)
1. Go to https://platform.openai.com/
2. Sign up / Log in
3. Create API key at https://platform.openai.com/api-keys
4. Copy key to `CHARLES_OPENAI_KEY`

#### Anthropic (Fallback 2)
1. Go to https://console.anthropic.com/
2. Sign up / Log in
3. Create API key
4. Copy key to `CHARLES_ANTHROPIC_KEY`

### Step 3: Run the Script

**Option A: Direct PowerShell Execution**

```powershell
powershell -ExecutionPolicy Bypass -File "charles-ai-ultra-core.ps1"
```

**Option B: Double-click (if .ps1 file association is set)**

- Right-click `charles-ai-ultra-core.ps1`
- Select "Run with PowerShell"

### Step 4: Use CHARLES.AI

- Click "🌐 Launch Browser" to start Edge with debugging enabled
- Type commands in the input box
- Press Ctrl+Enter to send
- Watch real-time AI responses with memory integration

---

## 📦 Build Your Own .EXE (Optional)

### Prerequisites

```powershell
# Install PS2EXE (one-time)
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
Install-Module -Name ps2exe -Repository PSGallery -Force
```

### Build Process

```powershell
# 1. Clone repository
git clone https://github.com/POWDER-RANGER/charles-ai-ultra-exe.git
cd charles-ai-ultra-exe

# 2. Create output directory
mkdir builds -ErrorAction SilentlyContinue

# 3. Compile to EXE
$params = @{
    InputFile = "charles-ai-ultra-core.ps1"
    OutputFile = "builds\charles-ai-ultra-v3.0.exe"
    Title = "CHARLES.AI - Ultra v3.0"
    Description = "Advanced AI Agent with Memory & Browser Automation"
    Company = "G6B Elite Gaming Systems"
    Product = "CHARLES.AI"
    Version = "3.0.0.0"
    Copyright = "(C) 2025 Curtis Farrar"
    Verbose = $true
    icon = $null  # Optional: Add icon.ico path
}

ConvertTo-Exe @params
```

### Output

```
builds/
└── charles-ai-ultra-v3.0.exe  (standalone executable)
```

---

## 🔒 Environment Variable Reference

| Variable | Description | Source | Required |
|----------|-------------|--------|----------|
| `CHARLES_PPLX_KEY` | Perplexity API key | https://www.perplexity.ai/api | Yes* |
| `CHARLES_OPENAI_KEY` | OpenAI GPT-4 key | https://platform.openai.com/api-keys | No (fallback) |
| `CHARLES_ANTHROPIC_KEY` | Anthropic Claude key | https://console.anthropic.com/ | No (fallback) |

*At least one AI API key is required. Primary uses Perplexity, falls back to OpenAI, then Anthropic, then local mode.

---

## ⚙️ Configuration

### Location

```
%APPDATA%\CharlesAI\config.json  (User-specific configs)
```

### Key Settings

**Browser Port** (edit in script, Section 1):
```powershell
BrowserPort = 9222  # Edge remote debugging port
```

**Memory Limits** (edit in script, Section 1):
```powershell
MemoryShortTermMax = 50    # Session-specific items
MemoryLongTermMax = 500    # Persistent memories
```

**Timeout Settings**:
```powershell
PplxTimeout = 30           # API timeout (seconds)
BrowserTimeout = 10000     # CDP timeout (milliseconds)
```

---

## 🛠️ Troubleshooting

### "API Key Invalid" Error

```powershell
# Verify keys are set:
echo $env:CHARLES_PPLX_KEY
echo $env:CHARLES_OPENAI_KEY
echo $env:CHARLES_ANTHROPIC_KEY

# If empty, re-run Step 1 setup
```

### "Browser not connected" Error

```powershell
# Check if port 9222 is available:
netstat -ano | findstr :9222

# If in use, either:
# 1. Change BrowserPort in script to 9223
# 2. Kill existing Edge process: Get-Process msedge | Stop-Process -Force
```

### "Access Denied" Error

- Right-click PowerShell → Run as Administrator
- Or run: `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser`

### High Memory Usage

- Click "🗑️ Clear Chat" to flush memory
- Reduce `MemoryLongTermMax` value
- Restart application

### Slow API Responses

- Check internet connection
- Verify API key quotas at provider dashboards
- Reduce `PplxMaxTokens` from 2000 to 1000

---

## 📊 Data & Logging

### Log Location

```
%APPDATA%\CharlesAI\sessions_YYYYMMDD.log
%APPDATA%\CharlesAI\Archive\sessions_YYYYMMdd_HHmmss.log
```

### What's Logged

- ✅ Session initialization (timestamp, computer, user)
- ✅ API calls (requests, responses, tokens)
- ✅ Memory operations (storage, retrieval, searches)
- ✅ Browser automation (navigation, clicks, waits)
- ✅ Errors & warnings (with full stack traces)
- ❌ **API Keys** (never logged)
- ❌ **Sensitive Data** (blocked by vault)

### Log Rotation

Logs auto-rotate when reaching 10MB. Archives preserve history for 30 days.

---

## 🔐 Security Notes

### API Keys

✅ **SECURE** - Stored in Windows Environment Variables
- User-level isolation
- Encrypted by Windows
- Not in code or logs

### Encryption

✅ **OBELISK Vault** - AES-256-CBC Encryption
- PBKDF2 key derivation (10,000 iterations)
- Automatic key rotation per session
- Thread-safe encryption/decryption

### Best Practices

1. **Never commit API keys to GitHub**
2. **Use environment variables** (not hardcoded)
3. **Rotate keys quarterly**
4. **Monitor API usage** at provider dashboards
5. **Clear logs** periodically if sensitive

---

## 💰 Monetization Setup (Future)

When ready to monetize (v3.1+):

```powershell
# Edit Section 1:
Config.MonetizationEnabled = $true
Config.SessionValueUSD = 5.00
Config.TokenCostPer1K = 0.05
```

Session tracking + revenue reporting coming in v4.0.

---

## 📚 Additional Resources

- [CHARLES.AI Architecture](./docs/ARCHITECTURE.md)
- [API Reference](./docs/API_REFERENCE.md)
- [Memory System Deep Dive](./docs/MEMORY_SYSTEM.md)
- [Security & Vault Guide](./docs/VAULT_SECURITY.md)
- [Browser Automation Examples](./docs/BROWSER_EXAMPLES.md)

---

## 🆘 Support

- **GitHub Issues**: Report bugs [here](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/issues)
- **Logs**: Check `%APPDATA%\CharlesAI\sessions_*.log`
- **Discord**: [Community server](https://discord.com) (coming soon)

---

## 📝 License

**Proprietary** - For authorized personal use only.

---

**Last Updated**: January 2, 2025  
**Version**: 3.0-Ultra  
**Status**: ✅ Production Ready
