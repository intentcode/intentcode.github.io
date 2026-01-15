---
id: landing-page
from: main
author: claude
date: 2025-01-15
status: active
risk: low
tags: [marketing, website, static]
files:
  - index.html
  - assets/style.css
  - assets/script.js
---

# Intent Landing Page
# fr: Page d'Accueil Intent

## Summary
en: Static marketing website for Intent, the code review tool that shows the "why" behind code changes.
fr: Site vitrine statique pour Intent, l'outil de revue de code qui montre le "pourquoi" derrière les changements.

## Motivation
en: Need a public-facing website to explain Intent's value proposition and provide installation instructions.
fr: Besoin d'un site public pour expliquer la proposition de valeur d'Intent et fournir les instructions d'installation.

## Chunks

### @pattern:<!DOCTYPE html> | Page Structure
### fr: Structure de la Page

en: Single-page marketing site with 8 main sections in order: Navigation, Hero, Problem, Solution, Features, How It Works, Demo, CTA, Footer.
fr: Site marketing one-page avec 8 sections principales dans l'ordre : Navigation, Hero, Problème, Solution, Fonctionnalités, Comment ça marche, Démo, CTA, Footer.

en: Sections flow:
1. **Nav** - Fixed navigation bar
2. **Hero** - Main headline with visual demo
3. **Problem** - Pain points of code review
4. **Solution** - How Intent solves them
5. **Features** - Three viewing modes
6. **How It Works** - 3-step setup guide
7. **Demo** - Interactive mockup
8. **CTA** - Contact call-to-action
9. **Footer** - Logo and links

fr: Flux des sections:
1. **Nav** - Barre de navigation fixe
2. **Hero** - Titre principal avec démo visuelle
3. **Problem** - Points de douleur de la code review
4. **Solution** - Comment Intent les résout
5. **Features** - Trois modes d'affichage
6. **How It Works** - Guide de configuration en 3 étapes
7. **Demo** - Maquette interactive
8. **CTA** - Appel à l'action contact
9. **Footer** - Logo et liens

> Decision: Single HTML file for simplicity and fast GitHub Pages deployment.
> fr: Un seul fichier HTML pour la simplicité et un déploiement rapide sur GitHub Pages.

### @pattern:<head> | Head Configuration
### fr: Configuration du Head

en: Meta tags and external resources loaded in the head section.
fr: Balises meta et ressources externes chargées dans la section head.

```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Intent - Code Review, Reimagined</title>
<meta name="description" content="Intent brings the 'why' to code review...">
<link rel="stylesheet" href="assets/style.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
```

en: Resources:
- `assets/style.css` - Local stylesheet
- Google Fonts Inter - Primary typeface with 5 weights
- `preconnect` hints for faster font loading

fr: Ressources:
- `assets/style.css` - Feuille de style locale
- Google Fonts Inter - Police principale avec 5 graisses
- Hints `preconnect` pour un chargement plus rapide des polices

> Decision: Inter font chosen for modern, clean look matching GitHub aesthetic.
> fr: Police Inter choisie pour un look moderne et épuré correspondant à l'esthétique GitHub.

### @pattern:<nav class="nav"> | Navigation Bar
### fr: Barre de Navigation

en: Fixed navbar with logo, section links, language selector, and contact CTA.
fr: Barre de navigation fixe avec logo, liens de sections, sélecteur de langue et CTA contact.

```html
<nav class="nav">
  <div class="nav-container">
    <div class="nav-logo">⚡ Intent</div>
    <div class="nav-links">
      <a href="#features">Features</a>
      <a href="#how-it-works">How it works</a>
      <a href="#demo">Demo</a>
    </div>
    <div class="nav-actions">
      <div class="lang-selector">...</div>
      <a href="mailto:..." class="btn btn-primary">Contact Us</a>
    </div>
  </div>
</nav>
```

en: Structure:
- `.nav-logo` - Emoji icon + text
- `.nav-links` - Anchor links to page sections
- `.lang-selector` - EN/FR/ES toggle buttons
- `.btn-primary` - Contact email link

fr: Structure:
- `.nav-logo` - Icône emoji + texte
- `.nav-links` - Liens ancres vers les sections
- `.lang-selector` - Boutons de toggle EN/FR/ES
- `.btn-primary` - Lien email de contact

> Decision: Sticky nav for easy access to sections on long page. Backdrop blur effect on scroll via CSS.
> fr: Nav sticky pour un accès facile aux sections sur une longue page. Effet de flou d'arrière-plan au scroll via CSS.

### @pattern:<section class="hero"> | Hero Section
### fr: Section Hero

en: Full-viewport hero with gradient title, tagline, CTAs, visual demo, and feature highlights.
fr: Hero plein écran avec titre en dégradé, slogan, CTAs, démo visuelle et highlights de fonctionnalités.

en: Components:
- `.hero-badge` - "Open Source" label
- `.hero-title` - Main headline with `.gradient-text` span
- `.hero-subtitle` - Value proposition text
- `.hero-cta` - Two buttons (primary + secondary)
- `.hero-visual` - Fake IDE window showing Intent in action
- `.hero-highlights` - 4 feature pills (Fast Setup, Git Native, etc.)

fr: Composants:
- `.hero-badge` - Label "Open Source"
- `.hero-title` - Titre principal avec span `.gradient-text`
- `.hero-subtitle` - Texte de proposition de valeur
- `.hero-cta` - Deux boutons (primaire + secondaire)
- `.hero-visual` - Fausse fenêtre IDE montrant Intent en action
- `.hero-highlights` - 4 pills de fonctionnalités (Config Rapide, Git Natif, etc.)

> Decision: Visual demo in hero to immediately show the product value without scrolling.
> fr: Démo visuelle dans le hero pour montrer immédiatement la valeur du produit sans scroller.

### @pattern:<div class="visual-window"> | Hero Visual Demo
### fr: Démo Visuelle du Hero

en: Fake IDE window showing a side-by-side view of code diff and intent card.
fr: Fausse fenêtre IDE montrant une vue côte à côte du diff de code et de la carte d'intent.

```html
<div class="visual-window">
  <div class="window-header">
    <div class="window-dots"><span></span><span></span><span></span></div>
    <div class="window-title">review.py</div>
  </div>
  <div class="window-content">
    <div class="visual-split">
      <div class="visual-code"><!-- Code lines --></div>
      <div class="visual-intent"><!-- Intent card --></div>
    </div>
  </div>
</div>
```

en: Elements:
- `.window-dots` - macOS-style traffic lights (red/yellow/green)
- `.window-title` - Filename display
- `.visual-code` - Green highlighted diff lines
- `.visual-intent` - Intent card with title, description, decision

fr: Éléments:
- `.window-dots` - Feux tricolores style macOS (rouge/jaune/vert)
- `.window-title` - Affichage du nom de fichier
- `.visual-code` - Lignes de diff en surbrillance verte
- `.visual-intent` - Carte d'intent avec titre, description, décision

> Decision: CSS-only mockup to keep the page lightweight and fast-loading.
> fr: Maquette CSS-only pour garder la page légère et rapide à charger.

### @pattern:<section class="problem"> | Problem Section
### fr: Section Problème

en: Three cards explaining code review pain points that Intent solves.
fr: Trois cartes expliquant les points de douleur de la code review qu'Intent résout.

en: Cards:
1. **Context is Missing** - Reviewers see what changed, never why
2. **Documentation is Separate** - Knowledge scattered across Notion, Slack, GitHub
3. **Onboarding is Painful** - New members can't understand why code exists

fr: Cartes:
1. **Le Contexte Manque** - Les reviewers voient ce qui a changé, jamais pourquoi
2. **La Documentation est Séparée** - Connaissance éparpillée entre Notion, Slack, GitHub
3. **L'Onboarding est Douloureux** - Les nouveaux ne comprennent pas pourquoi le code existe

```html
<div class="problem-grid">
  <div class="problem-card">
    <div class="problem-icon">🤔</div>
    <h3>Context is Missing</h3>
    <p>Reviewers see what changed...</p>
  </div>
  <!-- 2 more cards -->
</div>
```

> Decision: Three pain points cover the most common complaints about code review.
> fr: Trois points de douleur couvrent les plaintes les plus courantes sur la code review.

### @pattern:<section class="solution"> | Solution Section
### fr: Section Solution

en: Explains Intent's approach with a code example showing an intent file.
fr: Explique l'approche d'Intent avec un exemple de code montrant un fichier intent.

en: Structure:
- `.solution-text` - Description with checklist of features
- `.solution-visual` - Code block showing intent file format

fr: Structure:
- `.solution-text` - Description avec liste de fonctionnalités
- `.solution-visual` - Bloc de code montrant le format de fichier intent

en: Checklist items:
- Chunks: Group related changes with context
- Decisions: Document the rationale behind choices
- Semantic Anchors: Links that survive refactoring
- Multilingual: Native support for FR, EN, ES, DE

fr: Items de la checklist:
- Chunks : Regroupez les changements avec leur contexte
- Décisions : Documentez le raisonnement derrière les choix
- Ancres Sémantiques : Liens qui résistent au refactoring
- Multilingue : Support natif FR, EN, ES, DE

> Decision: Show real intent file syntax to demonstrate simplicity.
> fr: Montrer la vraie syntaxe de fichier intent pour démontrer la simplicité.

### @pattern:<section id="features" class="features"> | Features Section
### fr: Section Fonctionnalités

en: Three cards presenting the viewing modes: Compare, Browse, Story.
fr: Trois cartes présentant les modes d'affichage : Compare, Browse, Story.

en: Modes:
1. **Compare Mode** - Side-by-side diff with intent cards (PR reviews)
2. **Browse Mode** - Full file content with intents visible (codebase exploration)
3. **Story Mode** - Intents as chapters without code (project narrative)

fr: Modes:
1. **Mode Compare** - Diff côte à côte avec cartes d'intent (revues PR)
2. **Mode Browse** - Contenu complet des fichiers avec intents (exploration codebase)
3. **Mode Story** - Intents comme chapitres sans code (narratif du projet)

en: Each card has:
- Icon (⚖️/📖/📚)
- Title and description
- Mini visual preview (CSS-only mockup)

fr: Chaque carte a:
- Icône (⚖️/📖/📚)
- Titre et description
- Mini aperçu visuel (maquette CSS-only)

> Decision: Visual previews help users understand modes at a glance.
> fr: Les aperçus visuels aident les utilisateurs à comprendre les modes d'un coup d'œil.

### @pattern:<section id="how-it-works"> | How It Works Section
### fr: Section Comment ça Marche

en: Three-step guide to using Intent.
fr: Guide en trois étapes pour utiliser Intent.

en: Steps:
1. **Create Intent Files** - Add `.intent/` folder, write markdown
2. **Link to Code** - Use @function:name, @class:Name, @pattern:text
3. **Review with Context** - Open Intent to see diffs with explanations

fr: Étapes:
1. **Créez des Fichiers Intent** - Ajoutez un dossier `.intent/`, écrivez du markdown
2. **Liez au Code** - Utilisez @function:name, @class:Name, @pattern:text
3. **Revoyez avec Contexte** - Ouvrez Intent pour voir les diffs avec explications

```html
<div class="steps">
  <div class="step">
    <div class="step-number">1</div>
    <div class="step-content">
      <h3>Create Intent Files</h3>
      <p>Add a .intent/ folder to your repo...</p>
    </div>
  </div>
  <!-- Steps 2 and 3 -->
</div>
```

> Decision: Numbered steps make the process feel simple and achievable.
> fr: Les étapes numérotées rendent le processus simple et réalisable.

### @pattern:<section id="demo" class="demo"> | Demo Section
### fr: Section Démo

en: Interactive mockup of the Intent UI showing a full PR review experience.
fr: Maquette interactive de l'UI Intent montrant une expérience complète de revue PR.

en: Components:
- `.demo-header` - Window chrome with tabs (Compare/Browse/Story) and branch selector
- `.demo-sidebar` - File tree and intent list
- `.demo-main` - Split view with code diff and intent cards

fr: Composants:
- `.demo-header` - Chrome de fenêtre avec onglets (Compare/Browse/Story) et sélecteur de branche
- `.demo-sidebar` - Arborescence de fichiers et liste d'intents
- `.demo-main` - Vue split avec diff de code et cartes d'intent

en: Demo data:
- Files: `src/auth.py` (modified), `src/validators.py` (added)
- Intents: #001 Authentication (HIGH RISK), #002 Validation (LOW RISK)
- Code: `AuthService.login()` and `create_token()` methods

fr: Données de la démo:
- Fichiers: `src/auth.py` (modifié), `src/validators.py` (ajouté)
- Intents: #001 Authentication (RISQUE ÉLEVÉ), #002 Validation (RISQUE FAIBLE)
- Code: Méthodes `AuthService.login()` et `create_token()`

> Decision: Static mockup with realistic data shows exactly what users will get.
> fr: Maquette statique avec données réalistes montre exactement ce que les utilisateurs obtiendront.

### @pattern:<section class="cta"> | Call-to-Action Section
### fr: Section Appel à l'Action

en: Simple CTA with headline and contact button.
fr: CTA simple avec titre et bouton de contact.

```html
<section class="cta">
  <h2>Interested in Intent?</h2>
  <p>We're building the future of code review...</p>
  <a href="mailto:berenger.ouadi@gmail.com" class="btn btn-large btn-primary">
    ✉️ Contact Us
  </a>
</section>
```

> Decision: Single CTA keeps focus on the primary action (contact).
> fr: Un seul CTA garde le focus sur l'action principale (contact).

### @pattern:<footer class="footer"> | Footer
### fr: Pied de Page

en: Minimal footer with logo, tagline, and contact link.
fr: Footer minimal avec logo, slogan et lien de contact.

en: Content:
- Logo (⚡ Intent)
- Tagline: "Code review, reimagined."
- Contact link
- Credit: "Built with Claude"

fr: Contenu:
- Logo (⚡ Intent)
- Slogan: "Revue de code, réinventée."
- Lien de contact
- Crédit: "Construit avec Claude"

> Decision: Minimal footer - no unnecessary links until we have more pages.
> fr: Footer minimal - pas de liens inutiles tant qu'on n'a pas plus de pages.

### @pattern:data-en="..." data-fr="..." data-es="..." | Trilingual Content
### fr: Contenu Trilingue

en: All user-visible text uses data attributes for EN/FR/ES translations. JavaScript reads these and updates text content based on selected language.
fr: Tout le texte visible utilise des attributs data pour les traductions EN/FR/ES. Le JavaScript lit ces attributs et met à jour le contenu selon la langue sélectionnée.

```html
<h2 data-en="Features" data-fr="Fonctionnalités" data-es="Características">Features</h2>
```

en: The default text inside the tag is English. When language changes, JS updates `textContent` from the appropriate data attribute.
fr: Le texte par défaut dans la balise est en anglais. Quand la langue change, le JS met à jour `textContent` depuis l'attribut data approprié.

@link @function:updateLanguage | Updates all elements with data-en attribute
@link fr: Met à jour tous les éléments avec l'attribut data-en

> Decision: Data attributes instead of separate HTML files for instant switching without page reload.
> fr: Attributs data au lieu de fichiers HTML séparés pour un changement instantané sans rechargement de page.
