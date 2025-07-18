-- Create relations table
create table if not exists relations (
  id                  uuid                     default gen_random_uuid(),
  created_at          timestamp with time zone default current_timestamp,
  
  -- Subject can be either an entity or another relation
  subject_entity_id   uuid references entities(id),
  subject_relation_id uuid references relations(id),
  
  -- Predicate
  predicate           text not null,
  
  -- Object can be either an entity or another relation
  object_entity_id    uuid references entities(id),
  object_relation_id  uuid references relations(id),
  
  primary key (id),
  
  -- Constraints to ensure valid subject and object
  constraint valid_subject check (
    (subject_entity_id is not null and subject_relation_id is null) or
    (subject_entity_id is null and subject_relation_id is not null)
  ),
  
  constraint valid_object check (
    (object_entity_id is not null and object_relation_id is null) or
    (object_entity_id is null and object_relation_id is not null)
  )
);

-- Create indexes for better query performance
create index idx_relations_subject_entity_id on relations(subject_entity_id);
create index idx_relations_subject_relation_id on relations(subject_relation_id);
create index idx_relations_object_entity_id on relations(object_entity_id);
create index idx_relations_object_relation_id on relations(object_relation_id);
create index idx_relations_predicate on relations(predicate);