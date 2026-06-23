-- =====================================================================
-- Books API — full database schema (Chapters 9-12 combined)
-- Matches the actual code in src/Repositories/BookRepository.php and
-- src/Repositories/UserRepository.php exactly (columns, types, defaults).
--
-- Run with:
--   mysql -u root < sql/schema.sql
-- or open in HeidiSQL and press F9.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS books_api
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE books_api;

-- Drop in dependency order (books references users)
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS users;

-- ---------------------------------------------------------------------
-- users  (Chapter 11: register/login, password_hash, role)
-- ---------------------------------------------------------------------
CREATE TABLE users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(150) NOT NULL,
    email         VARCHAR(190) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('member','admin') NOT NULL DEFAULT 'member',
    created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                      ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- books  (Chapter 10: MySQL/PDO; Chapter 12: created_by for IDOR checks)
-- ---------------------------------------------------------------------
CREATE TABLE books (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    author      VARCHAR(150) NOT NULL,
    year        SMALLINT NOT NULL,
    genre       VARCHAR(80) NOT NULL DEFAULT 'Uncategorised',
    created_by  INT NULL,
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_books_created_by
        FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Seed data — three starter books (Chapter 9/10 demo set)
-- created_by is NULL for now; run sql/seed_users.sql first, then
-- assign ownership with the UPDATE statements at the bottom of this file.
-- ---------------------------------------------------------------------
INSERT INTO books (title, author, year, genre) VALUES
    ('Clean Code',          'Robert C. Martin',   2008, 'Software Engineering'),
    ('Eloquent JavaScript', 'Marijn Haverbeke',   2018, 'Programming'),
    ('Vue.js 3 By Example', 'John Au-Yeung',      2021, 'Web Development');

-- ---------------------------------------------------------------------
-- After running sql/seed_users.php (or seed_users.sql) to create the
-- demo admin/member accounts, assign book ownership like this:
-- ---------------------------------------------------------------------
-- UPDATE books SET created_by = 1 WHERE id IN (1, 3);  -- owned by admin (id 1)
-- UPDATE books SET created_by = 2 WHERE id = 2;        -- owned by member (id 2)
