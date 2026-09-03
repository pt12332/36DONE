-- Fixes broken product images on iPhone by pointing to the renamed ASCII-safe files.
-- Run once in Supabase: SQL Editor -> New query -> paste this whole file -> Run

update products set images = ARRAY['Tam/tam1.jpg','Tam/tam2.jpg']
  where name = 'Broken Rice';

update products set images = ARRAY['Frozen/banh-da-lon-1.jpg']
  where name = 'Pandan Layer Cake';

update products set images = ARRAY['Frozen/la-chuoi-1.jpg']
  where name = 'Banana Leaves';

update products set images = ARRAY['Frozen/sa-bao-1.jpg']
  where name = 'Shredded Lemongrass';

update products set images = ARRAY['Frozen/sa-cay-1.jpg']
  where name = 'Lemongrass Stalks';
