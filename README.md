# JulianAbeleda Homebrew Tap

Homebrew formulas for Julian Abeleda CLI tools.

## Install DeepSeek Arkey

```bash
brew install JulianAbeleda/tap/deepseek-arkey
```

Or:

```bash
brew tap JulianAbeleda/tap
brew install deepseek-arkey
```

Then configure your DeepSeek API key:

```bash
echo 'export DEEPSEEK_API_KEY="your_deepseek_api_key"' >> ~/.zsh_secrets
source ~/.zshrc
deepseek-arkey login
deepseek-arkey
```
