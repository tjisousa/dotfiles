---
description: Review UI code for Vercel Web Interface Guidelines compliance
argument-hint: <file-or-pattern>
---

# Web Interface Guidelines

Review these files for compliance: $ARGUMENTS

Read files, check against rules below. Output concise but comprehensive. High signal-to-noise.

## Rules

### Accessibility

- Icon-only buttons need `aria-label`
- Form controls need `<label>` or `aria-label`
- Interactive elements need keyboard handlers (`onKeyDown`/`onKeyUp`)
- `<button>` for actions, `<a>`/`<Link>` for navigation
- Images need `alt` or `alt=""` if decorative
- Decorative icons need `aria-hidden="true"`
- Async updates need `aria-live="polite"`
- Use semantic HTML before ARIA
- Headings hierarchical `<h1>`-`<h6>`; include skip link for main content
- `scroll-margin-top` on heading anchors

### Focus States

- Interactive elements need visible focus
- Never `outline-none` without focus replacement
- Use `:focus-visible` over `:focus`
- Group focus with `:focus-within` for compound controls

### Forms

- Inputs need `autocomplete` and meaningful `name`
- Use correct `type` and `inputmode`
- Never block paste
- Labels clickable
- Disable spellcheck on emails, codes, usernames
- Checkboxes/radios: label and control share single hit target
- Submit button stays enabled until request starts; spinner during request
- Errors inline next to fields; focus first error on submit
- Placeholders end with `...` only when the codebase does not support `…`
- `autocomplete="off"` on non-auth fields to avoid password manager triggers
- Warn before navigation with unsaved changes

### Animation

- Honor `prefers-reduced-motion`
- Animate `transform` and `opacity` only
- Never `transition: all`
- Set correct `transform-origin`
- SVG transforms on `<g>` wrapper with `transform-box: fill-box`
- Animations interruptible

### Content Handling

- Text containers handle long content
- Flex children need `min-w-0`
- Handle empty states
- Anticipate short, average, and very long user input

### Images

- `<img>` needs explicit `width` and `height`
- Below-fold images: `loading="lazy"`
- Above-fold critical images: `priority` or `fetchpriority="high"`

### Performance

- Large lists over 50 items: virtualize
- No layout reads in render
- Batch DOM reads/writes
- Prefer uncontrolled inputs when possible
- Add preconnects for CDN/asset domains
- Critical fonts use preload and `font-display: swap`

### Navigation & State

- URL reflects filters, tabs, pagination, and expanded panels
- Links use `<a>`/`<Link>`
- Deep-link stateful UI
- Destructive actions need confirmation modal or undo window

### Touch & Interaction

- `touch-action: manipulation`
- `-webkit-tap-highlight-color` set intentionally
- `overscroll-behavior: contain` in modals/drawers/sheets
- During drag: disable text selection, `inert` dragged elements
- `autoFocus` sparingly

### Safe Areas & Layout

- Full-bleed layouts need `env(safe-area-inset-*)`
- Avoid unwanted scrollbars
- Prefer flex/grid over JS measurement

### Dark Mode & Theming

- `color-scheme: dark` on dark themes
- `<meta name="theme-color">` matches page background
- Native `<select>` has explicit background and color

### Locale & i18n

- Dates/times: use `Intl.DateTimeFormat`
- Numbers/currency: use `Intl.NumberFormat`
- Detect language via `Accept-Language` or `navigator.languages`

### Hydration Safety

- Inputs with `value` need `onChange`
- Guard date/time rendering against hydration mismatch
- `suppressHydrationWarning` only where truly needed

### Anti-patterns

- `user-scalable=no` or `maximum-scale=1`
- `onPaste` with `preventDefault`
- `transition: all`
- `outline-none` without replacement
- Inline click navigation without `<a>`
- `<div>` or `<span>` with click handlers
- Images without dimensions
- Large arrays `.map()` without virtualization
- Form inputs without labels
- Icon buttons without `aria-label`
- Hardcoded date/number formats
- `autoFocus` without clear justification

## Output Format

Group by file. Use `file:line` format. Terse findings. State issue and location; skip explanation unless the fix is non-obvious.

