FAST BERRY — راه‌اندازی Cloudflare
۱) در Cloudflare یک D1 با نام fastberry-db بسازید و schema.sql را در کنسول D1 اجرا کنید.
۲) یک R2 bucket با نام fastberry-receipts بسازید.
۳) شناسه D1 را در wrangler.toml جایگزین REPLACE_WITH_D1_DATABASE_ID کنید.
۴) در تنظیمات Worker یک Secret با نام ADMIN_TOKEN و مقدار تصادفی قوی بسازید.
۵) Worker را به مخزن وصل کنید؛ Root directory خالی، Build command خالی و Deploy command برابر npx wrangler deploy باشد.
۶) پس از Deploy، از بخش مدیریت توکن را وارد و اطلاعات بانکی را ثبت کنید.
نکته: ورود/ثبت‌نام همکاران در این نسخه پیاده‌سازی نشده است. توکن مدیر را محرمانه نگه دارید.
