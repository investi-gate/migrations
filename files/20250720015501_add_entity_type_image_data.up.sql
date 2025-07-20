-- create entity_type__image_data table for storing image-based entity data
create table if not exists entity_type__image_data (
  id         uuid                     default gen_random_uuid() not null,
  created_at timestamp with time zone default current_timestamp not null,
  updated_at timestamp with time zone default current_timestamp not null,
  
  -- reference to the media table for the actual image
  media_id       uuid    not null references media(id) on delete cascade,
  
  -- optional metadata
  caption        text,
  alt_text       text,
  
  -- image analysis results (optional)
  tags           text[], -- array of detected tags/labels
  ocr_text       text,   -- extracted text from ocr if applicable
  
  -- image properties
  width          integer,
  height         integer,
  format         varchar(50), -- e.g., 'jpeg', 'png', 'webp'
  file_size_bytes bigint,
  
  primary key (id)
);

-- create indexes for better query performance
create index if not exists idx_entity_type__image_data_media_id on entity_type__image_data(media_id);
create index if not exists idx_entity_type__image_data_created_at on entity_type__image_data(created_at desc);
create index if not exists idx_entity_type__image_data_tags on entity_type__image_data using gin(tags);

-- note: updated_at should be manually updated by the application layer
-- to maintain consistency with other entity type tables

-- add type_image_data_id column to entities table
alter table entities 
add column type_image_data_id uuid references entity_type__image_data(id) on delete cascade;

-- create index for the new foreign key
create index if not exists idx_entities_type_image_data_id on entities(type_image_data_id);

-- update the constraint to include the new entity type
alter table entities drop constraint at_least_one_type;

alter table entities add constraint at_least_one_type check (
    type_facial_data_id is not null or 
    type_text_data_id is not null or
    type_image_data_id is not null
);