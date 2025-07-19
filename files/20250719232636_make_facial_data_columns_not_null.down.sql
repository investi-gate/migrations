-- remove not null constraints
alter table entity_type__facial_data 
alter column id drop not null;

alter table entity_type__facial_data 
alter column created_at drop not null;

alter table entity_type__facial_data 
alter column updated_at drop not null;