DROP TABLE IF EXISTS alumns;
DROP TABLE IF EXISTS bootcamps;
DROP TABLE IF EXISTS inscriptions;
DROP TABLE IF EXISTS moduls;
DROP TABLE IF EXISTS teachers;


CREATE TABLE alumns (
	alumn_id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	surname VARCHAR(50),
	birth DATE,
	country VARCHAR(50),
	email VARCHAR(100),
	discord VARCHAR(50),
	phone VARCHAR(20)
);

CREATE TABLE bootcamps (
	bootcamp_id SERIAL PRIMARY KEY,
	alumn_id INT,
	start_date DATE,
	end_date DATE,
	FOREIGN KEY (alumn_id) REFERENCES ALUMNS(alumn_id)
);

CREATE TABLE inscriptions (
	inscription_id SERIAL PRIMARY KEY,
	alumn_id INT,
	bootcamp_id INT,
	date DATE,
	FOREIGN KEY (alumn_id) REFERENCES ALUMNS(alumn_id),
	FOREIGN KEY (bootcamp_id) REFERENCES BOOTCAMPS(bootcamp_id)
);

CREATE TABLE modules (
	module_id SERIAL PRIMARY KEY,
	bootcamp_id INT,
	start_date DATE,
	end_date DATE,
	FOREIGN KEY (bootcamp_id) REFERENCES BOOTCAMPS(bootcamp_id)
);

CREATE TABLE teachers (
	teacher_id SERIAL PRIMARY KEY,
	module_id INT,
	name VARCHAR(50),
	surname VARCHAR(50),
	birth DATE,
	country VARCHAR(50),
	email VARCHAR(100),
	discord VARCHAR(50),
	phone VARCHAR(20),
	FOREIGN KEY (module_id) REFERENCES MODULES(module_id)
);