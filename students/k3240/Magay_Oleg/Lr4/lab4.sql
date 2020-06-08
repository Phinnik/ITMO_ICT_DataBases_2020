-- Имена и возраст всех сотрудников со стажем не меньше 5 лет и старше 25.
SELECT "Аэропорт"."Сотрудник"."ФИО", "Аэропорт"."Сотрудник"."Возраст"  FROM "Аэропорт"."Сотрудник"
WHERE "Аэропорт"."Сотрудник"."Стаж" > 5 AND "Аэропорт"."Сотрудник"."Возраст" < '25';

-- Список всех самолетов с идентификационными названиями отсортировано по личному номеру каждого самолета.
SELECT "Аэропорт"."Самолет"."Название", "Аэропорт"."Самолет"."Тип" FROM "Аэропорт"."Самолет" 
WHERE "Аэропорт"."Самолет"."Номер самолета" < ANY 
(SELECT "Аэропорт"."Самолет"."Название" FROM "Аэропорт"."Самолет");

-- Смежная таблица всех рейсов и самолетов летевшим по данным направлениям.
SELECT * FROM "Аэропорт"."Рейс" INNER JOIN "Аэропорт"."Самолет" 
ON "Аэропорт"."Рейс"."Номер рейса" = "Аэропорт"."Самолет"."Номер отдела";

-- Средняя вместимость всех данных самолетов. 
select round(avg("Аэропорт"."Самолет"."Число мест")) from "Аэропорт"."Самолет";

-- Количество подписанных договоров по номерам отделов.
select "Аэропорт"."Самолет"."Номер отдела", sum("Аэропорт"."Самолет"."Заключение договоров") as "Количество" 
from "Аэропорт"."Самолет"
GROUP BY "Номер отдела";

-- Какие типа самолетов соответствуют каждому рейсу и отделу по типу самолета.
select "Аэропорт"."Самолет"."Тип","Аэропорт"."Самолет"."Номер отдела", "Аэропорт"."Рейс"."Номер рейса","Аэропорт"."Авиаперевозчик"."Номер отдела"
FROM "Аэропорт"."Самолет", "Аэропорт"."Рейс", "Аэропорт"."Авиаперевозчик"
WHERE "Аэропорт"."Самолет"."Номер отдела" = "Аэропорт"."Авиаперевозчик"."Номер отдела" 
and "Аэропорт"."Рейс"."Номер рейса" = "Аэропорт"."Авиаперевозчик"."Номер отдела"
ORDER BY "Аэропорт"."Самолет"."Тип";

-- Объединенная строка названия самолета и типа и номера отдела принадлежности.
select CONCAT("Аэропорт"."Самолет"."Название", ' by ', "Аэропорт"."Самолет"."Тип"), "Аэропорт"."Самолет"."Номер отдела" 
from "Аэропорт"."Самолет";

-- Количество рейсов выполненных или запланированных по определенным датам.
select "Аэропорт"."Рейс"."Дата и время", Count("Аэропорт"."Рейс"."Номер рейса")
FROM "Аэропорт"."Рейс", "Аэропорт"."Самолет"
WHERE "Аэропорт"."Рейс"."Номер рейса" = "Аэропорт"."Самолет"."Номер отдела"
GROUP BY "Аэропорт"."Рейс"."Дата и время"; 

-- Какие самолеты летали по определенным датам по названию.
select "Аэропорт"."Самолет"."Название", "Аэропорт"."Рейс"."Дата и время" 
FROM "Аэропорт"."Самолет", "Аэропорт"."Рейс"
WHERE "Дата и время" > timestamp '2019-01-01' and
	"Аэропорт"."Самолет"."Номер отдела" = "Аэропорт"."Рейс"."Номер рейса";
	
-- Какие типы самолета пренадлежат 1-му отделу определенного авиаперевозчика.
Select "Аэропорт"."Самолет"."Тип" from "Аэропорт"."Самолет"
WHERE "Аэропорт"."Самолет"."Номер отдела" IN 
(SELECT "Аэропорт"."Авиаперевозчик"."Номер отдела" from "Аэропорт"."Авиаперевозчик"
 Where "Аэропорт"."Авиаперевозчик"."Номер отдела" = 1);