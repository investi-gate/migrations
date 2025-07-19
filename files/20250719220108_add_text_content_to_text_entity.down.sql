-- remove text content column from entity_type__text_data table
alter table entity_type__text_data 
drop column if exists content;