# AGENTS.md — "Transformando el eje Z"

Static multi-page website (Spanish) for a school mechatronics project (3D printing + Arduino, I.E. Colegio General Santander). Plain HTML files served as-is; no framework, no git, no build tooling, no tests in this repo.

## Critical: prebuilt Tailwind bundle

`assets/main-D3dzY4R9.css` and `assets/main-V_hvr2Cv.js` are **prebuilt, minified, content-hashed bundles** (Vite output; the source project is not here). Consequences:

- **New Tailwind utility classes added to HTML will not work** — the CSS is already compiled and only contains selectors that existed at build time. Reuse classes already present in the HTML/CSS; for anything else, hand-write the rule into the CSS bundle.
- If you rename the bundle files (e.g. to add new CSS), you must update the `<link>`/`<script src>` references in **all 6 HTML pages**, which reference them by hash.
- Do not delete or rewrite the JS bundle. It defines the global functions used via `onclick` across pages: `toggleTheme()`, `toggleMenu()`, `copiar()`, `abrirModal()`, `cerrarModal()` — plus IntersectionObserver logic for `.reveal` scroll animations, `video[data-autodemo]` autoplay, and the header hero video.

## Pages & shared markup

Six pages: `index.html`, `arduino.html`, `impresion3d.html`, `recursos.html`, `evidencias.html`, `equipo.html`.

- **Navbar and footer markup are duplicated in every page.** Any nav/footer change must be replicated in all 6 files: desktop menu, mobile `#navLinks` menu, and the active-page highlight (`bg-blue-600 text-white` class moved to the current page's link in both desktop and mobile lists).
- Every page's `<head>` includes an inline anti-flash script that applies the `dark` class from `localStorage("theme")` before CSS paint. Keep it when editing `<head>`.
- Dark mode = `dark` class on `<html>` + Tailwind `dark:` variants (bundled CSS).
- Lightbox: pages with galleries (evidencias, recursos) use `abrirModal('img-path.webp')` / `cerrarModal()`; Esc key closes via the bundle.

## Conventions

- Content and UI text are in **Spanish** (`lang="es"`); write new copy in Spanish.
- Use relative paths with explicit `./` prefix (`./assets/...`, `./arduino.html`) so the site works from any subpath.
- Images exist in pairs (e.g. `kit-imagen.png` + `kit-imagen.webp`); pages reference the `.webp`. Evidencia photos live under `assets/evidencias/<mes>/`.
- When adding a new image referenced by a lightbox `abrirModal(...)`, prefer the `.webp` variant and keep it inside `assets/`.

## Preview / verification

No build step. Preview locally with any static server, e.g. `python3 -m http.server` from the repo root, then check each changed page (desktop + mobile menu, dark/light toggle). There is no linter, typecheck, or test suite — manual browser check of affected pages is the only verification.
