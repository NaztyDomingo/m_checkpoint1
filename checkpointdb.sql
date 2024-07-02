DROP VIEW IF EXISTS all_info, view_contacts;

DROP TABLE IF EXISTS items, contacts, contact_type, contact_categories;

CREATE TABLE IF NOT EXISTS contact_categories (
	id SERIAL PRIMARY KEY,
	contact_category VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS contact_types (
	id SERIAL PRIMARY KEY,
	contact_type VARCHAR(30) NOT NULL
);


CREATE TABLE IF NOT EXISTS contacts (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	title VARCHAR(30),
	organization VARCHAR(50)
	
);

CREATE TABLE IF NOT EXISTS items (
	contact TEXT NOT NULL,
	contact_id INT NOT NULL,
	contact_type_id INT NOT NULL,
	contact_category_id INT NOT NULL,
	FOREIGN KEY (contact_id) REFERENCES contacts(id),
	FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
	FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id),
	CONSTRAINT uniq_contact UNIQUE(contact, contact_id, contact_type_id, contact_category_id)
);

INSERT INTO contacts(first_name, last_name, title, organization)
VALUES
	('Erik','Eriksson', 'Teacher', 'Utbildning AB'),
	('Anna','Sundh', NULL, NULL),
	('Goran','Bregovic', 'Coach', 'Dalens IK'),
	('Ann-Marie','Bergqvist', 'Cousin', NULL),
	('Herman','Appelqvist', NULL, NULL);

INSERT INTO contact_types(contact_type)
VALUES
	('Email'),
	('Phone'),
	('Skype'),
	('Instagram');

INSERT INTO contact_categories(contact_category)
VALUES
	('Home'),
	('Work'),
	('Fax');

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id)
VALUES
	('011-12 33 45', 3, 2, 1),
	('goran@infoab.se', 3, 1, 2),
	('010-88 55 44', 4, 2, 2),
	('erik57@hotmail.com', 1, 1, 1),
	('@annapanna99', 2, 4, 1),
	('077-563578', 2, 2, 1),
	('070-156 22 78', 3, 2, 2);

INSERT INTO contacts(first_name, last_name, title, organization)
VALUES
	('Nazeli', 'Sellström Vera', 'Data engineer', 'Enit');

INSERT INTO items(contact, contact_id, contact_type_id, contact_category_id)
VALUES
	('nazeli.sellstrom.vera@brightstraining.com', 6, 2, 2);

SELECT 
	ct.id
FROM 
	contact_types ct
EXCEPT
SELECT
	i.contact_type_id
FROM
	items i;

CREATE VIEW view_contacts AS
	SELECT
		c.first_name,
		c.last_name,
		i.contact,
		ct.contact_type,
		cc.contact_category
	FROM
		contacts c
	JOIN
		items i
	ON
		c.id = i.contact_id
	JOIN
		contact_types ct
	ON
		ct.id = i.contact_type_id
	JOIN
		contact_categories cc
	ON
	 	cc.id = i.contact_category_id;

CREATE VIEW all_info AS
	SELECT
		c.first_name || ' ' || c.last_name AS full_name,
		ct.contact_type,	
		i.contact,
		c.title,
		c.organization,
		cc.contact_category
	FROM
		contacts c
	JOIN
		items i
	ON
		c.id = i.contact_id
	JOIN
		contact_types ct
	ON
		ct.id = i.contact_type_id
	JOIN
		contact_categories cc
	ON
	 	cc.id = i.contact_category_id;

		
		
	 

