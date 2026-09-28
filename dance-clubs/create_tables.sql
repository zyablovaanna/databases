
DROP TABLE IF EXISTS trainers CASCADE;
DROP TABLE IF EXISTS dance_duets CASCADE;
DROP TABLE IF EXISTS dancing_groups CASCADE;
DROP TABLE IF EXISTS schedules_group CASCADE;
DROP TABLE IF EXISTS dancers CASCADE;
DROP TABLE IF EXISTS directions CASCADE;
DROP TABLE IF EXISTS programs CASCADE;
DROP TABLE IF EXISTS classes CASCADE;
DROP TABLE IF EXISTS group_structure CASCADE;
DROP TABLE IF EXISTS specialization CASCADE;
DROP TABLE IF EXISTS classification_book CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS halls CASCADE;
DROP TABLE IF EXISTS address CASCADE;
DROP TABLE IF EXISTS competitions CASCADE;
DROP TABLE IF EXISTS participants CASCADE;
DROP TABLE IF EXISTS registration CASCADE;
DROP TABLE IF EXISTS competition_program CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS types_lessons CASCADE;
DROP TABLE IF EXISTS judicial_categories CASCADE;
DROP TABLE IF EXISTS age_categories CASCADE;
DROP TABLE IF EXISTS sport_categories CASCADE;
DROP TABLE IF EXISTS competition_statuses CASCADE;
DROP TABLE IF EXISTS countries CASCADE;

CREATE TABLE trainers (
   id_trainer SERIAL NOT NULL,
   surname_trainer VARCHAR(100) NOT NULL,
   name_trainer VARCHAR(50) NOT NULL,
   patronymic_trainer VARCHAR(100),
   phone_numb_trainer TEXT NOT NULL,
   email_trainer VARCHAR(50) NOT NULL,
   gender_trainer CHAR(1) NOT NULL,
   id_judicial_cat INTEGER
);
ALTER TABLE trainers ADD CONSTRAINT pk_id_trainer PRIMARY KEY (id_trainer);
ALTER TABLE trainers ADD CONSTRAINT chk_gender_trainer CHECK (gender_trainer IN ('м', 'ж'));
ALTER TABLE trainers ADD CONSTRAINT u_phone_numb_trainer UNIQUE (phone_numb_trainer);
ALTER TABLE trainers ADD CONSTRAINT u_email_trainer UNIQUE (email_trainer);

CREATE TABLE dance_duets (
   id_duet SERIAL NOT NULL,
   id_second_partner INTEGER NOT NULL,
   id_first_partner INTEGER NOT NULL
);
ALTER TABLE dance_duets ADD CONSTRAINT pk_id_duet PRIMARY KEY (id_duet);
ALTER TABLE dance_duets ADD CONSTRAINT u_id_s_and_f_part UNIQUE(id_second_partner, id_first_partner);

CREATE TABLE dancing_groups (
   id_group SERIAL NOT NULL,
   name_group VARCHAR(40) NOT NULL
);
ALTER TABLE dancing_groups ADD CONSTRAINT u_name_group UNIQUE (name_group);
ALTER TABLE dancing_groups ADD CONSTRAINT pk_id_group PRIMARY KEY (id_group);
ALTER TABLE dance_duets ADD CONSTRAINT chk_different_partners CHECK (id_first_partner <> id_second_partner);

CREATE TABLE schedules_group (
   id_schedule_group SERIAL NOT NULL,
   id_group INTEGER NOT NULL,
   time_group TIME NOT NULL,
   day_week CHAR(1) NOT NULL
);
ALTER TABLE schedules_group ADD CONSTRAINT ch_time_group CHECK (time_group >= TIME '08:00:00' AND time_group <= TIME '22:00:00');
ALTER TABLE schedules_group ADD CONSTRAINT pk_id_schedule_group PRIMARY KEY (id_schedule_group);
ALTER TABLE schedules_group ADD CONSTRAINT u_schedule_group_time_day UNIQUE (id_group, time_group, day_week);
ALTER TABLE schedules_group ADD CONSTRAINT chk_day_week CHECK (day_week IN ('1', '2', '3', '4', '5', '6', '7'));

CREATE TABLE dancers (
   id_dancer SERIAL NOT NULL,
   surname_dancer VARCHAR(100) NOT NULL,
   name_dancer VARCHAR(50) NOT NULL,
   patronymic_dancer VARCHAR(100),
   phone_numb_dancer TEXT NOT NULL,
   email_dancer VARCHAR(50) NOT NULL,
   date_of_birth_dancer DATE NOT NULL,
   gender_dancer CHAR(1) NOT NULL,
   id_sport_cat INTEGER,
   id_age_cat INTEGER NOT NULL
);
ALTER TABLE dancers ADD CONSTRAINT pk_id_dancer PRIMARY KEY (id_dancer);
ALTER TABLE dancers ADD CONSTRAINT сh_gender_dancer CHECK (gender_dancer IN ('м', 'ж'));
ALTER TABLE dancers ADD CONSTRAINT ch_date_of_birth CHECK (
	date_of_birth_dancer >= DATE '1960-01-01');
ALTER TABLE dancers ADD CONSTRAINT u_phone_numb_dancer UNIQUE (phone_numb_dancer);
ALTER TABLE dancers ADD CONSTRAINT u_email_dancer UNIQUE (email_dancer);

CREATE TABLE directions (
   id_direction SERIAL NOT NULL,
   id_program INTEGER,
   name_direction VARCHAR(100) NOT NULL
);
ALTER TABLE directions ADD CONSTRAINT u_name_direction UNIQUE (name_direction);
ALTER TABLE directions ADD CONSTRAINT pk_id_direction PRIMARY KEY (id_direction);

CREATE TABLE programs (
   id_program SERIAL NOT NULL,
   name_program VARCHAR(100) NOT NULL
);
ALTER TABLE programs ADD CONSTRAINT pk_id_program  PRIMARY KEY (id_program );
ALTER TABLE programs ADD CONSTRAINT u_name_program UNIQUE (name_program);

CREATE TABLE classes (
   id_class SERIAL NOT NULL,
   id_program INTEGER NOT NULL,
   id_next_class INTEGER,
   dance_class CHAR(1)  NOT NULL,
   transition_points INTEGER
);
ALTER TABLE classes ADD CONSTRAINT ch_dance_class CHECK (dance_class IN ('E', 'D', 'C', 'B', 'A', 'S'));
ALTER TABLE classes ADD CONSTRAINT pk_id_class PRIMARY KEY (id_class);
ALTER TABLE classes ADD CONSTRAINT u_next_class UNIQUE (id_next_class);

CREATE TABLE group_structure (
   id_group_structure SERIAL NOT NULL,
   id_group INTEGER NOT NULL,
   id_dancer INTEGER NOT NULL
);
ALTER TABLE group_structure ADD CONSTRAINT pk_id_group_str PRIMARY KEY (id_group_structure);
ALTER TABLE group_structure ADD CONSTRAINT u_id_gr_danc UNIQUE (id_group, id_dancer);


CREATE TABLE specialization (
   id_special SERIAL NOT NULL,
   id_trainer INTEGER NOT NULL,
   id_direction INTEGER NOT NULL,
   service_price MONEY NOT NULL
);
ALTER TABLE specialization ADD CONSTRAINT pk_id_special PRIMARY KEY (id_special);
ALTER TABLE specialization ADD CONSTRAINT u_id_t_d UNIQUE (id_trainer, id_direction);
ALTER TABLE specialization ADD CONSTRAINT ch_cost_lesson CHECK (service_price >= 0::MONEY);

CREATE TABLE classification_book (
   id_record SERIAL NOT NULL,
   id_class INTEGER,
   id_dancer INTEGER,
   id_duet INTEGER,
   points INTEGER NOT NULL,
   date_assignment DATE NOT NULL
);
ALTER TABLE classification_book ADD CONSTRAINT pk_id_record PRIMARY KEY (id_record);
ALTER TABLE classification_book
ADD CONSTRAINT ch_exclusive_owner CHECK (
   (id_dancer IS NOT NULL 
   AND id_duet IS NULL)
   OR (id_dancer IS NULL 
   AND id_duet IS NOT NULL)
);
ALTER TABLE classification_book ADD CONSTRAINT ch_points CHECK (points >= 0);
ALTER TABLE classification_book ADD CONSTRAINT u_classification UNIQUE (id_class, id_dancer, id_duet, date_assignment);

CREATE TABLE lessons (
   id_lesson SERIAL NOT NULL,
   id_direction INTEGER NOT NULL,
   id_trainer INTEGER NOT NULL,
   id_hall INTEGER NOT NULL, 
   date_lesson TIMESTAMP  NOT NULL,
   duration INTEGER NOT NULL,
   id_schedule_group INTEGER,
   id_type_lesson INTEGER NOT NULL,
   id_participant INTEGER NOT NULL,
   cost_lesson MONEY NOT NULL
);
ALTER TABLE lessons ADD CONSTRAINT pk_id_lesson PRIMARY KEY (id_lesson);
ALTER TABLE lessons ADD CONSTRAINT ch_duration CHECK (duration BETWEEN 30 AND 180);
ALTER TABLE lessons ADD CONSTRAINT ch_cost_lesson CHECK (cost_lesson >= 0::MONEY);
ALTER TABLE lessons ADD CONSTRAINT ch_lesson_end_time CHECK (
   (date_lesson + (duration || ' minutes')::INTERVAL)::TIME <= TIME '22:00:00');
ALTER TABLE lessons ADD CONSTRAINT u_lesson_hall_time UNIQUE (id_hall, date_lesson);

CREATE TABLE halls (
   id_hall SERIAL NOT NULL,
   id_address INTEGER NOT NULL,
   square INTEGER NOT NULL,
   rental_price MONEY NOT NULL,
   name_hall VARCHAR (100) NOT NULL
);
ALTER TABLE halls ADD CONSTRAINT pk_id_hall PRIMARY KEY (id_hall);
ALTER TABLE halls ADD CONSTRAINT ch_square CHECK (square >= 10);
ALTER TABLE halls ADD CONSTRAINT ch_cost_lesson CHECK (rental_price >= 0::MONEY);
ALTER TABLE halls ADD CONSTRAINT u_address_hall_name UNIQUE (id_address, name_hall);

CREATE TABLE address (
   id_address SERIAL NOT NULL,
   id_city INTEGER  NOT NULL,
   street VARCHAR(50) NOT NULL,
   house TEXT NOT NULL,
   club_name VARCHAR(100),
   description_club TEXT
);
ALTER TABLE address ADD CONSTRAINT pk_id_address PRIMARY KEY (id_address);
ALTER TABLE address ADD CONSTRAINT u_address UNIQUE (id_city, street, house, club_name);

CREATE TABLE competitions (
   id_competition SERIAL NOT NULL,
   id_address INTEGER,
   id_status_competiton INTEGER NOT NULL,
   name_competition VARCHAR(100) NOT NULL,
   start_date DATE NOT NULL,
   end_date DATE
);
ALTER TABLE competitions ADD CONSTRAINT pk_id_competition PRIMARY KEY (id_competition);
ALTER TABLE competitions ADD CONSTRAINT ch_dates CHECK  ((end_date IS NULL) OR (start_date < end_date));
ALTER TABLE competitions ADD CONSTRAINT u_id_ad_start_d_name_comp UNIQUE (id_address, name_competition, start_date);

CREATE TABLE participants (
   id_participant SERIAL NOT NULL,
   id_group INTEGER,
   id_duet INTEGER,
   id_dancer INTEGER
);
ALTER TABLE participants ADD CONSTRAINT pk_id_participant PRIMARY KEY (id_participant);
ALTER TABLE participants ADD CONSTRAINT chk_exclusive_participant CHECK
(
   (id_group IS NOT NULL 
   AND id_duet IS NULL
   AND id_dancer IS NULL)
   
   OR (id_group IS NULL 
   AND id_duet IS NOT NULL 
   AND id_dancer IS NULL)
   
   OR (id_group IS NULL
   AND id_duet IS NULL
   AND id_dancer IS NOT NULL)
);

CREATE TABLE competition_program (
   id_comp_program SERIAL NOT NULL,
   id_competition INTEGER NOT NULL,
   id_direction INTEGER NOT NULL,
   id_class INTEGER NOT NULL
);
ALTER TABLE competition_program ADD CONSTRAINT pk_id_comp_program PRIMARY KEY (id_comp_program);
ALTER TABLE competition_program ADD CONSTRAINT u_competition_program UNIQUE (id_competition, id_direction, id_class);


CREATE TABLE registration (
   id_registration SERIAL NOT NULL,
   id_participant INTEGER NOT NULL,
   id_comp_program INTEGER NOT NULL,
   place_after_final INTEGER
);
ALTER TABLE registration ADD CONSTRAINT pk_id_registration PRIMARY KEY (id_registration);
ALTER TABLE registration ADD CONSTRAINT ch_place_after_final CHECK (place_after_final >= 0);
ALTER TABLE registration ADD CONSTRAINT u_registration_participant_program UNIQUE (id_participant, id_comp_program);


CREATE TABLE cities (
   id_city SERIAL NOT NULL,
   id_country INTEGER NOT NULL,
   name_city VARCHAR(60) NOT NULL
);
ALTER TABLE cities ADD CONSTRAINT pk_id_city PRIMARY KEY (id_city);
ALTER TABLE cities ADD CONSTRAINT u_name_city  UNIQUE (name_city);

CREATE TABLE types_lessons (
   id_type_lesson SERIAL NOT NULL,
   name_type_lesson TEXT NOT NULL,
   description_type_lesson TEXT
);
ALTER TABLE types_lessons ADD CONSTRAINT pk_id_type_lesson PRIMARY KEY (id_type_lesson);
ALTER TABLE types_lessons ADD CONSTRAINT u_name_type_lesson  UNIQUE (name_type_lesson);

CREATE TABLE judicial_categories (
   id_judicial_cat SERIAL NOT NULL,
   name_jud_cat VARCHAR(100) NOT NULL,
   description_jud_cat TEXT
);
ALTER TABLE judicial_categories ADD CONSTRAINT pk_id_judicial_cat PRIMARY KEY (id_judicial_cat);
ALTER TABLE judicial_categories ADD CONSTRAINT u_name_jud_cat  UNIQUE (name_jud_cat);

CREATE TABLE age_categories (
   id_age_cat SERIAL NOT NULL,
   name_age_cat VARCHAR(100) NOT NULL,
   description_age_cat TEXT
);
ALTER TABLE age_categories ADD CONSTRAINT pk_id_age_cat PRIMARY KEY (id_age_cat);
ALTER TABLE age_categories ADD CONSTRAINT u_name_age_cat  UNIQUE (name_age_cat);

CREATE TABLE sport_categories (
   id_sport_cat SERIAL NOT NULL,
   name_sport_cat VARCHAR(100) NOT NULL,
   description_sport_cat TEXT
);
ALTER TABLE sport_categories ADD CONSTRAINT pk_id_sport_cat PRIMARY KEY (id_sport_cat);
ALTER TABLE sport_categories ADD CONSTRAINT u_name_sport_cat  UNIQUE (name_sport_cat);


CREATE TABLE competition_statuses (
   id_status_competition SERIAL NOT NULL,
   name_st_competition VARCHAR(100) NOT NULL
);
ALTER TABLE competition_statuses ADD CONSTRAINT pk_id_status_competition PRIMARY KEY (id_status_competition);
ALTER TABLE  competition_statuses  ADD CONSTRAINT u_name_st_competition  UNIQUE (name_st_competition);

CREATE TABLE countries (
   id_country SERIAL NOT NULL,
   name_country VARCHAR(60) NOT NULL
);
ALTER TABLE countries ADD CONSTRAINT pk_id_country PRIMARY KEY (id_country);
ALTER TABLE countries  ADD CONSTRAINT u_name_country  UNIQUE (name_country);

-- ===== FOREIGN KEYS =====

-- GroupStructure
ALTER TABLE group_structure
ADD CONSTRAINT FK_group_structure_id_dancer FOREIGN KEY (id_dancer)
REFERENCES dancers (id_dancer);

ALTER TABLE group_structure
ADD CONSTRAINT FK_group_structure_id_group FOREIGN KEY (id_group)
REFERENCES dancing_groups (id_group);

-- DanceDuets
ALTER TABLE dance_duets
ADD CONSTRAINT FK_dance_duets_id_second_partner FOREIGN KEY (id_second_partner)
REFERENCES dancers (id_dancer);

ALTER TABLE dance_duets
ADD CONSTRAINT FK_dance_duets_id_first_partner FOREIGN KEY (id_first_partner)
REFERENCES dancers (id_dancer);

-- SchedulesGroup
ALTER TABLE schedules_group
ADD CONSTRAINT FK_schedules_group_id_group FOREIGN KEY (id_group)
REFERENCES dancing_groups (id_group);

-- Directions
ALTER TABLE directions
ADD CONSTRAINT FK_directions_id_program FOREIGN KEY (id_program)
REFERENCES programs (id_program);

-- Classes
ALTER TABLE classes
ADD CONSTRAINT FK_classes_id_program FOREIGN KEY (id_program)
REFERENCES programs (id_program);

-- Specialization
ALTER TABLE specialization
ADD CONSTRAINT FK_specialization_id_direction FOREIGN KEY (id_direction)
REFERENCES directions (id_direction);

ALTER TABLE specialization
ADD CONSTRAINT FK_specialization_id_trainer FOREIGN KEY (id_trainer)
REFERENCES trainers (id_trainer);

-- ClassificationBook
ALTER TABLE classification_book
ADD CONSTRAINT FK_classification_book_id_dancer FOREIGN KEY (id_dancer)
REFERENCES dancers (id_dancer);

ALTER TABLE classification_book
ADD CONSTRAINT FK_classification_book_id_class FOREIGN KEY (id_class)
REFERENCES classes (id_class);

ALTER TABLE classification_book
ADD CONSTRAINT FK_classification_book_id_duet FOREIGN KEY (id_duet)
REFERENCES dance_duets (id_duet);

-- Lessons
ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_direction FOREIGN KEY (id_direction)
REFERENCES directions (id_direction);

ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_trainer FOREIGN KEY (id_trainer)
REFERENCES trainers (id_trainer);

ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_schedule_group FOREIGN KEY (id_schedule_group)
REFERENCES schedules_group (id_schedule_group);

ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_hall FOREIGN KEY (id_hall)
REFERENCES halls (id_hall);

ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_type_lesson FOREIGN KEY (id_type_lesson)
REFERENCES types_lessons (id_type_lesson);

ALTER TABLE lessons
ADD CONSTRAINT FK_lessons_id_participant FOREIGN KEY (id_participant)
REFERENCES participants (id_participant);

-- Participants
ALTER TABLE participants
ADD CONSTRAINT FK_participants_id_dancer FOREIGN KEY (id_dancer)
REFERENCES dancers (id_dancer);

ALTER TABLE participants
ADD CONSTRAINT FK_participants_id_group FOREIGN KEY (id_group)
REFERENCES dancing_groups (id_group);

ALTER TABLE participants
ADD CONSTRAINT FK_participants_id_duet FOREIGN KEY (id_duet)
REFERENCES dance_duets (id_duet);

-- Registration
ALTER TABLE registration
ADD CONSTRAINT FK_registration_id_participant FOREIGN KEY (id_participant)
REFERENCES participants (id_participant);

ALTER TABLE registration
ADD CONSTRAINT FK_registration_id_program FOREIGN KEY (id_comp_program)
REFERENCES competition_program (id_comp_program);

-- CompetitionProgram
ALTER TABLE competition_program
ADD CONSTRAINT FK_competition_program_id_direction FOREIGN KEY (id_direction)
REFERENCES directions (id_direction);

ALTER TABLE competition_program
ADD CONSTRAINT FK_competition_program_id_competition FOREIGN KEY (id_competition)
REFERENCES competitions (id_competition);

ALTER TABLE competition_program
ADD CONSTRAINT FK_competition_program_id_class FOREIGN KEY (id_class)
REFERENCES classes (id_class);

-- Competitions
ALTER TABLE competitions
ADD CONSTRAINT FK_competitions_id_address FOREIGN KEY (id_address)
REFERENCES address (id_address);

ALTER TABLE competitions
ADD CONSTRAINT FK_competitions_id_status_competiton FOREIGN KEY (id_status_competiton)
REFERENCES competition_statuses (id_status_competition);

-- Address
ALTER TABLE address
ADD CONSTRAINT FK_address_id_city FOREIGN KEY (id_city)
REFERENCES cities (id_city);

-- Halls
ALTER TABLE halls
ADD CONSTRAINT FK_halls_id_address FOREIGN KEY (id_address)
REFERENCES address (id_address);

-- Trainers
ALTER TABLE trainers
ADD CONSTRAINT FK_trainers_id_judicial_cat FOREIGN KEY (id_judicial_cat)
REFERENCES judicial_categories (id_judicial_cat);

-- Dancers
ALTER TABLE dancers
ADD CONSTRAINT FK_dancers_id_age_cat FOREIGN KEY (id_age_cat)
REFERENCES age_categories (id_age_cat);

ALTER TABLE dancers
ADD CONSTRAINT FK_dancers_id_sport_cat FOREIGN KEY (id_sport_cat)
REFERENCES sport_categories (id_sport_cat);

-- Cities
ALTER TABLE cities
ADD CONSTRAINT FK_cities_id_country FOREIGN KEY (id_country)
REFERENCES countries (id_country);

-- Classes (рекурсивные связи)
ALTER TABLE classes ADD CONSTRAINT fk_classes_next_class 
FOREIGN KEY (id_next_class) REFERENCES classes (id_class);