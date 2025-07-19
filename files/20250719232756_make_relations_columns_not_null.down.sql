-- remove not null constraints
alter table relations 
alter column id drop not null;

alter table relations 
alter column created_at drop not null;