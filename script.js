// Intent Landing Page - Language Toggle & Interactions

let currentLang = 'en';

function toggleLang() {
  currentLang = currentLang === 'en' ? 'fr' : 'en';
  updateLanguage();

  // Update button text
  document.querySelector('.lang-current').textContent = currentLang.toUpperCase();

  // Update HTML lang attribute
  document.documentElement.lang = currentLang;
}

function updateLanguage() {
  // Update all elements with data-en and data-fr attributes
  document.querySelectorAll('[data-en][data-fr]').forEach(el => {
    const text = el.getAttribute(`data-${currentLang}`);
    if (text) {
      el.textContent = text;
    }
  });
}

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      target.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      });
    }
  });
});

// Intersection Observer for scroll animations
const observerOptions = {
  threshold: 0.1,
  rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
    }
  });
}, observerOptions);

// Observe elements for animation
document.querySelectorAll('.problem-card, .feature-card, .step, .demo-window').forEach(el => {
  el.style.opacity = '0';
  el.style.transform = 'translateY(30px)';
  el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
  observer.observe(el);
});

// Add visible class styles dynamically
const style = document.createElement('style');
style.textContent = `
  .visible {
    opacity: 1 !important;
    transform: translateY(0) !important;
  }
`;
document.head.appendChild(style);

// Demo tab interaction (visual only)
document.querySelectorAll('.demo-tab').forEach(tab => {
  tab.addEventListener('click', function() {
    document.querySelectorAll('.demo-tab').forEach(t => t.classList.remove('active'));
    this.classList.add('active');
  });
});

// Navbar background on scroll
const nav = document.querySelector('.nav');
let lastScroll = 0;

window.addEventListener('scroll', () => {
  const currentScroll = window.pageYOffset;

  if (currentScroll > 100) {
    nav.style.background = 'rgba(13, 17, 23, 0.95)';
  } else {
    nav.style.background = 'rgba(13, 17, 23, 0.8)';
  }

  lastScroll = currentScroll;
});

// Detect browser language and set initial
const browserLang = navigator.language.split('-')[0];
if (browserLang === 'fr') {
  currentLang = 'fr';
  document.querySelector('.lang-current').textContent = 'FR';
  document.documentElement.lang = 'fr';
  updateLanguage();
}

// Add stagger animation to grid items
function addStaggerAnimation(selector, baseDelay = 0) {
  document.querySelectorAll(selector).forEach((el, index) => {
    el.style.transitionDelay = `${baseDelay + index * 0.1}s`;
  });
}

addStaggerAnimation('.problem-card');
addStaggerAnimation('.feature-card');
addStaggerAnimation('.step', 0.1);

// Parallax effect on hero
window.addEventListener('scroll', () => {
  const scrolled = window.pageYOffset;
  const heroVisual = document.querySelector('.hero-visual');
  if (heroVisual && scrolled < window.innerHeight) {
    heroVisual.style.transform = `translateY(${scrolled * 0.1}px)`;
  }
});

console.log('⚡ Intent - Code Review, Reimagined');
