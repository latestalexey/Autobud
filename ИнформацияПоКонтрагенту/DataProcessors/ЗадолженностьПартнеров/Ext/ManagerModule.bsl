﻿#Область ЗадолженностьКлиента

Функция ЗадолженностьКлиента(Партнер, Организация, Дата)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Партнер", Партнер);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Период", Новый Граница(Дата, ВидГраницы.Включая));
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СУММА(ЕстьNull(РасчетыСКлиентамиОстатки.СуммаОстаток,0)) КАК СуммаДолга
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами.Остатки(&Период, ) КАК РасчетыСКлиентамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСКлиентамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Партнер = &Партнер
	|	И РегистрАналитикаУчетаПоПартнерам.Организация = &Организация";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СуммаДолга = Выборка.СуммаДолга;
	Иначе
		СуммаДолга = 0;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(СуммаДолга) Тогда
		СуммаДолга = 0;
	КонецЕсли;
	
	Возврат СуммаДолга;
	
КонецФункции

Функция НадписьЗадолженностьКлиента(СуммаДолга) Экспорт
	
	КрупныйШрифт = Новый Шрифт(,11);
	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Должен нам'") + " ", КрупныйШрифт, ЦветаСтиля.ПоясняющийТекст));
	
	СуммаСтрокой = Формат(СуммаДолга, "ЧДЦ=2; ЧРД=,; ЧРГ=' '; ЧН=0,00");
	ПозицияРазделителя = СтрНайти(СуммаСтрокой, ",");
	КомпонентыЧисла = Новый Массив;
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Лев(СуммаСтрокой, ПозицияРазделителя), КрупныйШрифт));
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Сред(СуммаСтрокой, ПозицияРазделителя+1), Новый Шрифт(,8)));
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(КомпонентыЧисла, , , , "Взаиморасчеты"));
	
	Возврат Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецФункции

Процедура УстановитьЗадолженностьКлиента(Форма, Объект) Экспорт
	
	Элементы = Форма.Элементы;
	Если НЕ ЗначениеЗаполнено(Объект.Организация) ИЛИ НЕ ЗначениеЗаполнено(Объект.Партнер) Тогда
		Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	Если НЕ ПравоДоступа("Просмотр", Метаданные.РегистрыНакопления.РасчетыСКлиентами) Тогда
		Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Истина;
	
	СуммаДолга = ЗадолженностьКлиента(Объект.Партнер, Объект.Организация, Объект.Дата);
	Элементы.ОстатокВзаиморасчетовКлиент.Заголовок = НадписьЗадолженностьКлиента(СуммаДолга);
	
КонецПроцедуры

#КонецОбласти

#Область ЗадолженностьПоставщика

Функция ЗадолженностьПоставщика(Партнер, Организация, Дата)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Партнер", Партнер);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Период", Новый Граница(Дата, ВидГраницы.Включая));
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	-СУММА(ЕСТЬNULL(РасчетыСПоставщикамиОстатки.СуммаОстаток, 0)) КАК СуммаДолга
	|ИЗ
	|	РегистрНакопления.РасчетыСПоставщиками.Остатки(&Период, ) КАК РасчетыСПоставщикамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСПоставщикамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Партнер = &Партнер
	|	И РегистрАналитикаУчетаПоПартнерам.Организация = &Организация";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СуммаДолга = Выборка.СуммаДолга;
	Иначе
		СуммаДолга = 0;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(СуммаДолга) Тогда
		СуммаДолга = 0;
	КонецЕсли;
	
	Возврат СуммаДолга;
	
КонецФункции

Функция НадписьЗадолженностьПоставщика(СуммаДолга) Экспорт
	
	КрупныйШрифт = Новый Шрифт(,11);
	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru='Мы должны'") + " ", КрупныйШрифт, ЦветаСтиля.ПоясняющийТекст));
	
	СуммаСтрокой = Формат(СуммаДолга, "ЧДЦ=2; ЧРД=,; ЧРГ=' '; ЧН=0,00");
	ПозицияРазделителя = СтрНайти(СуммаСтрокой, ",");
	КомпонентыЧисла = Новый Массив;
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Лев(СуммаСтрокой, ПозицияРазделителя), КрупныйШрифт));
	КомпонентыЧисла.Добавить(Новый ФорматированнаяСтрока(Сред(СуммаСтрокой, ПозицияРазделителя+1), Новый Шрифт(,8)));
	
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(КомпонентыЧисла, , , , "Взаиморасчеты"));
	
	Возврат Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецФункции

Процедура УстановитьЗадолженностьПоставщика(Форма, Объект) Экспорт
	
	Элементы = Форма.Элементы;
	Если НЕ ЗначениеЗаполнено(Объект.Организация) ИЛИ НЕ ЗначениеЗаполнено(Объект.Партнер) Тогда
		Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	Если НЕ ПравоДоступа("Просмотр", Метаданные.РегистрыНакопления.РасчетыСПоставщиками) Тогда
		Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаОстатокВзаиморасчетов.Видимость = Истина;
	
	СуммаДолга = ЗадолженностьПоставщика(Объект.Партнер, Объект.Организация, Объект.Дата);
	Элементы.ОстатокВзаиморасчетовПоставщик.Заголовок = НадписьЗадолженностьПоставщика(СуммаДолга);
	
КонецПроцедуры

#КонецОбласти

#Область ЗадолженностьПартнера

Функция ЗадолженностьПартнера(Партнер) Экспорт
	
	ЗадолженностьПартнера = Новый Структура;
	ЗадолженностьПартнера.Вставить("МыДолжны", 0);
	ЗадолженностьПартнера.Вставить("НамДолжны", 0);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Партнер", Партнер);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	-СУММА(ЕСТЬNULL(РасчетыСПоставщикамиОстатки.СуммаОстаток, 0)) КАК МыДолжны
	|ИЗ
	|	РегистрНакопления.РасчетыСПоставщиками.Остатки(, ) КАК РасчетыСПоставщикамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСПоставщикамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Партнер = &Партнер
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СУММА(ЕСТЬNULL(РасчетыСКлиентамиОстатки.СуммаОстаток, 0)) КАК НамДолжны
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами.Остатки(, ) КАК РасчетыСКлиентамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСКлиентамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Партнер = &Партнер";

	РезультатЗапроса = Запрос.ВыполнитьПакет();
	ВыборкаПоставщик = РезультатЗапроса[0].Выбрать();
	Если ВыборкаПоставщик.Следующий() Тогда
		ЗадолженностьПартнера.МыДолжны = ВыборкаПоставщик.МыДолжны;
	КонецЕсли;
	ВыборкаКлиент = РезультатЗапроса[1].Выбрать();
	Если ВыборкаКлиент.Следующий() Тогда
		ЗадолженностьПартнера.НамДолжны = ВыборкаКлиент.НамДолжны;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ЗадолженностьПартнера.МыДолжны) Тогда
		ЗадолженностьПартнера.МыДолжны = 0;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ЗадолженностьПартнера.НамДолжны) Тогда
		ЗадолженностьПартнера.НамДолжны = 0;
	КонецЕсли;
	
	Возврат ЗадолженностьПартнера;
	
КонецФункции

Функция ЗадолженностьКонтрагента(Контрагент) Экспорт
	
	ЗадолженностьКонтрагента = Новый Структура;
	ЗадолженностьКонтрагента.Вставить("МыДолжны", 0);
	ЗадолженностьКонтрагента.Вставить("НамДолжны", 0);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	-СУММА(ЕСТЬNULL(РасчетыСПоставщикамиОстатки.СуммаОстаток, 0)) КАК МыДолжны
	|ИЗ
	|	РегистрНакопления.РасчетыСПоставщиками.Остатки(, ) КАК РасчетыСПоставщикамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСПоставщикамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Контрагент = &Контрагент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СУММА(ЕСТЬNULL(РасчетыСКлиентамиОстатки.СуммаОстаток, 0)) КАК НамДолжны
	|ИЗ
	|	РегистрНакопления.РасчетыСКлиентами.Остатки(, ) КАК РасчетыСКлиентамиОстатки
	|		{ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК РегистрАналитикаУчетаПоПартнерам
	|		ПО РасчетыСКлиентамиОстатки.АналитикаУчетаПоПартнерам = РегистрАналитикаУчетаПоПартнерам.КлючАналитики}
	|ГДЕ
	|	РегистрАналитикаУчетаПоПартнерам.Партнер <> ЗНАЧЕНИЕ(Справочник.Партнеры.НашеПредприятие)
	|	И РегистрАналитикаУчетаПоПартнерам.Контрагент = &Контрагент";

	РезультатЗапроса = Запрос.ВыполнитьПакет();
	ВыборкаПоставщик = РезультатЗапроса[0].Выбрать();
	Если ВыборкаПоставщик.Следующий() Тогда
		ЗадолженностьКонтрагента.МыДолжны = ВыборкаПоставщик.МыДолжны;
	КонецЕсли;
	ВыборкаКлиент = РезультатЗапроса[1].Выбрать();
	Если ВыборкаКлиент.Следующий() Тогда
		ЗадолженностьКонтрагента.НамДолжны = ВыборкаКлиент.НамДолжны;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ЗадолженностьКонтрагента.МыДолжны) Тогда
		ЗадолженностьКонтрагента.МыДолжны = 0;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ЗадолженностьКонтрагента.НамДолжны) Тогда
		ЗадолженностьКонтрагента.НамДолжны = 0;
	КонецЕсли;
	
	Возврат ЗадолженностьКонтрагента;
	
КонецФункции

#КонецОбласти
