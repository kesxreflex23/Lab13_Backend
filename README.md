# UTM Books — Full-stack project (Chapters 9-12 backend + Chapter 13 frontend)

This is your actual project, combined into one place:

- **Books-API/**   — your real, working Slim 4 + PDO + JWT backend (Ch9→Ch12, all in one
  continuous project, exactly as you built it — controllers, repositories, middleware,
  validation, JWT auth, rate limiting, security headers). The only thing added is
  `sql/`, which was missing.
- **frontend/**    — your real Vue 3 + Pinia + Capacitor frontend, untouched (kept separate
  as requested).

Nothing in your PHP or Vue source was rewritten — I only added the missing database layer.

## What was added: Books-API/sql/

| File              | Purpose                                                                 |
|--------------------|--------------------------------------------------------------------------|
| `schema.sql`       | Creates the `books_api` database, the `users` table, and the `books` table — matching the exact columns your `BookRepository.php` / `UserRepository.php` already query (`title`, `author`, `year`, `genre`, `created_by`, `name`, `email`, `password_hash`, `role`). |
| `seed_users.php`   | Run with `php sql/seed_users.php` — prints a correct `password_hash()`-generated INSERT for two demo accounts (admin/member, both password `password`). Run this on YOUR machine so the hash is real and verifiable, not a copy-pasted one. |

## Setup (Books-API)
```bash
cd Books-API
mysql -u root < sql/schema.sql
php sql/seed_users.php          # copy the printed SQL and run it against books_api
composer install
php -S localhost:8000 -t public
```
Your `.env` already has `JWT_SECRET`, `CORS_ALLOWED_ORIGINS` (includes `capacitor://localhost`
for the Android app), and rate-limit settings filled in — no changes needed there.

## Setup (frontend)
```bash
cd frontend
npm install
npm run dev      # http://localhost:5173, talking to Books-API on :8000
```
Capacitor's `android/` folder is included (build caches stripped to keep the zip small —
Android Studio will regenerate them on first open). To rebuild after a frontend change:
```bash
npm run build
npx cap sync android
npx cap open android
```
