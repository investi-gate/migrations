-- update any existing null values to ensure we can add not null constraints
update entity_type__facial_data 
set id = gen_random_uuid() 
where id is null;

update entity_type__facial_data 
set created_at = current_timestamp 
where created_at is null;

update entity_type__facial_data 
set updated_at = current_timestamp 
where updated_at is null;

-- add not null constraints
alter table entity_type__facial_data 
alter column id set not null;

alter table entity_type__facial_data 
alter column created_at set not null;

alter table entity_type__facial_data 
alter column updated_at set not null;