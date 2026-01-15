# Intent Landing Page

Site vitrine pour Intent - l'outil de code review basé sur les intents.

**URL**: https://intentcode.github.io

## Stack

- HTML/CSS/JS statique
- Nginx via Docker pour dev local
- GitHub Pages pour hosting
- Trilingue: EN (défaut), FR, ES

## Commandes

```bash
# Dev local avec Docker
docker compose up

# Accès
http://localhost:8080

# Installer les hooks Claude Code
curl -fsSL https://intentcode.github.io/hooks/install.sh | bash

# Tester les hooks
./hooks/test.sh
```

## Structure

```
landing/
├── index.html              # Page unique (sections: nav, hero, problem, solution, features, demo, cta, footer)
├── assets/
│   ├── style.css           # Styles (dark theme GitHub-like)
│   └── script.js           # Langue toggle, animations
├── hooks/
│   ├── install.sh          # Installateur one-liner pour Claude Code hooks
│   ├── uninstall.sh        # Script de désinstallation
│   └── test.sh             # Suite de tests POSIX (Mac/Linux)
├── prompt.md               # LLM prompt pour générer des intents
├── .intent/                # Documentation Intent du projet
├── Dockerfile              # Image nginx
└── docker-compose.yml
```

## Done

- [x] Page landing responsive avec dark theme
- [x] Support trilingue (EN/FR/ES) avec détection navigateur
- [x] Sélecteur de langue visible (3 boutons avec drapeaux)
- [x] Hero avec démo visuelle
- [x] Section problem/solution/features/how-it-works/demo
- [x] Claude Code hooks installer (curl one-liner)
- [x] Tests POSIX compatibles Mac/Linux
- [x] Intent documentation complète avec chunks détaillés
- [x] Réorganisation dossiers (assets/, hooks/)

## Next Up

### Priorité Haute
- [ ] Logo officiel (remplacer l'emoji ⚡)
- [ ] Favicon
- [ ] Open Graph meta tags (preview social media)
- [ ] Bouton "Copier le prompt" dans la section hooks/LLM

### Contenu & Demo
- [ ] Ajouter un vrai exemple d'intent file interactif dans la section Demo
- [ ] Créer une démo live (iframe ou GIF animé du produit)
- [ ] Ajouter des screenshots réels du produit
- [ ] Page /docs avec documentation complète

### Prompts & LLM
- [ ] Page/section dédiée aux prompts (system prompt, examples)
- [ ] Exemples de prompts pour différents cas d'usage
- [ ] Intégration MCP server pour Intent

### SEO & Analytics
- [ ] Google Analytics ou Plausible
- [ ] Sitemap.xml
- [ ] robots.txt

### Business Model (à décider)
- [ ] Décider: Full open source vs freemium vs SaaS
- [ ] Clarifier la licence (MIT? Apache 2.0?)
- [ ] Pricing page (si SaaS)

### Trust & Social Proof (quand on aura des users)
- [ ] Section "How teams use Intent" avec use cases
- [ ] Témoignages / quotes
- [ ] GitHub stars badge

## Questions Ouvertes

1. **Open Source?**
   - Full open source (tout gratuit, communauté)
   - Open core (core gratuit, features premium payantes)
   - Source available (code visible mais licence restrictive)

2. **Modèle économique?**
   - Gratuit + donations/sponsors
   - Freemium (limite sur repos/users)
   - SaaS (hosted version payante)
   - Enterprise (self-hosted payant)

3. **Intégrations prioritaires?**
   - GitHub App
   - GitLab
   - VS Code extension
   - CLI tool

## Ideas

- Mode "playground" pour tester les intents sans installer
- Générateur d'intent en ligne avec LLM intégré
- Galerie d'exemples d'intents de projets connus
- Comparaison avant/après (PR review classique vs avec Intent)
