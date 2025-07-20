-- Remove indexes
DROP INDEX IF EXISTS idx_facial_data_face_embedding_id;
DROP INDEX IF EXISTS idx_facial_data_face_cropped_picture_id;

-- Remove columns from facial data entity
ALTER TABLE entity_type__facial_data
    DROP COLUMN IF EXISTS face_embedding_id,
    DROP COLUMN IF EXISTS face_cropped_picture_id;