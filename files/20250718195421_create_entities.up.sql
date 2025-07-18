-- Create entities table
create table if not exists entities (
  id                  uuid                     default gen_random_uuid(),
  created_at          timestamp with time zone default current_timestamp,
  
  -- Foreign keys for different entity types
  type_facial_data_id uuid references entity_type__facial_data(id),
  type_text_data_id   uuid references entity_type__text_data(id),
  
  primary key (id),
  
  -- Ensure at least one type is specified
  constraint at_least_one_type check (
    type_facial_data_id is not null or
    type_text_data_id is not null
  )
);

-- Create indexes for foreign keys
create index idx_entities_type_facial_data_id on entities(type_facial_data_id);
create index idx_entities_type_text_data_id on entities(type_text_data_id);