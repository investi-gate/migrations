-- update any existing null values to ensure we can add not null constraints
update entities 
set id = gen_random_uuid() 
where id is null;

update entities 
set created_at = current_timestamp 
where created_at is null;

-- add not null constraints
alter table entities 
alter column id set not null;

alter table entities 
alter column created_at set not null;