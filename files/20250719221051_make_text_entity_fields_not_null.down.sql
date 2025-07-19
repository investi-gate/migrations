-- remove not null constraints
alter table entity_type__text_data 
alter column content drop not null;

alter table entity_type__text_data 
alter column created_at drop not null;

alter table entity_type__text_data 
alter column updated_at drop not null;