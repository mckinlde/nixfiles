# nixfiles

This is my personal Nix Flake for managing:

- C++/CLI development (Electric Era style)
- Future: Web stack (Node, React, Postgres, Express, VSCode, AWS)
- Future: Data engineering toolchain (Selenium, Python, Bash, Chrome WebDriver)
- Long-term: Personal computing replacements for Google/Apple ecosystem apps

To apply this config:

```bash
nix run .#metalarms
```

---

## ✅ Next steps to activate:

```bash
cd ~/nixfiles
git add .
git commit -m "Initial flake setup for Electric Era + future expansion"
nix run .#metalarms

