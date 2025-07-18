-- Drop entities table and indexes
drop index if exists idx_entities_type_text_data_id;
drop index if exists idx_entities_type_facial_data_id;
drop table if exists entities;