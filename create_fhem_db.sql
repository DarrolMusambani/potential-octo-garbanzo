
SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

-- Database: fhem

-- DROP DATABASE fhem;

CREATE DATABASE fhem
    WITH 
    OWNER = fhemUser
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

GRANT TEMPORARY, CONNECT ON DATABASE fhem TO PUBLIC;

GRANT ALL ON DATABASE fhem TO postgres;

GRANT ALL ON DATABASE fhem TO fhemUser;

CREATE SCHEMA fhem;

ALTER SCHEMA fhem OWNER TO fhemUser;

COMMENT ON SCHEMA fhem IS 'standard fhem schema';

SET search_path = fhem, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;
