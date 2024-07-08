Descriptions des Requêtes Principales
1. Récupérer tous les incidents gérés par une personne spécifique
SELECT i.id, i.date_time, i.reason
FROM INCIDENT i
JOIN TRAITER t ON i.id = t.incident_id
WHERE t.person_id = 'specific_person_id';

2. Lister tous les composants inclus dans un script spécifique
SELECT c.id, c.name, c.version, c.IAC
FROM COMPOSANT c
JOIN INCLURE i ON c.id = i.component_id
WHERE i.script_id = 'specific_script_id';

3. Obtenir les détails des harvesters déployés par un prestataire spécifique
SELECT h.serial_number, h.name, h.lan_ip, h.vpn_ip, h.state, o.name AS os_name, v.version AS harvester_version
FROM HARVESTER h
JOIN DÉPLOYER d ON h.serial_number = d.serial_number
JOIN OS o ON h.os_id = o.id
JOIN VERSION v ON h.version_id = v.id
WHERE d.siret = 'specific_siret';


4. Lister les clients gérés par un prestataire spécifique
SELECT c.name, c.address, p.name AS person_name, p.email, p.phone
FROM CLIENT c
JOIN GÉRER g ON c.name = g.client_name
JOIN PERSON p ON c.person_id = p.id
WHERE g.siret = 'specific_siret';

5. Récupérer tous les incidents associés à un harvester spécifique
SELECT i.id, i.date_time, i.reason
FROM INCIDENT i
JOIN ASSOCIER a ON i.id = a.incident_id
WHERE a.serial_number = 'specific_serial_number';

6. Lister les versions et leurs scripts associés
SELECT v.id AS version_id, v.version, s.id AS script_id, s.name AS script_name
FROM VERSION v
JOIN CONTENIR c ON v.id = c.version_id
JOIN SCRIPT s ON c.script_id = s.id;

7. Obtenir tous les contacts pour un client spécifique
SELECT p.id, p.name, p.email, p.phone, p.role
FROM PERSON p
JOIN CLIENT c ON p.id = c.person_id
WHERE c.name = 'specific_client_name';

