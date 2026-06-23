<?php
/**
 * Generates ready-to-run INSERT statements for two demo accounts
 * (admin + member), both using the password: password
 *
 * Usage (from the project root, in a Laragon Terminal):
 *   php sql/seed_users.php
 *
 * Then copy the printed SQL into HeidiSQL or:
 *   mysql -u root books_api
 */
$password = 'password';
$hash = password_hash($password, PASSWORD_DEFAULT);

echo "-- Run this against the books_api database:\n\n";
echo "INSERT INTO users (name, email, password_hash, role) VALUES\n";
echo "  ('Demo Admin',  'admin@books.test',  '{$hash}', 'admin'),\n";
echo "  ('Demo Member', 'member@books.test', '{$hash}', 'member');\n\n";
echo "-- After this, assign book ownership (admin = user id 1, member = id 2):\n";
echo "-- UPDATE books SET created_by = 1 WHERE id IN (1, 3);\n";
echo "-- UPDATE books SET created_by = 2 WHERE id = 2;\n\n";
echo "-- Both demo accounts use the password: {$password}\n";
