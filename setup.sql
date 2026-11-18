-- Kelas Arka: jalankan sekali di Supabase > SQL Editor > New query > Run
create table if not exists lessons (
  id text primary key, title text not null, emoji text, color text,
  sort_order int default 99, lang text default 'id',
  pages jsonb default '[]', questions jsonb default '[]');
create table if not exists results (
  id uuid primary key default gen_random_uuid(), created_at timestamptz default now(),
  lesson_id text, lesson_title text, lesson_emoji text,
  score int check (score between 0 and 100), correct int, total int, stars int, answers jsonb);
create table if not exists settings (id text primary key, child_name text, message text);

alter table lessons enable row level security;
alter table results enable row level security;
alter table settings enable row level security;

-- Semua orang (Arka) boleh membaca pelajaran & pesan; hanya Mama (sudah login) yang boleh mengubah.
create policy "baca pelajaran" on lessons for select using (true);
create policy "mama ubah pelajaran" on lessons for all to authenticated using (true) with check (true);
create policy "baca pengaturan" on settings for select using (true);
create policy "mama ubah pengaturan" on settings for all to authenticated using (true) with check (true);
-- Arka boleh mengirim nilai; hanya Mama yang boleh melihat & menghapus nilai.
create policy "kirim nilai" on results for insert with check (true);
create policy "mama lihat nilai" on results for select to authenticated using (true);
create policy "mama hapus nilai" on results for delete to authenticated using (true);

insert into settings (id, child_name, message) values ('home','Arka','Semangat belajar ya, Nak! Mama sayang Arka. ❤️')
  on conflict (id) do nothing;
insert into lessons (id,title,emoji,color,sort_order,lang,pages,questions) values
('perkalian','Perkalian Seru','✖️','coral',1,'id',$j$[{"emoji": "🍪🍪🍪 🍪🍪🍪", "text": "Perkalian adalah penjumlahan berulang.\n2 piring, masing-masing 3 kue:\n3 + 3 = 6, jadi 2 × 3 = 6."}, {"emoji": "🔄", "text": "Urutan bisa ditukar dan hasilnya sama.\n4 × 5 = 20 dan 5 × 4 = 20."}, {"emoji": "0️⃣ 1️⃣", "text": "Angka apa pun dikali 1 hasilnya angka itu sendiri.\nAngka apa pun dikali 0 hasilnya 0."}]$j$::jsonb,$j$[{"q": "3 × 4 = ?", "options": ["7", "12", "10", "14"], "answer": 1}, {"q": "5 + 5 + 5 sama dengan …", "options": ["3 × 5", "5 × 5", "5 + 3"], "answer": 0}, {"q": "7 × 0 = ?", "options": ["7", "0", "1"], "answer": 1}, {"q": "6 × 3 = ?", "options": ["18", "16", "9", "21"], "answer": 0}, {"q": "Ada 4 kotak pensil. Tiap kotak berisi 6 pensil. Berapa semua pensil?", "options": ["10", "20", "24", "30"], "answer": 2}, {"q": "8 × 5 = ?", "options": ["35", "40", "45", "13"], "answer": 1}]$j$::jsonb),
('pecahan','Mengenal Pecahan','🍕','sun',2,'id',$j$[{"emoji": "🍕", "text": "Pecahan adalah bagian dari satu benda utuh yang dibagi sama besar."}, {"emoji": "🌓", "text": "Satu benda dibagi 2 sama besar.\nSatu bagiannya disebut setengah, ditulis 1/2."}, {"emoji": "🍰🍰🍰🍰", "text": "Kue dibagi 4 sama besar.\nSatu bagian = 1/4 (seperempat).\nDua bagian = 2/4, sama dengan 1/2."}]$j$::jsonb,$j$[{"q": "Pizza dibagi 2 sama besar. Satu bagian disebut …", "options": ["1/2", "1/4", "2/1"], "answer": 0}, {"q": "Roti dibagi 4 sama besar, Arka makan 1. Pecahannya …", "options": ["1/2", "1/4", "4/1"], "answer": 1}, {"q": "Mana yang lebih besar?", "options": ["1/2", "1/4"], "answer": 0}, {"q": "2/4 sama dengan …", "options": ["1/4", "1/2", "1"], "answer": 1}, {"q": "Semangka dibagi 3 sama besar. Satu bagiannya …", "options": ["1/3", "1/2", "3/1"], "answer": 0}]$j$::jsonb),
('daily-routine','My Daily Routine','⏰','ocean',3,'en',$j$[{"emoji": "🌅", "text": "I wake up at six o'clock.\nThen I take a bath and brush my teeth."}, {"emoji": "🍳", "text": "I eat breakfast at half past six.\nI go to school at seven o'clock."}, {"emoji": "📚", "text": "In the afternoon, I do my homework.\nAt night, I go to bed at nine o'clock."}]$j$::jsonb,$j$[{"q": "What time does he wake up?", "options": ["🕕 Six o'clock", "🕘 Nine o'clock", "🕖 Seven o'clock"], "answer": 0}, {"q": "\"Sarapan\" in English is …", "options": ["Lunch", "Breakfast", "Dinner"], "answer": 1}, {"q": "I ___ my teeth.", "options": ["brush", "eat", "sleep"], "answer": 0}, {"q": "When does he do his homework?", "options": ["In the morning", "In the afternoon", "At midnight"], "answer": 1}, {"q": "\"Half past six\" is …", "options": ["6:30", "6:15", "7:30"], "answer": 0}]$j$::jsonb),
('wujud-benda','Wujud Benda','🧊','teal',4,'id',$j$[{"emoji": "🧱", "text": "Benda padat bentuknya tetap.\nContoh: batu, buku, pensil."}, {"emoji": "🥛", "text": "Benda cair bentuknya mengikuti wadah.\nContoh: air, susu, minyak."}, {"emoji": "🎈", "text": "Benda gas memenuhi ruangan dan biasanya tidak terlihat.\nContoh: udara di dalam balon."}, {"emoji": "🧊➡️💧", "text": "Wujud benda bisa berubah.\nEs batu yang dipanaskan mencair menjadi air."}]$j$::jsonb,$j$[{"q": "Batu termasuk benda …", "options": ["Padat", "Cair", "Gas"], "answer": 0}, {"q": "Benda yang bentuknya mengikuti wadah adalah benda …", "options": ["Padat", "Cair", "Gas"], "answer": 1}, {"q": "Udara di dalam balon adalah benda …", "options": ["Cair", "Gas", "Padat"], "answer": 1}, {"q": "Es batu yang dibiarkan di luar akan …", "options": ["Membeku", "Mencair", "Menguap jadi batu"], "answer": 1}, {"q": "Mana yang termasuk benda cair?", "options": ["🥛 Susu", "📕 Buku", "✏️ Pensil"], "answer": 0}]$j$::jsonb),
('animals-en','Animals Around Us','🦒','grass',5,'en',$j$[{"emoji": "🦒", "text": "A giraffe has a very long neck.\nIt eats leaves from tall trees."}, {"emoji": "🐬", "text": "A dolphin lives in the sea.\nIt is smart and can jump high."}, {"emoji": "🦉", "text": "An owl sleeps in the day and is awake at night."}]$j$::jsonb,$j$[{"q": "Which animal has a long neck?", "options": ["🦒 Giraffe", "🐬 Dolphin", "🦉 Owl"], "answer": 0}, {"q": "Where does a dolphin live?", "options": ["In the forest", "In the sea", "In the desert"], "answer": 1}, {"q": "An owl is awake at …", "options": ["night", "noon", "morning"], "answer": 0}, {"q": "\"Leher\" in English is …", "options": ["Leg", "Neck", "Nose"], "answer": 1}]$j$::jsonb)
on conflict (id) do nothing;
