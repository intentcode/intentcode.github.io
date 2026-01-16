---
id: branding
from: main
author: claude
date: 2025-01-16
status: active
risk: low
tags: [branding, logo, favicon, assets]
files:
  - index.html
  - assets/style.css
  - assets/intent_logo.png
  - assets/intent_logo_text.png
  - assets/favicon.png
  - assets/apple-touch-icon.png
  - docker-compose.yml
---

# Branding & Logo Integration
# fr: Intégration du Branding & Logo

## Summary
en: Integration of Intent brand assets including logo, favicon, and apple-touch-icon. Logo displayed in navbar with proper alignment.
fr: Intégration des assets de marque Intent incluant le logo, favicon et apple-touch-icon. Logo affiché dans la navbar avec un alignement correct.

## Motivation
en: Replace placeholder emoji with official Intent logo for professional branding across the landing page.
fr: Remplacer l'emoji placeholder par le logo officiel Intent pour un branding professionnel sur la landing page.

## Chunks

### @pattern:<a href="#" class="nav-logo"> | Navbar Logo
### fr: Logo de la Navbar

en: Logo displayed in navbar with icon and text "Intent" side by side.
fr: Logo affiché dans la navbar avec l'icône et le texte "Intent" côte à côte.

```html
<a href="#" class="nav-logo">
  <img src="assets/intent_logo.png" alt="Intent" class="logo-icon">
  <span class="logo-text">Intent</span>
</a>
```

en: The logo icon is positioned 2px lower than the text for optical alignment.
fr: L'icône du logo est positionnée 2px plus bas que le texte pour un alignement optique.

> Decision: Logo + text combination for brand recognition. Icon alone was too minimal, full logo-with-text image didn't scale well.
> fr: Combinaison logo + texte pour la reconnaissance de marque. L'icône seule était trop minimaliste, l'image logo-avec-texte ne scalait pas bien.

### @pattern:.nav-logo | Logo CSS Styling
### fr: Styles CSS du Logo

en: Flexbox alignment with gap between icon and text. Icon uses relative positioning for fine-tuned vertical alignment.
fr: Alignement flexbox avec espacement entre l'icône et le texte. L'icône utilise un positionnement relatif pour un alignement vertical précis.

```css
.nav-logo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  text-decoration: none;
}

.logo-icon {
  width: 32px;
  height: 32px;
  object-fit: contain;
  display: block;
  flex-shrink: 0;
  position: relative;
  top: 2px;
}

.logo-text {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--text-primary);
  line-height: 1;
}
```

> Decision: `top: 2px` offset on icon for optical centering with the text baseline.
> fr: Décalage `top: 2px` sur l'icône pour un centrage optique avec la ligne de base du texte.

### @pattern:<link rel="icon" | Favicon Configuration
### fr: Configuration du Favicon

en: Favicon at 64x64 for better resolution on modern displays. Cache-busting query parameter added.
fr: Favicon en 64x64 pour une meilleure résolution sur les écrans modernes. Paramètre de cache-busting ajouté.

```html
<link rel="icon" type="image/png" sizes="64x64" href="assets/favicon.png?v=2">
<link rel="apple-touch-icon" sizes="180x180" href="assets/apple-touch-icon.png">
```

en: Assets:
- `favicon.png` - 64x64 PNG for browser tabs
- `apple-touch-icon.png` - 180x180 PNG for iOS home screen

fr: Assets:
- `favicon.png` - PNG 64x64 pour les onglets navigateur
- `apple-touch-icon.png` - PNG 180x180 pour l'écran d'accueil iOS

> Decision: PNG format for transparency support. Query param `?v=2` forces browser to reload cached favicon.
> fr: Format PNG pour le support de la transparence. Le paramètre `?v=2` force le navigateur à recharger le favicon en cache.

### @pattern:volumes: | Docker Volume Mounts
### fr: Montages de Volumes Docker

en: Development volumes mount local assets folder for live reload without rebuilding container.
fr: Les volumes de développement montent le dossier assets local pour un rechargement live sans reconstruire le container.

```yaml
services:
  landing:
    build: .
    ports:
      - "8080:80"
    volumes:
      - ./index.html:/usr/share/nginx/html/index.html:ro
      - ./assets:/usr/share/nginx/html/assets:ro
      - ./hooks:/usr/share/nginx/html/hooks:ro
```

en: Read-only mounts (`:ro`) for security. Changes to assets are immediately visible without `docker compose build`.
fr: Montages en lecture seule (`:ro`) pour la sécurité. Les changements aux assets sont immédiatement visibles sans `docker compose build`.

> Decision: Folder mounts instead of individual files for easier asset management.
> fr: Montages de dossiers au lieu de fichiers individuels pour une gestion plus facile des assets.
