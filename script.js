const prices = {100:350000,200:700000,300:1150000,500:1650000,1000:3250000};
const fa = n => Number(n).toLocaleString('fa-IR');
const $ = id => document.getElementById(id);
$('readCheck').addEventListener('change', e => $('enterBtn').disabled = !e.target.checked);
function enterSite(){ if(!$('readCheck').checked)return; $('intro').classList.add('hidden'); showPage('home'); }
function showPage(id){
  ['home','buy','prices','partner','tutorials','orders','track','account'].forEach(p=>$(p).classList.add('hidden'));
  $(id).classList.remove('hidden');
  if(id==='buy'){ $('infraCard').classList.remove('hidden'); $('buyForm').classList.add('hidden'); }
  window.scrollTo({top:0,behavior:'smooth'});
}
function updateAmount(){ $('amount').textContent = fa(prices[$('volume').value])+' تومان'; }
function toast(message){ $('toast').textContent=message; $('toast').classList.remove('hidden'); setTimeout(()=> $('toast').classList.add('hidden'),3200); }
function submitDemoOrder(){
  if(!$('panelUser').value.trim()){toast('لطفاً نام کاربری پنل را وارد کنید.');return;}
  if(!$('receipt').files.length){toast('لطفاً فایل رسید پرداخت را انتخاب کنید.');return;}
  toast('این نسخه نمایشی است؛ برای ثبت واقعی باید سامانه سفارش متصل شود.');
}
function trackDemo(){
 const code=$('trackCode').value.trim(); const box=$('trackResult');
 box.classList.remove('hidden');
 box.textContent=code ? 'کد '+code+' وارد شد. پیگیری سفارش پس از اتصال سامانه فعال می‌شود.' : 'لطفاً کد پیگیری را وارد کنید.';
}
function accountDemo(type){
 const phone=$('phone').value.trim(), pass=$('password').value;
 const box=$('accountMessage'); box.classList.remove('hidden');
 if(!phone || !pass){box.textContent='لطفاً شماره موبایل و رمز عبور را وارد کنید.';return;}
 if(type==='signup') box.textContent='همکار گرامی، ثبت‌نام شما با موفقیت انجام شد. برای استفاده و ورود به سایت، لازم است حساب کاربری شما توسط تیم فست بری تأیید شود. پس از تأیید، امکان ورود و استفاده از امکانات سایت برای شما فعال خواهد شد. با تشکر، مجموعه فست بری 🫐 (پیام نمایشی؛ ثبت‌نام هنوز ذخیره نمی‌شود.)';
 else box.textContent='ورود واقعی در این نسخه فعال نیست. برای حفاظت از حساب‌ها باید سامانه احراز هویت امن متصل شود.';
}
