-- Drop the check constraint
ALTER TABLE entities DROP CONSTRAINT at_least_one_type;

-- Restore the original check constraint
ALTER TABLE entities ADD CONSTRAINT at_least_one_type
    CHECK (
        type_facial_data_id IS NOT NULL OR 
        type_text_data_id IS NOT NULL OR 
        type_image_data_id IS NOT NULL
    );

-- Drop foreign key constraint
ALTER TABLE entities
    DROP CONSTRAINT fk_entities_type_image_portion;

-- Drop column from entities table
ALTER TABLE entities 
    DROP COLUMN type_image_portion_id;

-- Drop indexes
DROP INDEX idx_entity_type__image_portion_created_at;
DROP INDEX idx_entity_type__image_portion_source_image;

-- Note: trigger was not created in up migration

-- Drop table
DROP TABLE entity_type__image_portion;