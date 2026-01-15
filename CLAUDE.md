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
```

## Structure

```
landing/
├── index.html      # Page unique
├── style.css       # Styles (dark theme GitHub-like)
├── script.js       # Langue toggle, animations
├── Dockerfile      # Image nginx
└── docker-compose.yml
```

## Next Up

### Contenu & Demo
- [ ] Ajouter un vrai exemple d'intent file interactif dans la section Demo
- [ ] Créer une démo live (iframe ou GIF animé du produit)
- [ ] Ajouter des screenshots réels du produit

### Prompts & LLM
- [ ] Bouton "Copier le prompt" pour générer des intents avec un LLM
- [ ] Page/section dédiée aux prompts (system prompt, examples)
- [ ] Exemples de prompts pour différents cas d'usage

### Business Model
- [ ] Décider: Full open source vs freemium vs SaaS
- [ ] Clarifier la licence (MIT? Apache 2.0?)
- [ ] Définir ce qui est gratuit vs payant (si applicable)
- [ ] Pricing page (si SaaS)

### Branding
- [ ] Logo officiel (remplacer l'emoji ⚡)
- [ ] Favicon
- [ ] Open Graph meta tags (preview social media)
- [ ] Twitter card

### Trust & Social Proof
- [ ] Section "How teams use Intent" avec use cases
- [ ] Témoignages / quotes (quand on aura des users)
- [ ] Logos d'entreprises (quand on aura des clients)
- [ ] GitHub stars badge

### Pages Additionnelles
- [ ] /docs - Documentation complète
- [ ] /blog - Articles, tutoriels
- [ ] /changelog - Historique des versions
- [ ] /pricing (si SaaS)

### SEO & Analytics
- [ ] Google Analytics ou Plausible
- [ ] Meta descriptions optimisées
- [ ] Sitemap.xml
- [ ] robots.txt

### Intégrations
- [ ] Waitlist / Newsletter signup (Mailchimp, Buttondown)
- [ ] Chat support (Crisp, Intercom)
- [ ] Formulaire de contact plus élaboré

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

3. **Target audience?**
   - Développeurs individuels
   - Petites équipes
   - Entreprises
   - Tous?

4. **Intégrations prioritaires?**
   - GitHub App
   - GitLab
   - VS Code extension
   - CLI tool

## Ideas

- Mode "playground" pour tester les intents sans installer
- Générateur d'intent en ligne avec LLM intégré
- Galerie d'exemples d'intents de projets connus
- Comparaison avant/après (PR review classique vs avec Intent)
