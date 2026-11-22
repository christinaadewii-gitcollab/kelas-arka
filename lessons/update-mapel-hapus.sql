-- Kelas Arka: daftar mata pelajaran bisa ditambah/dihapus Mama. Aman dijalankan berkali-kali.
-- Supabase > SQL Editor > + (query baru) > tempel semua > Run
alter table settings add column if not exists subjects jsonb;
notify pgrst, 'reload schema';
select id, child_name, subjects from settings;
