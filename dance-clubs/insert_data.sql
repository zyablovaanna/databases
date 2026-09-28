TRUNCATE types_lessons CASCADE;
TRUNCATE lessons CASCADE;
TRUNCATE specialization CASCADE;
TRUNCATE halls CASCADE;
TRUNCATE registration CASCADE;
TRUNCATE competition_program CASCADE;
TRUNCATE competitions CASCADE;
TRUNCATE competition_statuses CASCADE;
TRUNCATE participants CASCADE;
TRUNCATE address CASCADE;
TRUNCATE cities CASCADE;
TRUNCATE countries CASCADE;
TRUNCATE schedules_group CASCADE;
TRUNCATE group_structure CASCADE;
TRUNCATE dancing_groups CASCADE;
TRUNCATE classification_book CASCADE;
TRUNCATE dance_duets CASCADE;
TRUNCATE dancers CASCADE;
TRUNCATE sport_categories CASCADE;
TRUNCATE age_categories CASCADE;
TRUNCATE trainers CASCADE;
TRUNCATE judicial_categories CASCADE;
TRUNCATE directions CASCADE;
TRUNCATE classes CASCADE;
TRUNCATE programs CASCADE;


INSERT INTO competition_statuses (name_st_competition)
VALUES ('Международные');
INSERT INTO competition_statuses (name_st_competition)
VALUES ('Всероссийские');
INSERT INTO competition_statuses (name_st_competition)
VALUES ('Межрегиональные');
INSERT INTO competition_statuses (name_st_competition)
VALUES ('Региональные');
INSERT INTO competition_statuses (name_st_competition)
VALUES ('Муниципальные');


INSERT INTO judicial_categories (name_jud_cat)
VALUES ('Судья по массовому спорту');
INSERT INTO judicial_categories (name_jud_cat, description_jud_cat)
VALUES ('Третья', 'Cоревнования среди пар до D-класса включительно');
INSERT INTO judicial_categories (name_jud_cat, description_jud_cat)
VALUES ('Вторая', 'до C-класса');
INSERT INTO judicial_categories (name_jud_cat, description_jud_cat)
VALUES ('Первая', 'S-класс и выше, соревнования до всероссийского уровня');
INSERT INTO judicial_categories (name_jud_cat)
VALUES ('Всероссийская');
INSERT INTO judicial_categories (name_jud_cat, description_jud_cat)
VALUES ('Международная', 'Обслуживает все соревнования');

INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Дети-1', '9 лет и моложе');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Дети-2', '10-11 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Юниоры-1', '12-13 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Юниоры-2', '14-15 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Молодёжь', '16-18 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Молодёжь-2', '19-20 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Взрослые', '21 год и старше');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Сеньоры-1', 'старшему в паре от 35 лет, младшему от 30 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Сеньоры-2', 'старшему от 45 лет, младшему от 40 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Сеньоры-3', 'старшему от 55 лет, младшему от 50 лет');
INSERT INTO age_categories (name_age_cat, description_age_cat)
VALUES ('Сеньоры-4', 'старшему от 65 лет, младшему от 60 лет');

INSERT INTO sport_categories (name_sport_cat)
VALUES ('I юнош.');
INSERT INTO sport_categories (name_sport_cat)
VALUES ('II юнош.');
INSERT INTO sport_categories (name_sport_cat)
VALUES ('III юнош.');
INSERT INTO sport_categories (name_sport_cat)
VALUES ('I взр.');
INSERT INTO sport_categories (name_sport_cat)
VALUES ('II взр.');
INSERT INTO sport_categories (name_sport_cat)
VALUES ('III взр.');
INSERT INTO sport_categories (name_sport_cat, description_sport_cat)
VALUES ('КМС', 'Кандидат в мастера спорта');
INSERT INTO sport_categories (name_sport_cat, description_sport_cat)
VALUES ('МС', 'Мастер спорта');
INSERT INTO sport_categories (name_sport_cat, description_sport_cat)
VALUES ('МСМК', 'Мастер спорта России международного класса');


INSERT INTO types_lessons(name_type_lesson, description_type_lesson)
VALUES ('Индивидуальное', 'занимается один ученик');
INSERT INTO types_lessons(name_type_lesson, description_type_lesson)
VALUES ('Групповое', 'занимается вся группа одновременно');
INSERT INTO types_lessons(name_type_lesson, description_type_lesson)
VALUES ('Парное', 'танцуют двое');

INSERT INTO programs(name_program)
VALUES ('Латиноамериканская');
INSERT INTO programs(name_program)
VALUES ('Европейская');


INSERT INTO directions(name_direction, id_program)
VALUES ('Самба', 
	(SELECT id_program
	FROM programs
	WHERE name_program = 'Латиноамериканская'));
INSERT INTO directions(name_direction, id_program)
VALUES ('Ча-ча-ча',
		(SELECT id_program
		FROM programs
		WHERE name_program = 'Латиноамериканская'));
INSERT INTO directions(name_direction, id_program)
VALUES ('Румба', 
		(SELECT id_program
		FROM programs
		WHERE name_program = 'Латиноамериканская'));
INSERT INTO directions(name_direction, id_program)
VALUES ('Медленный вальс',
	(SELECT id_program 
	FROM programs 
	WHERE name_program = 'Европейская'));
INSERT INTO directions(name_direction, id_program)
VALUES ('Танго', 
	(SELECT id_program
	FROM programs
	WHERE name_program = 'Европейская'));
INSERT INTO directions(name_direction, id_program)
VALUES ('Квикстеп', 
		(SELECT id_program
		FROM programs
		WHERE name_program = 'Европейская'));
INSERT INTO directions(name_direction)
VALUES ('Cтретчинг');
INSERT INTO directions(name_direction)
VALUES ('Хореография');
INSERT INTO directions(name_direction)
VALUES ('Джаз-фанк');


INSERT INTO classes (id_program,  dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs
		WHERE name_program = 'Европейская'), 'S', 24);


INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs 
		WHERE name_program = 'Европейская'), 
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'S' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Европейская')
		),'A', 22);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs 
		WHERE name_program = 'Европейская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'A' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Европейская')
		),'B', 20);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program 
		FROM programs
		WHERE name_program = 'Европейская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'B' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Европейская')
		),'C', 18);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs
		WHERE name_program = 'Европейская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'C' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Европейская')
		),'D', 16);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs 
		WHERE name_program = 'Европейская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'D' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Европейская')
		),'E', 0);
		


INSERT INTO classes (id_program, dance_class, transition_points)
VALUES ((SELECT id_program 
		FROM programs 
		WHERE name_program = 'Латиноамериканская'), 'S', 24);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program 
		FROM programs
		WHERE name_program = 'Латиноамериканская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'S' AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Латиноамериканская')
		),'A', 22);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs 
		WHERE name_program = 'Латиноамериканская'),
		(
		SELECT id_class
		FROM classes  
		WHERE dance_class = 'A'  AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Латиноамериканская')
		),'B', 20);
INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program 
		FROM programs 
		WHERE name_program = 'Латиноамериканская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'B'  AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Латиноамериканская')
		),'C', 18);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs 
		WHERE name_program = 'Латиноамериканская'),
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'C'  AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Латиноамериканская')
		),'D', 16);

INSERT INTO classes (id_program, id_next_class, dance_class, transition_points)
VALUES ((SELECT id_program
		FROM programs
		WHERE name_program = 'Латиноамериканская'), 
		(
		SELECT id_class
		FROM classes
		WHERE dance_class = 'D'  AND 
		id_program = (SELECT id_program 
						FROM programs 
						WHERE name_program = 'Латиноамериканская')
		),'E', 0);


INSERT INTO countries (name_country)
VALUES ('Россия');
INSERT INTO countries (name_country)
VALUES ('Белоруссия');
INSERT INTO countries (name_country)
VALUES ('Китай');
INSERT INTO countries (name_country)
VALUES ('Казахстан');
INSERT INTO countries (name_country)
VALUES ('Турция');

INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country
		FROM countries
		WHERE name_country = 'Россия'), 'Москва');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country 
		FROM countries 
		WHERE name_country = 'Россия'), 'Санкт-Петербург');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country 
		FROM countries
		WHERE name_country = 'Белоруссия'), 'Минск');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country
		FROM countries 
		WHERE name_country = 'Казахстан'), 'Астана');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country 
		FROM countries
		WHERE name_country = 'Китай'), 'Пекин');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country
		FROM countries
		WHERE name_country = 'Турция'), 'Анкара');
INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country
		FROM countries
		WHERE name_country = 'Казахстан'), 'Алматы');

INSERT INTO cities (id_country, name_city)
VALUES ((SELECT id_country
		FROM countries
		WHERE name_country = 'Белоруссия'), 'Гродно');



INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city 
		FROM cities 
		WHERE name_city = 'Москва'), 
		'Тверская улица', '12, стр. 1', 'Sense', 'Студия современных танцев для детей и взрослых');
INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city 
		FROM cities 
		WHERE name_city = 'Санкт-Петербург'),
		'Невский проспект', '88', 'Северная Палитра', 'Школа танцев европейской и латиноамериканской программы');
INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city 
		FROM cities
		WHERE name_city = 'Минск'),
		'проспект Независимости', '40', 'Силуэт', 'Танцевально-спортивный клуб бального танца');
INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city 
		FROM cities 
		WHERE name_city = 'Астана'),
		'улица Достык', '5', 'Астана Dance', 'Центр бального танца');
INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city 
		FROM cities 
		WHERE name_city = 'Пекин'),
		'улица Чанъаньцзе', '18', 'Lotus Dance Studio', 'Международный центр спортивных бальных танцев');
INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city
		FROM cities
		WHERE name_city = 'Анкара'), 
		'бульвар Ататюрка', '102', 'Bosphorus Dance', 'Спортивно-танцевальный клуб');

INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city
		FROM cities 
		WHERE name_city = 'Гродно'), 
        'Советская улица', '15', 'Неман Dance', 'Танцевальный клуб');

INSERT INTO address (id_city, street, house, club_name, description_club)
VALUES ((SELECT id_city
		FROM cities
		WHERE name_city = 'Алматы'), 
        'проспект Абая', '50', 'Almaty Dance', 'Школа танцев');



INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Sense'), 
		70, 700, 'Зал 1');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Sense'),
		160, 2000, 'Зал 2');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Северная Палитра'), 
		180, 3000, 'Зал 1');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address 
		FROM address 
		WHERE club_name = 'Силуэт'), 
		150, 2000, 'Зал 1');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Астана Dance'),
		75, 800, 'Зал Луна');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address
		WHERE club_name = 'Астана Dance'),
		90, 1000, 'Большой зал');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address
		WHERE club_name = 'Lotus Dance Studio'), 200, 4000, 'Зал 1');
INSERT INTO halls (id_address, square, rental_price, name_hall)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Bosphorus Dance'), 150, 3500, 'Зал 4');

INSERT INTO dancing_groups (name_group)
VALUES  ('Дети (Самба)');
INSERT INTO dancing_groups (name_group)
VALUES  ('Юниоры-1 (Медленный вальс)');
INSERT INTO dancing_groups (name_group)
VALUES  ('Джаз-фанк Начинающие');
INSERT INTO dancing_groups (name_group)
VALUES  ('Группа №4 (Cтретчинг)');

INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Дети (Самба)'), '15:00:00', 1);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups 
		WHERE name_group = 'Дети (Самба)'),'15:00:00', 3);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Дети (Самба)'), '17:00:00', 5);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group
		FROM dancing_groups
		WHERE name_group = 'Юниоры-1 (Медленный вальс)'), '12:00:00', 6);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups 
		WHERE name_group = 'Юниоры-1 (Медленный вальс)'), '12:00:00', 7);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Джаз-фанк Начинающие'), '21:00:00', 2);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Джаз-фанк Начинающие'), '22:00:00', 4);
INSERT INTO schedules_group (id_group, time_group, day_week)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Группа №4 (Cтретчинг)'), '19:00:00', 6);


INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address
		WHERE club_name = 'Sense'), 
		(SELECT id_status_competition 
		 FROM competition_statuses
		 WHERE name_st_competition = 'Всероссийские'), 
 'Moscow Dance Cup', '2026-10-10', '2026-10-12');
 
INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address
		WHERE club_name = 'Северная Палитра'), 
		(SELECT id_status_competition
		 FROM competition_statuses
		 WHERE name_st_competition = 'Всероссийские'), 
 'Кубок Северной Палитры', '2026-10-24', '2026-10-25');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Силуэт'), 
		(SELECT id_status_competition
		 FROM competition_statuses
		 WHERE name_st_competition = 'Международные'), 
 'Minsk - Open Championship', '2026-11-05', '2026-11-07');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address 
		FROM address
		WHERE club_name = 'Астана Dance'), 
		(SELECT id_status_competition
		 FROM competition_statuses
		 WHERE name_st_competition = 'Региональные'), 
 'Кубок / Астаны', '2026-11-14', '2026-11-15');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Lotus Dance Studio'), 
		(SELECT id_status_competition
		 FROM competition_statuses 
		 WHERE name_st_competition = 'Международные'), 
 'Asian_Dance_Grand_Prix', '2026-12-01', '2026-12-03');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Bosphorus Dance'), 
		 (SELECT id_status_competition
		 FROM competition_statuses 
		 WHERE name_st_competition = 'Региональные'), 
 'Bosphorus Trophy', '2024-12-12', '2024-12-13');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address
		FROM address 
		WHERE club_name = 'Sense'), 
		(SELECT id_status_competition
		 FROM competition_statuses
		 WHERE name_st_competition = 'Муниципальные'), 
 'Осеннее Первенство Москвы', '2026-09-26', '2026-09-27');

INSERT INTO competitions (id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_status_competition
		FROM competition_statuses
		WHERE name_st_competition = 'Муниципальные'),
		'Летнее Первенство Москвы', '2026-07-26', '2026-07-27');

INSERT INTO competitions (id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_status_competition
		FROM competition_statuses
		WHERE name_st_competition = 'Муниципальные'),
		'Кубок Москвы', '2026-06-06', '2026-06-07');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address 
		FROM address
		WHERE club_name = 'Силуэт'), 
        (SELECT id_status_competition
		FROM competition_statuses
		WHERE name_st_competition = 'Международные'), 
        'Кубок Минска', '2026-11-20', '2026-11-22');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address 
		FROM address 
		WHERE club_name = 'Неман Dance'), 
        (SELECT id_status_competition
		FROM competition_statuses
		WHERE name_st_competition = 'Региональные'), 
        'Открытый Кубок Гродно', '2025-12-05', '2025-12-06');

INSERT INTO competitions (id_address, id_status_competiton, name_competition, start_date, end_date)
VALUES ((SELECT id_address 
		FROM address 
		WHERE club_name = 'Almaty Dance'), 
        (SELECT id_status_competition 
		FROM competition_statuses 
		WHERE name_st_competition = 'Региональные'), 
        'Almaty Spring Cup', '2024-05-10', '2024-05-12');





INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Иванов', 'Иван', 'Иванович', '+79001151111', 'iii@mail.ru', 'м', 
		(SELECT id_judicial_cat
		FROM judicial_categories
		WHERE name_jud_cat = 'Первая'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Петрова', 'Анна', 'Сергеевна', '+79002342222', 'panns@mail.ru', 'ж',
		(SELECT id_judicial_cat 
		FROM judicial_categories
		WHERE name_jud_cat = 'Вторая'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Сидоров', 'Алексей', 'Петрович', '+79003331333', 'sap@mail.ru', 'м', 
		(SELECT id_judicial_cat
		FROM judicial_categories
		WHERE name_jud_cat = 'Третья'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Смирнова', 'Ольга', 'Игоревна', '+79004445444', 'soi@mail.ru', 'ж',
		(SELECT id_judicial_cat 
		FROM judicial_categories
		WHERE name_jud_cat = 'Судья по массовому спорту'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Попов', 'Дмитрий', 'Александрович', '+79005555555', 'pdma@mail.ru', 'м', 
		(SELECT id_judicial_cat 
		FROM judicial_categories
		WHERE name_jud_cat = 'Международная'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer, id_judicial_cat)
VALUES ('Васильева', 'Елена', 'Дмитриевна', '+79006123666', 'ved@mail.ru', 'ж',
		(SELECT id_judicial_cat 
		FROM judicial_categories 
		WHERE name_jud_cat = 'Всероссийская'));
INSERT INTO trainers (surname_trainer, name_trainer, patronymic_trainer, phone_numb_trainer, email_trainer, gender_trainer)
VALUES ('Соколовский', 'Игорь', 'Олегович', '+79007774777', 'sio@mail.ru', 'м');

INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer
		FROM trainers 
		WHERE email_trainer = 'panns@mail.ru'), 
	(SELECT id_direction
	FROM directions
	WHERE name_direction = 'Джаз-фанк'), 400);
	
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'pdma@mail.ru'), 
	(SELECT id_direction 
	FROM directions
	WHERE name_direction = 'Самба'), 300);
	
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer 
		FROM trainers
		WHERE email_trainer = 'ved@mail.ru'), 
	(SELECT id_direction
	FROM directions
	WHERE name_direction = 'Cтретчинг'), 500);

INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'sio@mail.ru'), 
	(SELECT id_direction
	FROM directions
	WHERE name_direction = 'Медленный вальс'), 300);
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer
		FROM trainers
		WHERE email_trainer = 'sio@mail.ru'), 
	(SELECT id_direction 
	FROM directions
	WHERE name_direction = 'Квикстеп'), 300);
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer 
		FROM trainers
		WHERE email_trainer = 'iii@mail.ru'), 
		(SELECT id_direction
		FROM directions
		WHERE name_direction = 'Танго'), 500);
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'sap@mail.ru'), 
		(SELECT id_direction 
		FROM directions
		WHERE name_direction = 'Хореография'), 300);
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer
		FROM trainers 
		WHERE email_trainer = 'ved@mail.ru'), 
		(SELECT id_direction
		FROM directions 
		WHERE name_direction = 'Ча-ча-ча'), 500);
INSERT INTO specialization (id_trainer, id_direction, service_price)
VALUES ((SELECT id_trainer
		FROM trainers 
		WHERE email_trainer = 'panns@mail.ru'), 
		(SELECT id_direction 
		FROM directions
		WHERE name_direction = 'Румба'), 400);




INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Ким', 'Артём', 'Андреевич', '+79018888888', 'kaa@mail.ru', '2017-05-10', 'м', 
	(SELECT id_sport_cat 
	FROM sport_categories 
	WHERE name_sport_cat = 'I юнош.'), 
	(SELECT id_age_cat 
	FROM age_categories 
	WHERE name_age_cat = 'Дети-1'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Новикова', 'Мария', 'Владимировна', '+79009999999', 'nmv@mail.ru', '2013-03-15', 'ж', 
	(SELECT id_sport_cat 
	FROM sport_categories 
	WHERE name_sport_cat = 'III юнош.'), 
	(SELECT id_age_cat
	FROM age_categories
	WHERE name_age_cat = 'Юниоры-1'));
INSERT INTO dancers (surname_dancer, name_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Моль', 'Егор', '+79031010101', 'med@mail.ru', '2010-08-20', 'м', 
	(SELECT id_sport_cat 
	FROM sport_categories 
	WHERE name_sport_cat = 'I взр.'), 
	(SELECT id_age_cat 
	FROM age_categories 
	WHERE name_age_cat = 'Юниоры-2'));
INSERT INTO dancers (surname_dancer, name_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Валь', 'Дарья', '+7992020202', 'vdr@mail.ru', '2008-11-01', 'ж', 
		(SELECT id_sport_cat 
		FROM sport_categories
		WHERE name_sport_cat = 'КМС'),
		(SELECT id_age_cat 
		FROM age_categories 
		WHERE name_age_cat = 'Молодёжь'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Устинов', 'Максим', 'Владиславович', '+7932020221', 'umv@mail.ru', '2008-12-06', 'м', 
		(SELECT id_sport_cat
		FROM sport_categories 
		WHERE name_sport_cat = 'КМС'),
		(SELECT id_age_cat 
		FROM age_categories 
		WHERE name_age_cat = 'Молодёжь'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Соловьев', 'Кирилл', 'Антонович', '+79003030303', 'ska@mail.ru', '2003-01-12', 'м', 
		(SELECT id_sport_cat 
		FROM sport_categories 
		WHERE name_sport_cat = 'МС'),
		(SELECT id_age_cat 
		FROM age_categories
		WHERE name_age_cat = 'Взрослые'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_age_cat)
VALUES ('Соловьева', 'Анна', 'Эдуардовна', '+79053012343', 'sanna@mail.ru', '2005-03-03', 'ж', 
		(SELECT id_age_cat
		FROM age_categories
		WHERE name_age_cat = 'Взрослые'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_sport_cat, id_age_cat)
VALUES ('Зайцева', 'Анна', 'Игоревна', '+79024040404', 'zai@mail.ru', '2017-06-25', 'ж',
		(SELECT id_sport_cat 
		FROM sport_categories 
		WHERE name_sport_cat = 'III юнош.'),
		(SELECT id_age_cat
		FROM age_categories 
		WHERE name_age_cat = 'Дети-1'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_age_cat)
VALUES ('Пестель', 'Никита', 'Сергеевич', '+79015150505', 'pns@mail.ru', '2012-04-18', 'м',
		(SELECT id_age_cat 
		FROM age_categories
		WHERE name_age_cat = 'Юниоры-1'));
INSERT INTO dancers (surname_dancer, name_dancer, patronymic_dancer, phone_numb_dancer, email_dancer, date_of_birth_dancer, gender_dancer, id_age_cat)
VALUES ('Василевская', 'Арина', 'Владимировна', '+79115750585', 'vav@mail.ru', '2012-05-20', 'ж',
		(SELECT id_age_cat
		FROM age_categories 
		WHERE name_age_cat = 'Юниоры-1'));



INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer 
		FROM dancers
		WHERE email_dancer = 'ska@mail.ru'),
		(SELECT id_dancer 
		FROM dancers
		WHERE email_dancer = 'sanna@mail.ru'));

INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'nmv@mail.ru'),
		(SELECT id_dancer
		FROM dancers
		WHERE email_dancer = 'pns@mail.ru'));

INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer
		FROM dancers 
		WHERE email_dancer = 'nmv@mail.ru'),
		(SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'med@mail.ru'));

INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'vdr@mail.ru'),
		(SELECT id_dancer 
		FROM dancers
		WHERE email_dancer = 'umv@mail.ru'));

INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'zai@mail.ru'),
		(SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'kaa@mail.ru'));

INSERT INTO dance_duets (id_second_partner, id_first_partner)
VALUES ((SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'vav@mail.ru'),
		(SELECT id_dancer
		FROM dancers 
		WHERE email_dancer = 'pns@mail.ru'));





INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Дети (Самба)'),
    (SELECT id_dancer
	FROM dancers
	WHERE email_dancer = 'kaa@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group 
		FROM dancing_groups WHERE name_group = 'Дети (Самба)'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'zai@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group
		FROM dancing_groups
		WHERE name_group = 'Юниоры-1 (Медленный вальс)'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'nmv@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Юниоры-1 (Медленный вальс)'),
    (SELECT id_dancer
	FROM dancers 
	WHERE email_dancer = 'vav@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group 
		FROM dancing_groups 
		WHERE name_group = 'Джаз-фанк Начинающие'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'vav@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Джаз-фанк Начинающие'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'vdr@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Джаз-фанк Начинающие'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'pns@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group 
		FROM dancing_groups 
		WHERE name_group = 'Группа №4 (Cтретчинг)'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'vdr@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Группа №4 (Cтретчинг)'),
    (SELECT id_dancer 
	FROM dancers 
	WHERE email_dancer = 'sanna@mail.ru'));

INSERT INTO group_structure (id_group, id_dancer)
VALUES ((SELECT id_group 
		FROM dancing_groups
		WHERE name_group = 'Группа №4 (Cтретчинг)'),
    (SELECT id_dancer
	FROM dancers 
	WHERE email_dancer = 'nmv@mail.ru'));




INSERT INTO competition_program (id_competition, id_direction, id_class)
VALUES ((SELECT id_competition 
		FROM competitions 
		WHERE name_competition = 'Moscow Dance Cup'),
    (SELECT id_direction 
	FROM directions
	WHERE name_direction = 'Самба'),
    (SELECT id_class 
	FROM classes 
	WHERE dance_class = 'C' AND id_program = (SELECT id_program 
											FROM directions 
											WHERE name_direction = 'Самба')));

INSERT INTO competition_program (id_competition, id_direction, id_class)
VALUES ((SELECT id_competition
		FROM competitions
		WHERE name_competition = 'Кубок Северной Палитры'),
    (SELECT id_direction 
	FROM directions 
	WHERE name_direction = 'Медленный вальс'),
    (SELECT id_class 
	FROM classes WHERE dance_class = 'B' AND id_program = (SELECT id_program 
															FROM directions
															WHERE name_direction = 'Медленный вальс')));


INSERT INTO competition_program (id_competition, id_direction, id_class)
VALUES ((SELECT id_competition 
		FROM competitions 
		WHERE name_competition = 'Осеннее Первенство Москвы'),
    (SELECT id_direction 
	FROM directions
	WHERE name_direction = 'Танго'),
	(SELECT id_class 
	FROM classes 
	WHERE dance_class = 'B' AND id_program = (SELECT id_program 
											FROM directions
											WHERE name_direction = 'Танго')));


INSERT INTO competition_program (id_competition, id_direction, id_class)
VALUES ((SELECT id_competition
		FROM competitions 
		WHERE name_competition = 'Moscow Dance Cup'),
    (SELECT id_direction 
	FROM directions 
	WHERE name_direction = 'Ча-ча-ча'),
    (SELECT id_class 
	FROM classes 
	WHERE dance_class = 'D' AND id_program = (SELECT id_program 
											FROM directions
											WHERE name_direction = 'Ча-ча-ча')));

INSERT INTO competition_program (id_competition, id_direction, id_class)
VALUES ((SELECT id_competition
		FROM competitions
		WHERE name_competition = 'Minsk - Open Championship'),
    (SELECT id_direction
	FROM directions 
	WHERE name_direction = 'Румба'),
    (SELECT id_class
	FROM classes 
	WHERE dance_class = 'A' AND id_program = (SELECT id_program
											FROM directions 
											WHERE name_direction = 'Румба')));


INSERT INTO participants (id_group)
VALUES ((SELECT id_group
		FROM dancing_groups
		WHERE name_group = 'Дети (Самба)'));

INSERT INTO participants (id_group)
VALUES ((SELECT id_group 
		FROM dancing_groups 
		WHERE name_group = 'Юниоры-1 (Медленный вальс)'));

INSERT INTO participants (id_group)
VALUES ((SELECT id_group
		FROM dancing_groups 
		WHERE name_group = 'Джаз-фанк Начинающие'));

INSERT INTO participants (id_group)
VALUES ((SELECT id_group
		FROM dancing_groups
		WHERE name_group = 'Группа №4 (Cтретчинг)'));


INSERT INTO participants (id_duet)
VALUES ((SELECT id_duet 
		FROM dance_duets 
		WHERE id_first_partner = (SELECT id_dancer 
								FROM dancers 
								WHERE email_dancer = 'sanna@mail.ru')
	 AND id_second_partner = (SELECT id_dancer
	 						FROM dancers 
							 WHERE email_dancer = 'ska@mail.ru')));

INSERT INTO participants (id_duet)
VALUES ((SELECT id_duet
		FROM dance_duets
		WHERE id_second_partner = (SELECT id_dancer 
									FROM dancers 
									WHERE email_dancer = 'vdr@mail.ru')
		AND id_first_partner = (SELECT id_dancer
								FROM dancers
								WHERE email_dancer = 'umv@mail.ru')));

INSERT INTO participants (id_dancer)
VALUES ((SELECT id_dancer
		FROM dancers
		WHERE email_dancer = 'zai@mail.ru'));



INSERT INTO classification_book (id_class, id_dancer, points, date_assignment)
VALUES ((SELECT id_class 
		FROM classes
		WHERE dance_class  = 'B' AND id_program = (SELECT id_program 
													FROM programs
													WHERE name_program = 'Латиноамериканская')), 
		(SELECT id_dancer 
		FROM dancers 
		WHERE email_dancer = 'zai@mail.ru'),
	5, '2026-09-01');

INSERT INTO classification_book (id_class, id_duet, points, date_assignment)
VALUES ((SELECT id_class 
		FROM classes 
		WHERE dance_class = 'S' AND id_program = (SELECT id_program 
												FROM programs 
												WHERE name_program = 'Европейская')),
	(SELECT id_duet 
	FROM dance_duets
	WHERE id_first_partner = (SELECT id_dancer
							FROM dancers 
							WHERE email_dancer = 'sanna@mail.ru')
	AND id_second_partner = (SELECT id_dancer
							FROM dancers 
							WHERE email_dancer = 'ska@mail.ru')),
	24, '2026-08-31');

INSERT INTO classification_book (id_class, id_duet, points, date_assignment)
VALUES ((SELECT id_class
		FROM classes 
		WHERE dance_class = 'A' AND id_program = (SELECT id_program
												FROM programs
												WHERE name_program = 'Латиноамериканская')),
		(SELECT id_duet
		FROM dance_duets 
		WHERE id_second_partner = (SELECT id_dancer
									FROM dancers 
									WHERE email_dancer = 'vdr@mail.ru')
		AND id_first_partner = (SELECT id_dancer
								FROM dancers 
								WHERE email_dancer = 'umv@mail.ru')),
		10, '2026-07-10');

INSERT INTO classification_book (id_class, id_dancer, points, date_assignment)
VALUES ((SELECT id_class 
		FROM classes 
		WHERE dance_class  = 'B' AND id_program = (SELECT id_program
												FROM programs 
												WHERE name_program = 'Европейская')), 
	(SELECT id_dancer
	FROM dancers 
	WHERE email_dancer = 'pns@mail.ru'),
	3, '2026-06-01');
		
INSERT INTO classification_book (id_class, id_dancer, points, date_assignment)
VALUES ((SELECT id_class 
		FROM classes 
		WHERE dance_class  = 'D' AND id_program = (SELECT id_program 
													FROM programs
													WHERE name_program = 'Европейская')), 
		(SELECT id_dancer
		FROM dancers 
		WHERE email_dancer = 'kaa@mail.ru'),
	13, '2025-05-01');





INSERT INTO registration (id_participant, id_comp_program)
SELECT 
    (SELECT id_participant
	FROM participants 
     WHERE id_group = (SELECT id_group 
	 				FROM dancing_groups 
					 WHERE name_group = 'Дети (Самба)')),
    (SELECT id_comp_program 
	FROM competition_program 
     WHERE id_competition = (SELECT id_competition
	 						FROM competitions 
							 WHERE name_competition = 'Moscow Dance Cup')
       AND id_direction = (SELECT id_direction
	   						FROM directions 
							WHERE name_direction = 'Самба'));


INSERT INTO registration (id_participant, id_comp_program)
SELECT 
    (SELECT id_participant
	FROM participants 
     WHERE id_group = (SELECT id_group
	 					FROM dancing_groups
						WHERE name_group = 'Юниоры-1 (Медленный вальс)')),
    (SELECT id_comp_program
	FROM competition_program 
     WHERE id_competition = (SELECT id_competition
	 						FROM competitions 
							 WHERE name_competition = 'Кубок Северной Палитры')
     AND id_direction = (SELECT id_direction 
	 					FROM directions 
						 WHERE name_direction = 'Медленный вальс'));

INSERT INTO registration (id_participant, id_comp_program)
SELECT 
    (SELECT id_participant
	FROM participants 
     WHERE id_duet = (
         SELECT id_duet 
		 FROM dance_duets 
         WHERE id_first_partner = (SELECT id_dancer 
		 							FROM dancers
									 WHERE email_dancer = 'sanna@mail.ru')
         AND id_second_partner = (SELECT id_dancer
		 						FROM dancers
								 WHERE email_dancer = 'ska@mail.ru'))),
    (SELECT id_comp_program
	FROM competition_program 
     WHERE id_competition = (SELECT id_competition 
							 FROM competitions
							 WHERE name_competition = 'Minsk - Open Championship')
       AND id_direction = (SELECT id_direction
	   						FROM directions 
							WHERE name_direction = 'Румба'));



INSERT INTO registration (id_participant, id_comp_program)
SELECT 
    (SELECT id_participant
	FROM participants 
     WHERE id_duet = (
         SELECT id_duet
		 FROM dance_duets 
         WHERE id_second_partner = (SELECT id_dancer 
		 							FROM dancers 
									 WHERE email_dancer = 'vdr@mail.ru')
           AND id_first_partner = (SELECT id_dancer
		   						FROM dancers
								   WHERE email_dancer = 'umv@mail.ru'))),
    (SELECT id_comp_program 
	FROM competition_program 
     WHERE id_competition = (SELECT id_competition
	 						FROM competitions 
							 WHERE name_competition = 'Moscow Dance Cup')
       AND id_direction = (SELECT id_direction
	   						FROM directions 
							WHERE name_direction = 'Ча-ча-ча'));


INSERT INTO registration (id_participant, id_comp_program)
SELECT 
    (SELECT id_participant 
	FROM participants 
     WHERE id_dancer = (SELECT id_dancer 
	 					FROM dancers
						 WHERE email_dancer = 'zai@mail.ru')),
    (SELECT id_comp_program 
	FROM competition_program 
     WHERE id_competition = (SELECT id_competition 
	 						FROM competitions
							 WHERE name_competition = 'Moscow Dance Cup')
       AND id_direction = (SELECT id_direction 
	   						FROM directions 
							WHERE name_direction = 'Самба'));

INSERT INTO lessons (id_direction, id_trainer, id_hall, id_schedule_group, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction 
		FROM directions 
		WHERE name_direction = 'Медленный вальс'), 
		(SELECT id_trainer
		FROM trainers 
		WHERE email_trainer = 'sio@mail.ru'),
		(SELECT id_hall 
		FROM halls
		WHERE name_hall = 'Зал 2' AND id_address = (SELECT id_address
													FROM address 
													WHERE club_name = 'Sense')),
		(SELECT id_schedule_group 
		FROM schedules_group 
		WHERE id_group = (SELECT id_group
						FROM dancing_groups
						WHERE name_group = 'Юниоры-1 (Медленный вальс)') AND day_week = '6'),
		(SELECT id_type_lesson
		FROM types_lessons 
		WHERE name_type_lesson = 'Групповое'),
		(SELECT id_participant 
		FROM participants 
		WHERE id_group = (SELECT id_group
						FROM dancing_groups 
						WHERE name_group = 'Юниоры-1 (Медленный вальс)')),
		'2026-09-6', 60, 
		((SELECT service_price
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer
							FROM trainers 
							WHERE email_trainer = 'sio@mail.ru') 
		AND 
		id_direction = (SELECT id_direction
						FROM directions 
						WHERE name_direction = 'Медленный вальс'))
		+ 
		(SELECT rental_price
		FROM halls 
		WHERE name_hall = 'Зал 2' AND id_address = (SELECT id_address 
													FROM address 
													WHERE club_name = 'Sense'))));


INSERT INTO lessons (id_direction, id_trainer, id_hall, id_schedule_group, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction 
		FROM directions 
		WHERE name_direction = 'Самба'), 
		(SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'pdma@mail.ru'),
		(SELECT id_hall
		FROM halls 
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address
													FROM address 
													WHERE club_name = 'Sense')),
		(SELECT id_schedule_group 
		FROM schedules_group 
		WHERE id_group = (SELECT id_group 
						FROM dancing_groups
						WHERE name_group = 'Дети (Самба)') AND day_week = '1'),
		(SELECT id_type_lesson 
		FROM types_lessons 
		WHERE name_type_lesson = 'Групповое'),
		(SELECT id_participant
		FROM participants
		WHERE id_group = (SELECT id_group
						FROM dancing_groups
						WHERE name_group = 'Дети (Самба)')),
		'2026-09-7', 90,
		((SELECT service_price 
		FROM specialization
		WHERE 
		id_trainer = (SELECT id_trainer
					FROM trainers 
					WHERE email_trainer = 'pdma@mail.ru') 
		AND 
		id_direction = (SELECT id_direction
						FROM directions 
						WHERE name_direction = 'Самба'))
		+ 
		(SELECT rental_price
		FROM halls
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address
													FROM address 
													WHERE club_name = 'Sense'))));


INSERT INTO lessons (id_direction, id_trainer, id_hall, id_schedule_group, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction 
		FROM directions 
		WHERE name_direction = 'Cтретчинг'), 
		(SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'ved@mail.ru'),
		(SELECT id_hall
		FROM halls 
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address
													FROM address
													WHERE club_name = 'Северная Палитра')),
		(SELECT id_schedule_group 
		FROM schedules_group
		WHERE id_group = (SELECT id_group 
						FROM dancing_groups 
						WHERE name_group = 'Группа №4 (Cтретчинг)') AND day_week = '6'),
		(SELECT id_type_lesson 
		FROM types_lessons
		WHERE name_type_lesson = 'Групповое'),
		(SELECT id_participant 
		FROM participants 
		WHERE id_group = (SELECT id_group 
						FROM dancing_groups 
						WHERE name_group = 'Группа №4 (Cтретчинг)')),
		'2026-09-7', 90,
		((SELECT service_price
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer
							FROM trainers 
							WHERE email_trainer = 'ved@mail.ru') 
		AND 
		id_direction = (SELECT id_direction 
						FROM directions
						WHERE name_direction = 'Cтретчинг'))
		+ 
		(SELECT rental_price
		FROM halls 
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address
													FROM address 
													WHERE club_name = 'Северная Палитра'))));

INSERT INTO lessons (id_direction, id_trainer, id_hall, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction
		FROM directions 
		WHERE name_direction = 'Cтретчинг'), 
		(SELECT id_trainer
		FROM trainers 
		WHERE email_trainer = 'ved@mail.ru'),
		(SELECT id_hall
		FROM halls
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address 
													FROM address 
													WHERE club_name = 'Северная Палитра')),
		(SELECT id_type_lesson 
		FROM types_lessons 
		WHERE name_type_lesson = 'Парное'),
		(SELECT id_participant 
		FROM participants 
		WHERE id_duet = (SELECT id_duet 
						FROM dance_duets 
        				WHERE id_first_partner = (SELECT id_dancer
													FROM dancers
													WHERE email_dancer = 'sanna@mail.ru')
         				AND id_second_partner = (SELECT id_dancer 
		 										FROM dancers 
												 WHERE email_dancer = 'ska@mail.ru'))),
		'2026-09-07 15:00:00', 90,
		((SELECT service_price
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer 
							FROM trainers 
							WHERE email_trainer = 'ved@mail.ru') 
		AND id_direction = (SELECT id_direction
							FROM directions 
							WHERE name_direction = 'Cтретчинг'))
		+ 
		(SELECT rental_price
		FROM halls 
		WHERE name_hall = 'Зал 1' AND id_address = (SELECT id_address 
													FROM address
													WHERE club_name = 'Северная Палитра'))));

INSERT INTO lessons (id_direction, id_trainer, id_hall, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction 
		FROM directions 
		WHERE name_direction = 'Танго'), 
		(SELECT id_trainer
		FROM trainers
		WHERE email_trainer = 'iii@mail.ru'),
		(SELECT id_hall 
		FROM halls
		WHERE name_hall = 'Зал Луна' AND id_address = (SELECT id_address
														FROM address
														WHERE club_name = 'Астана Dance')),
		(SELECT id_type_lesson 
		FROM types_lessons 
		WHERE name_type_lesson = 'Парное'),
		(SELECT id_participant 
		FROM participants
		WHERE id_duet = (SELECT id_duet 
						FROM dance_duets 
        				WHERE id_second_partner = (SELECT id_dancer 
												FROM dancers
												WHERE email_dancer = 'vdr@mail.ru')
						AND id_first_partner = (SELECT id_dancer 
												FROM dancers
												WHERE email_dancer = 'umv@mail.ru'))),
		'2026-09-07 16:00:00', 90,
		((SELECT service_price
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer
							FROM trainers
							WHERE email_trainer = 'iii@mail.ru') 
							AND id_direction = (SELECT id_direction
												FROM directions 
												WHERE name_direction = 'Танго'))
		+ 
		(SELECT rental_price 
		FROM halls 
		WHERE name_hall = 'Зал Луна' AND id_address = (SELECT id_address 
														FROM address
														WHERE club_name = 'Астана Dance'))));


INSERT INTO lessons (id_direction, id_trainer, id_hall, id_schedule_group, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction 
		FROM directions
		WHERE name_direction = 'Джаз-фанк'), 
		(SELECT id_trainer 
		FROM trainers 
		WHERE email_trainer = 'panns@mail.ru'),
		(SELECT id_hall 
		FROM halls
		WHERE name_hall = 'Большой зал' AND id_address = (SELECT id_address
														FROM address
														WHERE club_name = 'Астана Dance')),
		(SELECT id_schedule_group
		FROM schedules_group
		WHERE id_group = (SELECT id_group 
						FROM dancing_groups
						WHERE name_group = 'Джаз-фанк Начинающие') 
						AND day_week = '4'),
		(SELECT id_type_lesson 
		FROM types_lessons 
		WHERE name_type_lesson = 'Групповое'),
		(SELECT id_participant 
		FROM participants 
		WHERE id_group = (SELECT id_group 
						FROM dancing_groups
						WHERE name_group = 'Джаз-фанк Начинающие')),
		'2026-09-07 16:00:00', 90,
		((SELECT service_price 
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer
							FROM trainers 
							WHERE email_trainer = 'panns@mail.ru') 
							AND id_direction = (SELECT id_direction
												FROM directions 
												WHERE name_direction = 'Джаз-фанк'))
		+ 
		(SELECT rental_price
		FROM halls 
		WHERE name_hall = 'Большой зал' AND id_address = (SELECT id_address
															FROM address
															WHERE club_name = 'Астана Dance'))));

INSERT INTO lessons (id_direction, id_trainer, id_hall, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction
		FROM directions 
		WHERE name_direction = 'Танго'), 
		(SELECT id_trainer
		FROM trainers
		WHERE email_trainer = 'iii@mail.ru'),
		(SELECT id_hall 
		FROM halls 
		WHERE name_hall = 'Зал Луна' AND id_address = (SELECT id_address 
														FROM address
														WHERE club_name = 'Астана Dance')),
		(SELECT id_type_lesson 
		FROM types_lessons 
		WHERE name_type_lesson = 'Парное'),
		(SELECT id_participant
		FROM participants
		WHERE id_duet = (SELECT id_duet 
						FROM dance_duets 
         				WHERE id_second_partner = (SELECT id_dancer 
						 							FROM dancers
													 WHERE email_dancer = 'vdr@mail.ru')
						AND
	    				id_first_partner = (SELECT id_dancer 
											FROM dancers
											WHERE email_dancer = 'umv@mail.ru'))),
		'2026-09-07', 120,
		((SELECT service_price 
		FROM specialization 
		WHERE id_trainer = (SELECT id_trainer
							FROM trainers 
							WHERE email_trainer = 'iii@mail.ru') 
		AND	id_direction = (SELECT id_direction
							FROM directions 
							WHERE name_direction = 'Танго'))
		+ 
		(SELECT rental_price 
		FROM halls
		WHERE name_hall = 'Зал Луна' AND id_address = (SELECT id_address 
														FROM address
														WHERE club_name = 'Астана Dance'))));

INSERT INTO lessons (id_direction, id_trainer, id_hall, id_type_lesson, id_participant, date_lesson, duration, cost_lesson)
VALUES ((SELECT id_direction
		FROM directions 
		WHERE name_direction = 'Джаз-фанк'), 
		(SELECT id_trainer
		FROM trainers
		WHERE email_trainer = 'panns@mail.ru'),
		(SELECT id_hall 
		FROM halls
		WHERE name_hall = 'Зал Луна' 
		AND id_address = (SELECT id_address
						FROM address 
						WHERE club_name = 'Астана Dance')),
		(SELECT id_type_lesson
		FROM types_lessons
		WHERE name_type_lesson = 'Индивидуальное'),
		(SELECT id_participant 
		FROM participants 
		WHERE id_group = (SELECT id_group
						FROM dancing_groups 
						WHERE name_group = 'Джаз-фанк Начинающие')),
		'2026-09-07 20:00:00', 90,
		((SELECT service_price 
		FROM specialization
		WHERE id_trainer = (SELECT id_trainer 
							FROM trainers
							WHERE email_trainer = 'panns@mail.ru') 
		AND id_direction = (SELECT id_direction
							FROM directions
							WHERE name_direction = 'Джаз-фанк'))
		+ 
		(SELECT rental_price
		FROM halls 
		WHERE name_hall = 'Зал Луна' AND id_address = (SELECT id_address
														FROM address 
														WHERE club_name = 'Астана Dance'))));
