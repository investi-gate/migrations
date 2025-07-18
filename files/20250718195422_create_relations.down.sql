-- Drop relations table and indexes
drop index if exists idx_relations_predicate;
drop index if exists idx_relations_object_relation_id;
drop index if exists idx_relations_object_entity_id;
drop index if exists idx_relations_subject_relation_id;
drop index if exists idx_relations_subject_entity_id;
drop table if exists relations;