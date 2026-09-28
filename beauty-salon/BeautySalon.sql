DROP TABLE IF EXISTS material_consumptions CASCADE;
DROP TABLE IF EXISTS master_specializations CASCADE;
DROP TABLE IF EXISTS supplies CASCADE;
DROP TABLE IF EXISTS salon_schedules CASCADE;
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS discount_cards CASCADE;
DROP TABLE IF EXISTS master_schedules CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;
DROP TABLE IF EXISTS salons CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS masters CASCADE;
DROP TABLE IF EXISTS materials CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS services CASCADE;
DROP TABLE IF EXISTS measurement_units CASCADE;
DROP TABLE IF EXISTS service_types CASCADE;
DROP TABLE IF EXISTS discount_card_types CASCADE;
DROP TABLE IF EXISTS appointment_statuses CASCADE;
DROP TABLE IF EXISTS payment_types CASCADE;
DROP TABLE IF EXISTS positions CASCADE;
DROP TABLE IF EXISTS room_types CASCADE;
DROP TABLE IF EXISTS cities CASCADE;

CREATE TABLE salons(
	id_salon SERIAL NOT NULL,
	salon_name TEXT NOT NULL,
	street TEXT NOT NULL,
	building TEXT NOT NULL,
	description_salon TEXT,
	id_city INTEGER NOT NULL
);
ALTER TABLE salons ADD CONSTRAINT pk_id_salon PRIMARY KEY(id_salon);
ALTER TABLE salons ADD CONSTRAINT u_street_building_id_city UNIQUE (street, building, id_city);

CREATE TABLE salon_schedules (
   id_schedule_salon SERIAL NOT NULL,
   id_salon INTEGER NOT NULL,
   day_of_week CHAR(1) NOT NULL,
   open_time TIME,
   close_time TIME
);
ALTER TABLE salon_schedules ADD CONSTRAINT pk_id_schedule_salon PRIMARY KEY (id_schedule_salon);
ALTER TABLE salon_schedules ADD CONSTRAINT ch_salon_schedule_hours CHECK
    ((open_time IS NULL 
	AND close_time IS NULL) 
    OR (open_time IS NOT NULL 
	AND close_time IS NOT NULL 
	AND open_time < close_time)); 
ALTER TABLE salon_schedules ADD CONSTRAINT ch_salon_schedule_day CHECK (
	day_of_week IN ('1', '2', '3', '4', '5', '6', '7'));

CREATE TABLE rooms (
   id_room SERIAL NOT NULL,
   id_salon INTEGER NOT NULL,
   id_room_type INTEGER NOT NULL,
   room_number TEXT NOT NULL,
   room_floor INTEGER
);
ALTER TABLE rooms ADD CONSTRAINT pk_id_room PRIMARY KEY (id_room);
ALTER TABLE rooms ADD CONSTRAINT u_room_number_in_salon UNIQUE (id_salon, room_number, room_floor);

CREATE TABLE masters (
   id_master SERIAL NOT NULL,
   id_position INTEGER NOT NULL,
   surname_master TEXT NOT NULL,
   name_master TEXT NOT NULL,
   patronymic_master TEXT,
   phone_master TEXT NOT NULL,
   email_master TEXT NOT NULL
);
ALTER TABLE masters ADD CONSTRAINT pk_id_master PRIMARY KEY (id_master);
ALTER TABLE masters ADD CONSTRAINT u_phone_master UNIQUE (phone_master);
ALTER TABLE masters ADD CONSTRAINT u_email_master UNIQUE (email_master);

CREATE TABLE master_schedules (
   id_schedule_master SERIAL NOT NULL,
   id_master INTEGER NOT NULL,
   date_shift DATE NOT NULL,
   start_time TIME NOT NULL,
   end_time TIME NOT NULL
);
ALTER TABLE master_schedules ADD CONSTRAINT pk_id_schedule_master PRIMARY KEY (id_schedule_master);
ALTER TABLE master_schedules ADD CONSTRAINT u_master_schedule_day UNIQUE (id_master, date_shift);
ALTER TABLE master_schedules ADD CONSTRAINT ch_date_shift CHECK (
   date_shift >= DATE '1900-01-01'
   AND date_shift <= CURRENT_DATE);
ALTER TABLE master_schedules ADD CONSTRAINT ch_start_time_end_time CHECK (start_time < end_time);

CREATE TABLE master_specializations (
   id_master_specialization SERIAL NOT NULL,
   id_master INTEGER NOT NULL,
   id_service INTEGER NOT NULL,
   price_service MONEY NOT NULL
);
ALTER TABLE master_specializations ADD CONSTRAINT pk_id_master_specialization PRIMARY KEY (id_master_specialization);
ALTER TABLE master_specializations ADD CONSTRAINT u_master_service UNIQUE (id_master, id_service);
ALTER TABLE master_specializations ADD CONSTRAINT ch_price_service CHECK (price_service >= 0::MONEY);

CREATE TABLE clients (
   id_client SERIAL NOT NULL,
   surname_client TEXT NOT NULL,
   name_client TEXT NOT NULL,
   patronymic_client TEXT,
   phone_client TEXT NOT NULL,
   email_client TEXT NOT NULL,
   birth_date_client DATE NOT NULL
);
ALTER TABLE clients ADD CONSTRAINT pk_id_client PRIMARY KEY (id_client);
ALTER TABLE clients ADD CONSTRAINT u_phone_client UNIQUE (phone_client);
ALTER TABLE clients ADD CONSTRAINT u_email_client UNIQUE (email_client);
ALTER TABLE clients ADD CONSTRAINT ch_birth_date_client CHECK (
   birth_date_client >= DATE '1900-01-01'
   AND birth_date_client <= CURRENT_DATE);

CREATE TABLE materials (
   id_material SERIAL NOT NULL,
   id_measurement_unit INTEGER NOT NULL,
   name_material TEXT NOT NULL,
   current_volume_material INTEGER NOT NULL
);
ALTER TABLE materials ADD CONSTRAINT pk_id_material PRIMARY KEY (id_material);
ALTER TABLE materials ADD CONSTRAINT u_name_material UNIQUE (name_material);
ALTER TABLE materials ADD CONSTRAINT ch_current_volume_material CHECK (current_volume_material >= 0);

CREATE TABLE services (
   id_service SERIAL NOT NULL,
   id_service_type INTEGER NOT NULL,
   name_service TEXT NOT NULL,
   description_service TEXT
);
ALTER TABLE services ADD CONSTRAINT pk_id_service PRIMARY KEY (id_service);
ALTER TABLE services ADD CONSTRAINT u_name_service UNIQUE (name_service);

CREATE TABLE discount_cards (
   id_discount_card SERIAL NOT NULL,
   id_client INTEGER NOT NULL,
   id_discount_card_type INTEGER NOT NULL,
   number_discount_card TEXT NOT NULL,
   date_issue DATE NOT NULL
);
ALTER TABLE discount_cards ADD CONSTRAINT pk_id_discount_card PRIMARY KEY (id_discount_card);
ALTER TABLE discount_cards ADD CONSTRAINT u_number_discount_card UNIQUE (number_discount_card);
ALTER TABLE discount_cards ADD CONSTRAINT ch_date_issue CHECK (
    date_issue >= DATE '1900-01-01'
   AND  date_issue <= CURRENT_DATE);

CREATE TABLE appointments (
   id_appointment SERIAL NOT NULL,
   id_client INTEGER,
   id_master_specialization INTEGER NOT NULL,
   id_room INTEGER NOT NULL,
   id_appointment_status INTEGER NOT NULL,
   id_payment_type INTEGER NOT NULL,
   id_discount_card INTEGER,
   date_appointment DATE NOT NULL,
   appointment_time TIME NOT NULL,
   total_cost MONEY NOT NULL
);
ALTER TABLE appointments ADD CONSTRAINT pk_id_appointment PRIMARY KEY (id_appointment);
ALTER TABLE appointments ADD CONSTRAINT u_appointment_master_time UNIQUE (id_master_specialization, date_appointment, appointment_time);
ALTER TABLE appointments ADD CONSTRAINT u_appointment_room_time UNIQUE (id_room, date_appointment, appointment_time);
ALTER TABLE appointments ADD CONSTRAINT ch_id_discount_card_id_client CHECK (
	(id_client IS NULL 
	AND id_discount_card IS NOT NULL) 
	OR
	(id_client IS NOT NULL
	AND id_discount_card IS NULL) 
);
ALTER TABLE appointments ADD CONSTRAINT ch_total_cost CHECK (total_cost >= 0::MONEY);
ALTER TABLE appointments ADD CONSTRAINT ch_date_appointment CHECK (date_appointment >= '1900-01-01' AND date_appointment <= CURRENT_DATE);

CREATE TABLE supplies (
   id_supply SERIAL NOT NULL,
   id_material INTEGER NOT NULL,
   id_supplier INTEGER NOT NULL,
   date_supply DATE NOT NULL,
   quantity_material INTEGER NOT NULL,
   price_material MONEY NOT NULL
);
ALTER TABLE supplies ADD CONSTRAINT pk_id_supply PRIMARY KEY (id_supply);
ALTER TABLE supplies ADD CONSTRAINT ch_price_material CHECK (price_material >= 0::MONEY);

CREATE TABLE material_consumptions (
   id_material INTEGER NOT NULL,
   id_service INTEGER NOT NULL,
   consumed_quantity INTEGER NOT NULL
);
ALTER TABLE material_consumptions ADD CONSTRAINT pk_id_material_id_service PRIMARY KEY (id_material, id_service);
ALTER TABLE material_consumptions ADD CONSTRAINT ch_consumed_quantity CHECK (consumed_quantity > 0);

CREATE TABLE suppliers (
   id_supplier SERIAL NOT NULL,
   name_supplier TEXT NOT NULL,
   phone_supplier TEXT NOT NULL
);
ALTER TABLE suppliers ADD CONSTRAINT pk_id_supplier PRIMARY KEY (id_supplier);
ALTER TABLE suppliers ADD CONSTRAINT u_phone_supplier UNIQUE (phone_supplier);
ALTER TABLE suppliers ADD CONSTRAINT u_name_supplier UNIQUE (name_supplier);

CREATE TABLE cities (
   id_city SERIAL NOT NULL,
   name_city TEXT NOT NULL
);
ALTER TABLE cities ADD CONSTRAINT pk_id_city PRIMARY KEY (id_city);
ALTER TABLE cities ADD CONSTRAINT u_name_city UNIQUE (name_city);

CREATE TABLE room_types (
   id_room_type SERIAL NOT NULL,
   name_room_type TEXT NOT NULL,
   description_room_type TEXT
);
ALTER TABLE room_types ADD CONSTRAINT pk_id_room_type PRIMARY KEY (id_room_type);
ALTER TABLE room_types ADD CONSTRAINT u_name_room_type UNIQUE (name_room_type);

CREATE TABLE positions (
   id_position SERIAL NOT NULL,
   name_position TEXT NOT NULL,
   description_position TEXT
);
ALTER TABLE positions ADD CONSTRAINT pk_id_position PRIMARY KEY (id_position);
ALTER TABLE positions ADD CONSTRAINT u_name_position UNIQUE (name_position);

CREATE TABLE measurement_units (
   id_measurement_unit SERIAL NOT NULL,
   name_measurement_unit TEXT NOT NULL
);
ALTER TABLE measurement_units ADD CONSTRAINT pk_id_measurement_unit PRIMARY KEY (id_measurement_unit);
ALTER TABLE measurement_units ADD CONSTRAINT u_name_measurement_unit UNIQUE (name_measurement_unit);

CREATE TABLE service_types (
   id_service_type SERIAL NOT NULL,
   name_service_type TEXT NOT NULL,
   description_service_type TEXT
);
ALTER TABLE service_types ADD CONSTRAINT pk_id_service_type PRIMARY KEY (id_service_type);
ALTER TABLE service_types ADD CONSTRAINT u_name_service_type UNIQUE (name_service_type);

CREATE TABLE discount_card_types (
   id_discount_card_type SERIAL NOT NULL,
   id_service_type INTEGER NOT NULL,
   name_discount_card_type TEXT NOT NULL, 
   requirements TEXT,
   discount_percentage INTEGER NOT NULL
);
ALTER TABLE discount_card_types ADD CONSTRAINT pk_id_discount_card_type PRIMARY KEY (id_discount_card_type);
ALTER TABLE discount_card_types ADD CONSTRAINT u_name_discount_card_type UNIQUE (name_discount_card_type);
ALTER TABLE discount_card_types ADD CONSTRAINT ch_discount_percentage CHECK (discount_percentage > 0);

CREATE TABLE appointment_statuses (
   id_appointment_status SERIAL NOT NULL,
   name_appointment_status TEXT NOT NULL
);
ALTER TABLE appointment_statuses ADD CONSTRAINT pk_id_appointment_status PRIMARY KEY (id_appointment_status);
ALTER TABLE appointment_statuses ADD CONSTRAINT u_name_appointment_status UNIQUE (name_appointment_status);

CREATE TABLE payment_types (
   id_payment_type SERIAL NOT NULL,
   name_payment_type TEXT NOT NULL
);
ALTER TABLE payment_types ADD CONSTRAINT pk_id_payment_type PRIMARY KEY (id_payment_type);
ALTER TABLE payment_types ADD CONSTRAINT u_name_payment_type UNIQUE (name_payment_type);



-- ===== FOREIGN KEYS =====

-- Salons
ALTER TABLE salons ADD CONSTRAINT FK_salons_id_city FOREIGN KEY (id_city)
REFERENCES cities (id_city);

-- Rooms
ALTER TABLE rooms ADD CONSTRAINT FK_rooms_id_salon FOREIGN KEY (id_salon)
REFERENCES salons (id_salon);
ALTER TABLE rooms ADD CONSTRAINT FK_rooms_id_room_type FOREIGN KEY (id_room_type)
REFERENCES room_types (id_room_type);

-- Masters
ALTER TABLE masters ADD CONSTRAINT FK_masters_id_position FOREIGN KEY (id_position)
REFERENCES positions (id_position);

-- MasterSchedules
ALTER TABLE master_schedules ADD CONSTRAINT FK_master_schedules_id_master FOREIGN KEY (id_master)
REFERENCES masters (id_master);

-- MasterSpecializations
ALTER TABLE master_specializations ADD CONSTRAINT FK_master_specializations_id_master FOREIGN KEY (id_master)
REFERENCES masters (id_master);

ALTER TABLE master_specializations ADD CONSTRAINT FK_master_specializations_id_service FOREIGN KEY (id_service)
REFERENCES services (id_service);

-- Materials
ALTER TABLE materials ADD CONSTRAINT FK_materials_id_measurement_unit FOREIGN KEY (id_measurement_unit)
REFERENCES measurement_units (id_measurement_unit);

-- MaterialConsumptions
ALTER TABLE material_consumptions ADD CONSTRAINT FK_material_consumptions_id_material FOREIGN KEY (id_material)
REFERENCES materials (id_material);

ALTER TABLE material_consumptions
ADD CONSTRAINT FK_material_consumptions_id_service FOREIGN KEY (id_service)
REFERENCES services (id_service);


-- Services
ALTER TABLE services ADD CONSTRAINT FK_services_id_service_type FOREIGN KEY (id_service_type)
REFERENCES service_types (id_service_type);

-- SalonSchedules
ALTER TABLE salon_schedules ADD CONSTRAINT FK_salon_schedules_id_salon FOREIGN KEY (id_salon)
REFERENCES salons (id_salon);

-- DiscountCards
ALTER TABLE discount_cards ADD CONSTRAINT FK_discount_cards_id_client FOREIGN KEY (id_client)
REFERENCES clients (id_client);
ALTER TABLE discount_cards ADD CONSTRAINT FK_discount_cards_id_discount_card_type FOREIGN KEY (id_discount_card_type)
REFERENCES discount_card_types (id_discount_card_type);

--DiscountCardsTypes
ALTER TABLE discount_card_types ADD CONSTRAINT FK_discount_card_types_id_service_type FOREIGN KEY (id_service_type)
REFERENCES service_types (id_service_type);

-- Appointments
ALTER TABLE appointments ADD CONSTRAINT FK_appointments_id_client FOREIGN KEY (id_client)
REFERENCES clients (id_client);

ALTER TABLE appointments ADD CONSTRAINT FK_appointments_id_master
FOREIGN KEY (id_master_specialization)
REFERENCES master_specializations (id_master_specialization);

ALTER TABLE appointments ADD CONSTRAINT FK_appointments_id_room FOREIGN KEY (id_room)
REFERENCES rooms (id_room);

ALTER TABLE appointments ADD CONSTRAINT FK_appointments_id_appointment_status FOREIGN KEY (id_appointment_status)
REFERENCES appointment_statuses (id_appointment_status);

ALTER TABLE appointments  ADD CONSTRAINT FK_appointments_id_payment_type FOREIGN KEY (id_payment_type)
REFERENCES payment_types (id_payment_type);

ALTER TABLE appointments ADD CONSTRAINT FK_appointments_id_discount_card FOREIGN KEY (id_discount_card)
REFERENCES discount_cards (id_discount_card);

-- Supplies
ALTER TABLE supplies
ADD CONSTRAINT FK_supplies_id_material FOREIGN KEY (id_material) REFERENCES materials (id_material);

ALTER TABLE supplies
ADD CONSTRAINT FK_supplies_id_supplier FOREIGN KEY (id_supplier) REFERENCES suppliers (id_supplier);


