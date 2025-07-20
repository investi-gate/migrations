-- revert the constraint to exclude image data type
alter table entities drop constraint at_least_one_type;

alter table entities add constraint at_least_one_type check (
    type_facial_data_id is not null or 
    type_text_data_id is not null
);

-- drop the foreign key column from entities table
drop index if exists idx_entities_type_image_data_id;
alter table entities drop column if exists type_image_data_id;

-- drop the entity_type__image_data table and its dependencies
drop index if exists idx_entity_type__image_data_tags;
drop index if exists idx_entity_type__image_data_created_at;
drop index if exists idx_entity_type__image_data_media_id;
drop table if exists entity_type__image_data;