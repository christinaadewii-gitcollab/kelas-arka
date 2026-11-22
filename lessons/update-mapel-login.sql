-- Kelas Arka: tambahan mata pelajaran + login Arka. Aman dijalankan berkali-kali.
-- Supabase > SQL Editor > + (query baru) > tempel semua > Run
alter table lessons add column if not exists subject text;
alter table settings add column if not exists kid_username text;
alter table settings add column if not exists kid_pass_hash text;

update lessons set subject = 'mtk'  where id in ('perkalian','pecahan') and subject is null;
update lessons set subject = 'ipas' where id = 'wujud-benda' and subject is null;
update lessons set subject = 'bing' where id in ('daily-routine','animals-en','healthy-food-1','healthy-food-2') and subject is null;

notify pgrst, 'reload schema';

-- Cek: setiap pelajaran sekarang punya kolom subject
select id, title, subject from lessons order by sort_order;
