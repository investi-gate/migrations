-- Create entity_type__image_portion table
CREATE TABLE entity_type__image_portion (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Reference to the source image entity
    source_image_entity_id UUID NOT NULL,
    
    -- Coordinates and dimensions (in pixels)
    x INTEGER NOT NULL CHECK (x >= 0),
    y INTEGER NOT NULL CHECK (y >= 0),
    width INTEGER NOT NULL CHECK (width > 0),
    height INTEGER NOT NULL CHECK (height > 0),
    
    -- Optional metadata
    label TEXT,
    confidence FLOAT CHECK (confidence >= 0 AND confidence <= 1),
    
    -- Foreign key constraint
    CONSTRAINT fk_source_image_entity
        FOREIGN KEY (source_image_entity_id) 
        REFERENCES entities(id)
        ON DELETE CASCADE
);

-- Create indexes
CREATE INDEX idx_entity_type__image_portion_source_image 
    ON entity_type__image_portion(source_image_entity_id);

CREATE INDEX idx_entity_type__image_portion_created_at 
    ON entity_type__image_portion(created_at);

-- Note: updated_at trigger removed as update_updated_at_column() function doesn't exist
-- The updated_at field will need to be manually updated in the application code

-- Add column to entities table
ALTER TABLE entities 
    ADD COLUMN type_image_portion_id UUID UNIQUE;

-- Add foreign key constraint
ALTER TABLE entities
    ADD CONSTRAINT fk_entities_type_image_portion
        FOREIGN KEY (type_image_portion_id)
        REFERENCES entity_type__image_portion(id)
        ON DELETE CASCADE;

-- Update the check constraint to include image_portion
ALTER TABLE entities DROP CONSTRAINT at_least_one_type;

ALTER TABLE entities ADD CONSTRAINT at_least_one_type
    CHECK (
        type_facial_data_id IS NOT NULL OR 
        type_text_data_id IS NOT NULL OR 
        type_image_data_id IS NOT NULL OR
        type_image_portion_id IS NOT NULL
    );