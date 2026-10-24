PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS users(phone TEXT PRIMARY KEY,password_hash TEXT NOT NULL,status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','approved','rejected','blocked')),created_at INTEGER NOT NULL,updated_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS admin_sessions(id TEXT PRIMARY KEY,token_hash TEXT NOT NULL UNIQUE,expires_at INTEGER NOT NULL,created_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS user_sessions(id TEXT PRIMARY KEY,token_hash TEXT NOT NULL UNIQUE,user_phone TEXT NOT NULL REFERENCES users(phone) ON DELETE CASCADE,expires_at INTEGER NOT NULL,created_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS login_attempts(bucket TEXT PRIMARY KEY,attempts INTEGER NOT NULL DEFAULT 0,window_start INTEGER NOT NULL,blocked_until INTEGER NOT NULL DEFAULT 0);
CREATE TABLE IF NOT EXISTS settings(key TEXT PRIMARY KEY,value TEXT NOT NULL,updated_at INTEGER NOT NULL);
CREATE TABLE IF NOT EXISTS orders(id TEXT PRIMARY KEY,tracking_code TEXT NOT NULL UNIQUE,user_phone TEXT NOT NULL REFERENCES users(phone),panel_username TEXT NOT NULL,volume INTEGER NOT NULL,amount INTEGER NOT NULL,receipt_key TEXT,status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','reviewing','approved','completed','rejected','cancelled')),admin_note TEXT NOT NULL DEFAULT '',created_at INTEGER NOT NULL,updated_at INTEGER NOT NULL);
CREATE INDEX IF NOT EXISTS idx_users_status ON users(status);
CREATE INDEX IF NOT EXISTS idx_user_sessions_token ON user_sessions(token_hash);
CREATE INDEX IF NOT EXISTS idx_orders_phone ON orders(user_phone);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
CREATE INDEX IF NOT EXISTS idx_orders_tracking ON orders(tracking_code);
INSERT OR IGNORE INTO settings(key,value,updated_at) VALUES('prices','{"100":350000,"200":700000,"300":1150000,"500":1650000,"1000":3250000}',0);
INSERT OR IGNORE INTO settings(key,value,updated_at) VALUES('payment','{"title":"اطلاعات پرداخت","cardNumber":"","accountName":"","instructions":"پس از پرداخت، رسید را در فرم سفارش بارگذاری کنید."}',0);
INSERT OR IGNORE INTO settings(key,value,updated_at) VALUES('content','{"notice":"سامانه همکاران فست بری","partnerText":"برای شرایط همکاری با تیم فست بری هماهنگ کنید."}',0);
INSERT OR IGNORE INTO settings(key,value,updated_at) VALUES('tutorials','[{"title":"آشنایی با پنل","body":"پس از تأیید حساب، با اطلاعات خود وارد فضای همکاران شوید."},{"title":"انتخاب حجم","body":"حجم موردنیاز را از لیست قیمت انتخاب کنید و مبلغ را بررسی نمایید."},{"title":"نام کاربری پنل","body":"نام کاربری مقصد را دقیق وارد کنید تا سفارش اشتباه ثبت نشود."},{"title":"پرداخت","body":"مبلغ دقیق سفارش را طبق اطلاعات پرداخت مدیر واریز کنید."},{"title":"ارسال رسید","body":"رسید واضح و خوانا بارگذاری کنید. فایل‌های غیرمرتبط ارسال نکنید."},{"title":"کد پیگیری","body":"بعد از ثبت سفارش، کد پیگیری را نگه دارید تا وضعیت را مشاهده کنید."},{"title":"پیگیری وضعیت","body":"وضعیت سفارش در بخش سفارشات من و پیگیری سفارش قابل مشاهده است."}]',0);

CREATE TABLE IF NOT EXISTS admin_audit_log(id TEXT PRIMARY KEY,admin_label TEXT NOT NULL,action TEXT NOT NULL,entity_type TEXT NOT NULL,entity_id TEXT NOT NULL,details TEXT NOT NULL DEFAULT '',created_at INTEGER NOT NULL);
CREATE INDEX IF NOT EXISTS idx_audit_created ON admin_audit_log(created_at);
