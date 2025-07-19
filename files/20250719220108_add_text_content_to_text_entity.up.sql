-- add text content column to entity_type__text_data table
alter table entity_type__text_data 
add column content text;

-- add comment to describe the column
comment on column entity_type__text_data.content is 'The actual text content for the text entity';