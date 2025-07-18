-- Create entity type tables
create table if not exists entity_type__facial_data (
  id         uuid                     default gen_random_uuid(),
  created_at timestamp with time zone default current_timestamp,
  updated_at timestamp with time zone default current_timestamp,

  primary key (id)
);

create table if not exists entity_type__text_data (
  id         uuid                     default gen_random_uuid(),
  created_at timestamp with time zone default current_timestamp,
  updated_at timestamp with time zone default current_timestamp,

  primary key (id)
);