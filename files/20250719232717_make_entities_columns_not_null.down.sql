-- remove not null constraints
alter table entities 
alter column id drop not null;

alter table entities 
alter column created_at drop not null;