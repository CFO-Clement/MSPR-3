CREATE DATABASE MSPR3;
USE MSPR3;

CREATE TABLE ASSOCIER (
  serial_number VARCHAR(255) NOT NULL,
  incident_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (serial_number, incident_id)
);

CREATE TABLE CLIENT (
  name VARCHAR(255) PRIMARY KEY NOT NULL,
  address VARCHAR(255),
  person_id VARCHAR(255) NOT NULL
);

CREATE TABLE COMPOSANT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  version VARCHAR(10),
  IAC BOOL
);

CREATE TABLE CONTENIR (
  version_id VARCHAR(255) NOT NULL,
  script_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (version_id, script_id)
);

CREATE TABLE DEPLOYER (
  siret CHAR(14) NOT NULL,
  serial_number VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, serial_number)
);

CREATE TABLE GERER (
  siret CHAR(14) NOT NULL,
  client_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, client_name)
);

CREATE TABLE HARVESTER (
  serial_number VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  lan_ip VARCHAR(255),
  vpn_ip VARCHAR(255),
  state VARCHAR(255),
  os_id VARCHAR(255) NOT NULL,
  version_id VARCHAR(255) NOT NULL
);

CREATE TABLE INCIDENT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  date_time TIMESTAMP,
  reason VARCHAR(255),
  person_id VARCHAR(255) NOT NULL
);

CREATE TABLE INCLURE (
  script_id VARCHAR(255) NOT NULL,
  component_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (script_id, component_id)
);

CREATE TABLE OS (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  version VARCHAR(10),
  cpu VARCHAR(42),
  ram VARCHAR(42),
  capacity INTEGER
);

CREATE TABLE PERSON (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(20),
  address VARCHAR(255),
  role VARCHAR(255)
);

CREATE TABLE PRESTATAIRE (
  siret CHAR(14) PRIMARY KEY NOT NULL,
  address VARCHAR(255)
);

CREATE TABLE REPRESENTER (
  siret CHAR(14) NOT NULL,
  person_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, person_id)
);

CREATE TABLE SCRIPT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255)
);

CREATE TABLE TRAITER (
  incident_id VARCHAR(255) NOT NULL,
  person_id VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  PRIMARY KEY (incident_id, person_id)
);

CREATE TABLE VERSION (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  version VARCHAR(10)
);

CREATE UNIQUE INDEX idx_person_id ON CLIENT (person_id);

CREATE UNIQUE INDEX idx_person_id ON INCIDENT (person_id);

ALTER TABLE ASSOCIER ADD FOREIGN KEY (serial_number) REFERENCES HARVESTER (serial_number);

ALTER TABLE ASSOCIER ADD FOREIGN KEY (incident_id) REFERENCES INCIDENT (id);

ALTER TABLE CLIENT ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE CONTENIR ADD FOREIGN KEY (version_id) REFERENCES VERSION (id);

ALTER TABLE CONTENIR ADD FOREIGN KEY (script_id) REFERENCES SCRIPT (id);

ALTER TABLE DEPLOYER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE DEPLOYER ADD FOREIGN KEY (serial_number) REFERENCES HARVESTER (serial_number);

ALTER TABLE GERER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE GERER ADD FOREIGN KEY (client_name) REFERENCES CLIENT (name);

ALTER TABLE HARVESTER ADD FOREIGN KEY (os_id) REFERENCES OS (id);

ALTER TABLE HARVESTER ADD FOREIGN KEY (version_id) REFERENCES VERSION (id);

ALTER TABLE INCIDENT ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE INCLURE ADD FOREIGN KEY (script_id) REFERENCES SCRIPT (id);

ALTER TABLE INCLURE ADD FOREIGN KEY (component_id) REFERENCES COMPOSANT (id);

ALTER TABLE REPRESENTER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE REPRESENTER ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE TRAITER ADD FOREIGN KEY (incident_id) REFERENCES INCIDENT (id);

ALTER TABLE TRAITER ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);


-- Insertion de donn\u00e9es dans les tables
INSERT INTO "PERSON" ("id", "name", "email", "phone", "address", "role") VALUES
('P001', 'John Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'Admin'),
('P002', 'Jane Smith', 'jane.smith@example.com', '0987654321', '456 Elm St', 'User'),
('P003', 'Alice Johnson', 'alice.johnson@example.com', '1122334455', '789 Maple St', 'Support'),
('P004', 'Bob Brown', 'bob.brown@example.com', '6677889900', '101 Pine St', 'Technician'),
('P005', 'Carol White', 'carol.white@example.com', '2233445566', '202 Oak St', 'Developer');

INSERT INTO "CLIENT" ("name", "address", "person_id") VALUES
('ClientA', '789 Oak St', 'P001'),
('ClientB', '101 Pine St', 'P002'),
('ClientC', '202 Birch St', 'P003'),
('ClientD', '303 Cedar St', 'P004'),
('ClientE', '404 Spruce St', 'P005');

INSERT INTO "COMPOSANT" ("id", "name", "version", "IAC") VALUES
('C001', 'Component1', 'v1.0', TRUE),
('C002', 'Component2', 'v2.1', FALSE),
('C003', 'Component3', 'v1.5', TRUE),
('C004', 'Component4', 'v3.0', FALSE),
('C005', 'Component5', 'v2.5', TRUE);

INSERT INTO "SCRIPT" ("id", "name") VALUES
('S001', 'Script1'),
('S002', 'Script2'),
('S003', 'Script3'),
('S004', 'Script4'),
('S005', 'Script5');

INSERT INTO "VERSION" ("id", "version") VALUES
('V001', '1.0.0'),
('V002', '1.1.0'),
('V003', '1.2.0'),
('V004', '2.0.0'),
('V005', '2.1.0');

INSERT INTO "HARVESTER" ("serial_number", "name", "lan_ip", "vpn_ip", "state", "os_id", "version_id") VALUES
('H001', 'Harvester1', '192.168.1.1', '10.0.0.1', 'active', 'OS001', 'V001'),
('H002', 'Harvester2', '192.168.1.2', '10.0.0.2', 'inactive', 'OS002', 'V002'),
('H003', 'Harvester3', '192.168.1.3', '10.0.0.3', 'active', 'OS003', 'V003'),
('H004', 'Harvester4', '192.168.1.4', '10.0.0.4', 'inactive', 'OS004', 'V004'),
('H005', 'Harvester5', '192.168.1.5', '10.0.0.5', 'active', 'OS005', 'V005');

INSERT INTO "OS" ("id", "name", "version", "cpu", "ram", "capacity") VALUES
('OS001', 'Linux', '5.4', 'x86_64', '16GB', 500),
('OS002', 'Windows', '10', 'x86_64', '8GB', 250),
('OS003', 'MacOS', '11', 'arm64', '16GB', 512),
('OS004', 'Ubuntu', '20.04', 'x86_64', '32GB', 1024),
('OS005', 'CentOS', '7', 'x86_64', '64GB', 2048);

INSERT INTO "INCIDENT" ("id", "date_time", "reason", "person_id") VALUES
('I001', '2024-07-04 12:00:00', 'Network Failure', 'P001'),
('I002', '2024-07-05 14:30:00', 'Software Bug', 'P002'),
('I003', '2024-07-06 09:15:00', 'Hardware Malfunction', 'P003'),
('I004', '2024-07-07 11:45:00', 'Security Breach', 'P004'),
('I005', '2024-07-08 16:00:00', 'Data Corruption', 'P005');

INSERT INTO "PRESTATAIRE" ("siret", "address") VALUES
('12345678901234', 'Supplier Address 1'),
('23456789012345', 'Supplier Address 2'),
('34567890123456', 'Supplier Address 3'),
('45678901234567', 'Supplier Address 4'),
('56789012345678', 'Supplier Address 5');

INSERT INTO "ASSOCIER" ("serial_number", "incident_id") VALUES
('H001', 'I001'),
('H002', 'I002'),
('H003', 'I003'),
('H004', 'I004'),
('H005', 'I005');

INSERT INTO "CONTENIR" ("version_id", "script_id") VALUES
('V001', 'S001'),
('V002', 'S002'),
('V003', 'S003'),
('V004', 'S004'),
('V005', 'S005');

INSERT INTO "D\u00c9PLOYER" ("siret", "serial_number") VALUES
('12345678901234', 'H001'),
('23456789012345', 'H002'),
('34567890123456', 'H003'),
('45678901234567', 'H004'),
('56789012345678', 'H005');

INSERT INTO "G\u00c9RER" ("siret", "client_name") VALUES
('12345678901234', 'ClientA'),
('23456789012345', 'ClientB'),
('34567890123456', 'ClientC'),
('45678901234567', 'ClientD'),
('56789012345678', 'ClientE');

INSERT INTO "INCLURE" ("script_id", "component_id") VALUES
('S001', 'C001'),
('S002', 'C002'),
('S003', 'C003'),
('S004', 'C004'),
('S005', 'C005');

INSERT INTO "REPR\u00c9SENTER" ("siret", "person_id") VALUES
('12345678901234', 'P001'),
('23456789012345', 'P002'),
('34567890123456', 'P003'),
('45678901234567', 'P004'),
('56789012345678', 'P005');

INSERT INTO "TRAITER" ("incident_id", "person_id", "role") VALUES
('I001', 'P001', 'Technician'),
('I002', 'P002', 'Developer'),
('I003', 'P003', 'Support'),
('I004', 'P004', 'Admin'),
('I005', 'P005', 'User');

-- Cr\u00e9ation des utilisateurs
CREATE USER 'superuser'@'localhost' IDENTIFIED BY 'super_secure_password';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonly_secure_password';
CREATE USER 'readwrite_user'@'localhost' IDENTIFIED BY 'readwrite_secure_password';

-- Attribution des privil\u00e8ges
GRANT ALL PRIVILEGES ON mydatabase.* TO 'superuser'@'localhost';
GRANT SELECT ON mydatabase.* TO 'readonly_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydatabase.* TO 'readwrite_user'@'localhost';

-- Appliquer les changements
FLUSH PRIVILEGES;


CREATE OR REPLACE FUNCTION validate_harvester_state() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.state NOT IN ('Active', 'Inactive', 'Maintenance') THEN
    RAISE EXCEPTION 'Invalid state value: %', NEW.state;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_harvester_insert_update
BEFORE INSERT OR UPDATE ON HARVESTER
FOR EACH ROW EXECUTE FUNCTION validate_harvester_state();



CREATE OR REPLACE FUNCTION handle_prestataire_delete() RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM D\u00c9PLOYER WHERE siret = OLD.siret;
  DELETE FROM G\u00c9RER WHERE siret = OLD.siret;
  DELETE FROM REPR\u00c9SENTER WHERE siret = OLD.siret;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_prestataire_delete
BEFORE DELETE ON PRESTATAIRE
FOR EACH ROW EXECUTE FUNCTION handle_prestataire_delete();
