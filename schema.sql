CREATE TABLE IF NOT EXISTS orders (id TEXT PRIMARY KEY,panel_user TEXT NOT NULL,volume INTEGER NOT NULL,amount INTEGER NOT NULL,receipt_key TEXT NOT NULL,receipt_name TEXT NOT NULL,status TEXT NOT NULL DEFAULT 'در انتظار بررسی',created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS settings (key TEXT PRIMARY KEY,value TEXT NOT NULL,updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
INSERT OR IGNORE INTO settings(key,value) VALUES ('bank_name',''),('bank_account',''),('bank_card',''),('bank_owner','');
