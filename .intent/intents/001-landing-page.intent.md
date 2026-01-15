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

en: Single-page marketing site with sections: Hero, Problem, Solution, Features, How It Works, Demo, CTA, Footer. Dark theme inspired by GitHub's aesthetic.

Key sections:
- Hero with animated code preview
- Problem cards explaining code review pain points
- Solution section showing Intent file format
- Three viewing modes: Compare, Browse, Story
- Interactive demo mockup

> Decision: Single HTML file for simplicity and fast GitHub Pages deployment.
> fr: Un seul fichier HTML pour la simplicité et un déploiement rapide sur GitHub Pages.

### @pattern:.nav { | Navigation
### fr: Navigation

en: Fixed navbar with logo, section links, language selector, and contact CTA. Backdrop blur effect on scroll.

> Decision: Sticky nav for easy access to sections on long page.

### @pattern:.hero { | Hero Section
### fr: Section Hero

en: Full-viewport hero with gradient text, tagline, and animated code preview showing Intent in action. Includes highlight pills (Fast Setup, Git Native, Multilingual, AI-Ready).

> Decision: Visual demo in hero to immediately show the product value.

### @pattern:.demo-window | Interactive Demo
### fr: Démo Interactive

en: Fake IDE window showing a side-by-side diff with Intent cards. Demonstrates the core product experience without requiring installation.

> Decision: CSS-only mockup to keep the page lightweight and fast-loading.
