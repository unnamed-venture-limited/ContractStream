DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'super') THEN
        CREATE ROLE super WITH LOGIN PASSWORD 'isGod';
    END IF;
END
$$;

SELECT insert_user('Jay', 'isPleb')

