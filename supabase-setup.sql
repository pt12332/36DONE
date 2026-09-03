-- 36 Food — Supabase setup script
-- Run this once in Supabase: SQL Editor → New query → paste this whole file → Run

-- 1. Products table
create table if not exists products (
  id bigint generated always as identity primary key,
  name text not null,
  name_vn text,
  category text not null default 'Rice',
  origin text not null default 'Vietnam',
  description text,
  images text[] not null default '{}',
  badge text default '',
  featured boolean not null default false,
  moq text,
  sort_order int not null default 0,
  created_at timestamptz not null default now()
);

alter table products enable row level security;

-- Anyone can read products (needed for the public website)
create policy "Public read access" on products
  for select using (true);

-- Only logged-in (admin) users can add/edit/delete
create policy "Authenticated insert" on products
  for insert to authenticated with check (true);
create policy "Authenticated update" on products
  for update to authenticated using (true);
create policy "Authenticated delete" on products
  for delete to authenticated using (true);

-- 2. Storage bucket for product photos
insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

create policy "Public read product images" on storage.objects
  for select using (bucket_id = 'product-images');
create policy "Authenticated upload product images" on storage.objects
  for insert to authenticated with check (bucket_id = 'product-images');
create policy "Authenticated update product images" on storage.objects
  for update to authenticated using (bucket_id = 'product-images');
create policy "Authenticated delete product images" on storage.objects
  for delete to authenticated using (bucket_id = 'product-images');

-- 3. Seed with your current 10 products (keeps using the photos already on your site)
insert into products (name, name_vn, category, origin, description, images, badge, featured, sort_order) values
('Broken Rice','Gạo Tấm','Rice','Vietnam','Premium-grade broken rice available in 5%, 10%, 25%, and 100% broken grades. Carefully sourced and quality-checked for export.',ARRAY['Tam/tam1.jpg','Tam/tam2.jpg'],'Export Ready',true,1),
('Fried Shallot','Hành Phi','Condiments','Vietnam','Crispy, golden-fried shallots in resealable pouches. An essential garnish for Vietnamese, Thai, and Indonesian cuisines.',ARRAY['Fried Shallot/main.jpg','Fried Shallot/Fried-shallot.jpg','Fried Shallot/Fried-shallot-2.jpg','Fried Shallot/Fried-shallot-3.jpg','Fried Shallot/Fried-shallot-4.jpg'],'New',true,2),
('Pho Noodles','Bánh Phở Khô','Noodles','Vietnam','Flat dried rice noodles in 2mm, 5mm and 10mm widths — the authentic base for phở broth. OEM packaging available.',ARRAY['Pho noodles/pho1.jpg','Pho noodles/pho2.jpg'],'',false,3),
('Frozen Chili','Ớt Đông Lạnh','Frozen','Vietnam','IQF frozen whole red chilies, cleaned and sorted. Retains fresh heat and color after thawing. Bulk and retail packs available.',ARRAY['Frozen/frozen-chili1.jpg','Frozen/frozen-chili2.jpg','Frozen/frozen-chili3.jpg','Frozen/frozen-chili4.jpg'],'Frozen',true,4),
('Frozen Fried Banana','Chuối Chiên Đông Lạnh','Frozen','Vietnam','Ready-to-fry battered banana slices, IQF frozen for a crispy, golden snack straight from the freezer.',ARRAY['Frozen/chuoi-chien-dong-lanh1.jpg','Frozen/Chuoi-chien-dong-lanh2.jpg'],'Frozen',false,5),
('Frozen Sticky Corn','Bắp Nếp Nấu','Frozen','Vietnam','Cooked glutinous corn on the cob, IQF frozen and ready to reheat — a naturally sweet, chewy snack.',ARRAY['Frozen/bap.jpg','Frozen/Bap 2.jpg','Frozen/Bap 3.jpg'],'Frozen',false,6),
('Pandan Layer Cake','Bánh Da Lợn','Frozen','Vietnam','Traditional steamed pandan-coconut layer cake, pre-sliced and IQF frozen. Just thaw and serve.',ARRAY['Frozen/banh-da-lon-1.jpg'],'Frozen',false,7),
('Banana Leaves','Lá Chuối','Frozen','Vietnam','Cleaned, vacuum-packed banana leaves for traditional Vietnamese wrapping and steaming — bánh chưng, bánh tét, and more.',ARRAY['Frozen/la-chuoi-1.jpg'],'Frozen',false,8),
('Shredded Lemongrass','Sả Bào','Frozen','Vietnam','Finely sliced lemongrass, IQF frozen and vacuum-packed — ready to use straight from the freezer for marinades and stir-fries.',ARRAY['Frozen/sa-bao-1.jpg'],'Frozen',false,9),
('Lemongrass Stalks','Sả Cây','Frozen','Vietnam','Whole trimmed lemongrass stalks, vacuum-packed and frozen fresh — ideal for broths, marinades, and infusions.',ARRAY['Frozen/sa-cay-1.jpg'],'Frozen',false,10);

-- 4. Newsletter subscribers (anyone can sign up; only you can view/remove them)
create table if not exists subscribers (
  id bigint generated always as identity primary key,
  email text not null unique,
  created_at timestamptz not null default now()
);
alter table subscribers enable row level security;
create policy "Anyone can subscribe" on subscribers
  for insert to anon, authenticated with check (true);
create policy "Authenticated can view subscribers" on subscribers
  for select to authenticated using (true);
create policy "Authenticated can delete subscribers" on subscribers
  for delete to authenticated using (true);
