# Global Code Standards

## Languages & Frameworks
- TypeScript always — never plain JavaScript
- Use TypeScript strict mode
- React / Next.js for all frontend projects
- Always define prop types with TypeScript interfaces, never use `any`
- Ruby on Rails for all backend projects
  - Use API-only mode (`--api`) only when explicitly stated the app is API-only
  - RSpec for all Rails testing

## Package Manager
- Always use npm (never yarn or pnpm)

## Linting & Formatting
- ESLint for linting
- Stylelint for style linting
- Always respect existing `.eslintrc` and `.stylelintrc` configs

## Styling & Layout
- Tailwind CSS for layout and utility styling
- CSS Modules for component-specific styles (e.g. `Button.module.css`)
- Avoid inline styles and global CSS unless absolutely necessary

## Component Structure
- Functional React components with hooks only — never class components
- Colocate related files within the same folder:
  ```
  components/
    Button/
      Button.tsx
      Button.module.css
      Button.test.tsx
      index.ts
  ```

## Testing
- Jest for unit and integration tests
- Vitest is acceptable for Vite-based projects
- Test files live colocated with the component/module they test (e.g. `Button.test.tsx`)

## State Management
- Redux for global/cross-app state
- React Context for page-scoped or subtree state
- Avoid prop drilling beyond 2 levels — reach for Context first

## Data Fetching
- Use the native `fetch` API for all HTTP/API clients
- Wrap fetch calls in typed async functions, never inline

## Git Conventions
- Commit messages follow Conventional Commits:
  - `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`, `style:`
  - Example: `feat: add user authentication flow`
- Branch names should be a few lowercase words describing the intention:
  - Example: `add-auth-flow`, `fix-cart-total-bug`, `refactor-api-client`
