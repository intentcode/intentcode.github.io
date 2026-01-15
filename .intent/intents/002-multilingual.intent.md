---
id: multilingual
from: main
author: claude
date: 2025-01-15
status: active
risk: low
tags: [i18n, ux, accessibility]
files:
  - index.html
  - assets/script.js
  - assets/style.css
---

# Trilingual Support (EN/FR/ES)
# fr: Support Trilingue (EN/FR/ES)

## Summary
en: Added support for English, French, and Spanish with browser language detection and manual toggle.
fr: Ajout du support pour l'anglais, le français et l'espagnol avec détection de la langue du navigateur et basculement manuel.

## Motivation
en: Intent targets international developer teams. Supporting multiple languages from day one shows commitment to accessibility.
fr: Intent cible les équipes de développeurs internationales. Supporter plusieurs langues dès le départ montre un engagement envers l'accessibilité.

## Chunks

### @function:setLang | Language Switching
### fr: Changement de Langue

en: Sets the current language and updates all translatable elements. Uses data attributes (data-en, data-fr, data-es) on HTML elements.

```javascript
function setLang(lang) {
  currentLang = lang;
  updateLanguage();
  updateLangButtons();
  document.documentElement.lang = currentLang;
}
```

> Decision: Data attributes instead of separate HTML files for simpler deployment and instant switching without page reload.
> fr: Attributs data au lieu de fichiers HTML séparés pour un déploiement plus simple et un changement instantané sans rechargement.

### @function:updateLanguage | Content Translation
### fr: Traduction du Contenu

en: Iterates all elements with data-en attribute and updates their text content based on current language. Falls back to English if translation missing.

> Decision: Fallback to English ensures no broken UI if a translation is missing.

### @pattern:const browserLang | Browser Detection
### fr: Détection du Navigateur

en: Detects browser language on page load. If French or Spanish, automatically switches to that language. Otherwise defaults to English.

> Decision: Only auto-switch for supported languages to avoid confusing UX for unsupported locales.

### @pattern:.lang-selector | Language Buttons
### fr: Boutons de Langue

en: Three visible buttons (🇬🇧 EN, 🇫🇷 FR, 🇪🇸 ES) with active state highlighting. Replaced single toggle button for better discoverability.

> Decision: Visible flags and all options shown - users shouldn't have to cycle through to find their language.
> fr: Drapeaux visibles et toutes les options affichées - les utilisateurs ne devraient pas avoir à cycler pour trouver leur langue.

@link @function:updateLangButtons | Updates button active states
