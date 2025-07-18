# migrations, database-schema, entity-relation-tracking, postgresql

## Migration Structure
- Migrations are stored in `files/` directory
- File naming convention: `{timestamp}_{description}.{up|down}.sql`
- Timestamp format: YYYYMMDDHHMMSS (e.g., 20250718195420)
- Use lowercase SQL syntax throughout all migration files

## Core Tables

### Entity Types
- **entity_type__facial_data**: Stores facial recognition data
- **entity_type__text_data**: Stores text-based entity data
- Additional entity types can be added following the pattern: `entity_type__{type_name}`

### Entities Table
- Central table for all entities in the system
- Each entity must reference at least one entity type
- Columns: id (uuid), created_at, type_facial_data_id (FK), type_text_data_id (FK)
- Constraint ensures at least one type is specified

### Relations Table
- Stores relationships between entities and other relations
- Supports both entity-to-entity and relation-to-relation connections
- Subject and object can be either an entity or another relation
- Predicate field describes the relationship type
- Constraints ensure valid subject/object references

## Migration Guidelines
- Always create corresponding `.down.sql` files for rollbacks
- Drop indexes before dropping tables in down migrations
- Use `if not exists` for create statements
- Use `if exists` for drop statements
- Add indexes for all foreign key columns
- Use `gen_random_uuid()` for UUID generation
- Use `timestamp with time zone` for temporal data

## SQL Formatting Style
- Use lowercase for all SQL keywords
- Align column definitions with consistent spacing:
  - Column name, then spaces to align data types
  - Data types aligned at the same column position
  - Default values aligned after data types
- Place `primary key` constraint on a separate line
- Add an empty line before the `primary key` constraint
- Use 2 spaces indentation for table contents
- Example:
  ```sql
  create table if not exists table_name (
    id         uuid                     default gen_random_uuid(),
    created_at timestamp with time zone default current_timestamp,
    name       text                     not null,
    
    primary key (id)
  );
  ```

## Adding New Entity Types
1. Create a new migration file with timestamp
2. Add new entity_type table: `entity_type__{new_type}`
3. Update entities table with new foreign key column: `type_{new_type}_id`
4. Update the `at_least_one_type` constraint to include the new type
5. Add index for the new foreign key column