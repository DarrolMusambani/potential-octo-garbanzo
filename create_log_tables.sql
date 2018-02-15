SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

CREATE SCHEMA fhem;

ALTER SCHEMA fhem OWNER TO fhemUser;

COMMENT ON SCHEMA fhem IS 'standard fhem schema';

SET search_path = fhem, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE current (
    "timestamp" timestamp without time zone,
    device character varying(64),
    type character varying(64),
    event character varying(512),
    reading character varying(64),
    value character varying(128),
    unit character varying(32)
);
ALTER TABLE fhem.current OWNER TO fhem;


CREATE TABLE history (
    "timestamp" timestamp without time zone,
    device character varying(64),
    type character varying(64),
    event character varying(512),
    reading character varying(64),
    value character varying(128),
    unit character varying(32)
);
ALTER TABLE fhem.history OWNER TO fhem;
CREATE INDEX "Search_Idx" ON history USING btree (device, reading, "timestamp");
