-- Create media storage table for storing images, pictures, and other media files
CREATE TABLE IF NOT EXISTS media (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    file_name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_size BIGINT NOT NULL,
    mime_type TEXT NOT NULL,
    storage_type TEXT NOT NULL DEFAULT 'local', -- 'local', 's3', 'url', etc.
    url TEXT, -- For external URLs or CDN links
    metadata JSONB DEFAULT '{}', -- Additional metadata like dimensions, format, etc.
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Create indexes for common queries
CREATE INDEX idx_media_created_at ON media(created_at);
CREATE INDEX idx_media_mime_type ON media(mime_type);
CREATE INDEX idx_media_storage_type ON media(storage_type);

-- Create face embeddings table
CREATE TABLE IF NOT EXISTS face_embeddings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    embedding_vector FLOAT[] NOT NULL, -- Store the face embedding as an array of floats
    embedding_dimension INTEGER NOT NULL, -- Dimension of the embedding vector
    model_name TEXT NOT NULL, -- Model used to generate the embedding
    model_version TEXT NOT NULL, -- Version of the model
    metadata JSONB DEFAULT '{}', -- Additional metadata
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);

-- Create indexes for face embeddings
CREATE INDEX idx_face_embeddings_created_at ON face_embeddings(created_at);
CREATE INDEX idx_face_embeddings_model_name ON face_embeddings(model_name);