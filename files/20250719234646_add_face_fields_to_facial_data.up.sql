-- Add face embedding and cropped picture references to facial data entity
ALTER TABLE entity_type__facial_data
    ADD COLUMN face_embedding_id UUID REFERENCES face_embeddings(id) ON DELETE SET NULL,
    ADD COLUMN face_cropped_picture_id UUID REFERENCES media(id) ON DELETE SET NULL;

-- Create indexes for better query performance
CREATE INDEX idx_facial_data_face_embedding_id ON entity_type__facial_data(face_embedding_id);
CREATE INDEX idx_facial_data_face_cropped_picture_id ON entity_type__facial_data(face_cropped_picture_id);