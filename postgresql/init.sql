CREATE USER beacon WITH ENCRYPTED PASSWORD 'beacon';
GRANT ALL ON SCHEMA public TO beacon;
CREATE DATABASE "beacon-network" OWNER beacon;
