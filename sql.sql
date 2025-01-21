CREATE TABLE IF NOT EXISTS purchased_packs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(64) NOT NULL,
    pack VARCHAR(50) NOT NULL,
    UNIQUE(identifier, pack)
);