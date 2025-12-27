# 📚 CHARLES.AI Documentation

**Version**: 3.0-Ultra | **Status**: 🛸 Production Ready | **Last Updated**: January 2, 2025

---

## Quick Navigation

### Getting Started
- **[QUICK_START.md](../QUICK_START.md)** - 5-minute setup (start here!)
- **[SETUP_GUIDE.md](../SETUP_GUIDE.md)** - Detailed installation & configuration
- **[API_KEYS.md](./API_KEYS.md)** - How to get API keys from each provider

### Technical Documentation
- **[ARCHITECTURE.md](./ARCHITECTURE.md)** - System design & component overview
- **[MEMORY_SYSTEM.md](./MEMORY_SYSTEM.md)** - Multi-tier memory architecture
- **[VAULT_SECURITY.md](./VAULT_SECURITY.md)** - Encryption & OBELISK vault
- **[BROWSER_EXAMPLES.md](./BROWSER_EXAMPLES.md)** - CDP automation examples

### Advanced Topics
- **[MONETIZATION.md](./MONETIZATION.md)** - Roadmap to SaaS (v3.1 → v5.0)
- **[PERFORMANCE_TUNING.md](./PERFORMANCE_TUNING.md)** - Optimize memory & speed
- **[TROUBLESHOOTING.md](./TROUBLESHOOTING.md)** - Common issues & fixes

### Development
- **[CONTRIBUTING.md](./CONTRIBUTING.md)** - How to contribute
- **[BUILD_PROCESS.md](./BUILD_PROCESS.md)** - Building custom .EXE
- **[API_REFERENCE.md](./API_REFERENCE.md)** - Internal API docs (for v4.0+)

---

## System Architecture

```
╓════════════════════════════════════════════╕
║                    USER INTERFACE (3-Panel)                 ║
║    [Metrics] [Chat/Reasoning] [Controls/Settings]      ║
╙════════════════════════════════════════════╜
            │                    │                    │
            ↓                    ↓                    ↓
╓════════════════════════════════════════════╕
║              COMET AGENT CONTROLLER (Task Orchestrator)    ║
║  - Task planning & execution                             ║
║  - Error handling & retry logic                          ║
║  - Memory coordination                                   ║
║  - State management                                      ║
╙════════════════════════════════════════════╜
         │                    │                    │
  ─────────────────────────────────────────────
  │                      │                      │
  │                      │                      │
  └─────────────────────────────────────────────

  ╓════════════════╛    ╓══════════════╛    ╓═════════════╛
  ║  CDP CLIENT      ║    ║  AI ORCHESTRATOR  ║    ║  MEMORY SYSTEM  ║
  ║  (Browser Auto)  ║    ║  (Perplexity)     ║    ║  (Multi-Tier)   ║
  ║                  ║    ║  Fallback 1: GPT-4 ║    ║  Semantic      ║
  ║  - Navigate      ║    ║  Fallback 2: Claude ║   ║  Search        ║
  ║  - Click         ║    ║  Fallback 3: Local ║    ║  TTL-based      ║
  ║  - Type          ║    ║                  ║    ║  Persistence    ║
  ║  - Wait          ║    ║  Token Tracking   ║    ║  Indexing       ║
  ║  - Screenshot    ║    ║  Cost Calculation ║    ║  Decay Logic    ║
  ╚════════════════╝    ╚══════════════╝    ╚═════════════╝
      │                  │                  │
      └─────────────────────────────────────────────
         │
  ╓═════════════════════════════════════╛
  ║    OBELISK VAULT (AES-256-CBC Encryption)      ║
  ║    - PBKDF2 Key Derivation (10K iterations)   ║
  ║    - Thread-safe storage                       ║
  ║    - Automatic key rotation per session       ║
  ║    - Vault integrity checks                   ║
  ╚═════════════════════════════════════╝
         │
  ╓═════════════════════════════════════╛
  ║    LOGGER (Thread-Safe, Rotating)            ║
  ║    %APPDATA%\CharlesAI\sessions.log           ║
  ║    - Session tracking                         ║
  ║    - 10MB rotation                            ║
  ║    - 30-day archive retention                 ║
  ╚═════════════════════════════════════╝
```

---

## Key Components (Sections in `charles-ai-ultra-core.ps1`)

| Section | Lines | Purpose |
|---------|-------|----------|
| **1: API & Config** | 1-50 | API keys, constants, configuration |
| **2: Logger** | 51-150 | Thread-safe logging with rotation |
| **3: OBELISK Vault** | 151-300 | AES-256 encryption, key management |
| **4: Memory System** | 301-600 | Multi-tier memory, semantic search |
| **5: CDP Client** | 601-900 | Browser automation, Chrome DevTools |
| **6: AI Orchestrator** | 901-1200 | Multi-model AI with fallbacks |
| **7: COMET Agent** | 1201-1400 | Task orchestration & execution |
| **8: UI (WinForms)** | 1401-3200 | 3-panel professional interface |
| **9: Event Handlers** | 3201-3400 | Button clicks & keyboard shortcuts |
| **10: Startup** | 3401-3500 | Initialization & splash screen |

---

## Technology Stack

```
Language:    PowerShell 5.1+
UI Framework: Windows Forms (System.Windows.Forms)
Encryption:  System.Security.Cryptography
Logging:     Custom rotating logger
APIs:        Perplexity, OpenAI, Anthropic
Browser:     Microsoft Edge (Chrome DevTools Protocol)
```

---

## Data Flow Example

### User Types Command: "Explain quantum computing"

```
1. [UI] User enters text in input box
   ↓
2. [EVENT] Ctrl+Enter triggers KeyDown handler
   ↓
3. [AGENT] ExecuteTask() called with prompt
   ↓
4. [MEMORY] Prompt stored in short-term (TTL: 5 min)
   ↓
5. [CDP] GetVisibleText() retrieves page state
   ↓
6. [AI] Query sent to Perplexity API
   ↓
7. [RESPONSE] AI returns explanation + metadata
   ↓
8. [MEMORY] Response stored in long-term (persistent)
   ↓
9. [MEMORY] Semantic index updated for search
   ↓
10. [VAULT] Encrypted and stored securely
    ↓
11. [LOGGER] Session log updated with tokens/costs
    ↓
12. [UI] Response displayed in chat panel
    ↓
13. [METRICS] Stats updated (tokens, requests, etc.)
```

---

## Memory Hierarchy

### Short-Term Memory (Session)
- **Scope**: Current session only
- **Storage**: RAM (hashtable)
- **TTL**: 5 minutes (configurable)
- **Max Size**: 50 entries
- **Use Case**: "What did the user just ask?"

### Long-Term Memory (Persistent)
- **Scope**: Across sessions
- **Storage**: Encrypted vault + disk
- **TTL**: Infinite (configurable decay)
- **Max Size**: 500 entries
- **Use Case**: "What does the user prefer?"

### Semantic Search
- **Method**: Token-based cosine similarity
- **Index**: Automatically updated on store
- **Query**: `Memory.SemanticSearch("machine learning", TopN=5)`
- **Result**: Ranked list of similar memories

---

## Encryption Details

### OBELISK Vault

```powershell
Algorithm:     AES-256-CBC
Key Derivation: PBKDF2 (SHA-256)
Iterations:    10,000
Salt:          16 bytes random
IV:            Generated per encryption
Auth:          SHA-256 file hash verification
```

### Storage Format

```
Base64(
  IV (16 bytes) + Encrypted(Data)
)
```

---

## API Usage Tracking

```powershell
# Each query tracked:
$Metrics = @{
    AIQueries = 5
    TokensUsed = 1247
    AvgTokensPerRequest = 249
    Provider = "Perplexity"  # or OpenAI, Anthropic
    CostEstimate = $0.37  # Based on token count
}
```

**Cost Calculation:**
- Perplexity: $0.003 per 1K tokens
- OpenAI: $0.015 per 1K tokens (GPT-4)
- Anthropic: $0.015 per 1K tokens (Claude)

---

## Error Handling & Retry

### 4-Level Retry Strategy

```
Attempt 1: Immediate (0ms wait)
Attempt 2: After 1000ms
Attempt 3: After 2000ms
Final:     After 4000ms

If all fail → Fallback to next AI provider
```

### Fault Tolerance

- ✅ Perplexity fails? Try OpenAI
- ✅ OpenAI fails? Try Anthropic
- ✅ All APIs fail? Use local response
- ✅ Browser not connected? Queue for retry
- ✅ Memory corrupted? Automatic recovery

---

## Session Management

### Lifecycle

```
Startup → Initialize → Ready → Processing → Cleanup
```

### Cleanup on Exit

```powershell
1. Flush all logger buffers
2. Encrypt and save vault
3. Archive old logs (>30 days)
4. Close browser CDP connection
5. Dispose of resources
```

---

## Performance Characteristics

### Startup Time
- UI initialization: ~1-2 seconds
- Module loading: ~0.5 seconds
- Vault initialization: <0.1 seconds
- **Total**: ~2-3 seconds

### Runtime Performance
- AI query latency: 2-8 seconds (Perplexity)
- Memory search: <100ms
- Browser automation: 1-3 seconds per action
- UI responsiveness: 100ms refresh rate

### Memory Usage
- Base process: ~150-200 MB
- Per stored memory: ~2-5 KB
- Vault encryption: Negligible overhead
- Chat history: ~50 KB per 100 messages

---

## Recommended Reading Order

For different audiences:

**New Users:**
1. [QUICK_START.md](../QUICK_START.md)
2. [SETUP_GUIDE.md](../SETUP_GUIDE.md)

**Developers:**
1. [ARCHITECTURE.md](./ARCHITECTURE.md)
2. [MEMORY_SYSTEM.md](./MEMORY_SYSTEM.md)
3. [VAULT_SECURITY.md](./VAULT_SECURITY.md)

**Business/Investors:**
1. [README.md](../README.md)
2. [MONETIZATION.md](./MONETIZATION.md)
3. [PERFORMANCE_TUNING.md](./PERFORMANCE_TUNING.md)

**Contributors:**
1. [ARCHITECTURE.md](./ARCHITECTURE.md)
2. [CONTRIBUTING.md](./CONTRIBUTING.md)
3. [BUILD_PROCESS.md](./BUILD_PROCESS.md)

---

## Support & Community

- **Issues**: [GitHub Issues](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/issues)
- **Discussions**: [GitHub Discussions](https://github.com/POWDER-RANGER/charles-ai-ultra-exe/discussions)
- **Security**: See [VAULT_SECURITY.md](./VAULT_SECURITY.md#reporting-vulnerabilities)

---

## License & Attribution

**Proprietary** - Authorized personal use only

**Author**: Curtis Farrar  
**Company**: G6B Elite Gaming Systems  
**Contact**: [GitHub](https://github.com/POWDER-RANGER)

---

**Version**: 3.0-Ultra  
**Last Updated**: January 2, 2025  
**Status**: 🛸 Production Ready
