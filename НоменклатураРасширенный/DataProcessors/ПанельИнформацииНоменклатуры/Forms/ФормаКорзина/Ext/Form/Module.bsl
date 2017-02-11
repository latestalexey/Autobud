﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АдресКорзиныВХранилище") И ЗначениеЗаполнено(Параметры.АдресКорзиныВХранилище) Тогда
		ТаблицаДляЗагрузки = ПолучитьИзВременногоХранилища(Параметры.АдресКорзиныВХранилище);
		Корзина.Загрузить(ТаблицаДляЗагрузки);
	КонецЕсли;
	Если Параметры.Свойство("ПоказыватьЦены") Тогда
		ПоказыватьЦены = Параметры.ПоказыватьЦены;
	КонецЕсли;
	Если Параметры.Свойство("ОтборВидЦен") Тогда
		ОтборВидЦен = Параметры.ОтборВидЦен;
	КонецЕсли;
	Если Параметры.Свойство("ОтборСклад") Тогда
		ОтборСклад = Параметры.ОтборСклад;
	КонецЕсли;
	
	Элементы.СоздатьЗаказКлиента.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ЗаказКлиента);
	Элементы.СоздатьЗаказПоставщику.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ЗаказПоставщику);
	Элементы.СоздатьПоступлениеТоваровУслуг.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ПоступлениеТоваровУслуг);
	Элементы.СоздатьРеализацияТоваровУслуг.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.РеализацияТоваровУслуг);
	Элементы.СоздатьПеремещениеТоваров.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ПеремещениеТоваров);
	Элементы.СоздатьЧекККМ.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ЧекККМ);
	Элементы.СоздатьЗаказНаПеремещение.Видимость = ПравоДоступа("Редактирование", Метаданные.Документы.ЗаказНаПеремещение);
	
	ОбновитьИтогиПодобранныхТоваров(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если НЕ РазрешитьЗакрытие Тогда
		Отказ=Истина;
		ПодключитьОбработчикОжидания("ЗакрытьФормуПеренестиКорзину", 0.1, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФормуПеренестиКорзину() Экспорт
	
	РазрешитьЗакрытие = Истина;
	Если ПеренестиВДокумент Тогда
		Закрыть("ПеренестиВДокумент");
	Иначе
		СтруктураЗакрытия = Новый Структура("Корзина", Корзина);
		Закрыть(СтруктураЗакрытия);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСКорзиной

&НаКлиенте
Процедура КорзинаЦенаКоличествоПриИзменении(Элемент)
	
	СтрокаКорзины = Элементы.Корзина.ТекущиеДанные;
	СтрокаКорзины.КоличествоУпаковок = СтрокаКорзины.Количество;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьСумму");
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(СтрокаКорзины, СтруктураДействий, Неопределено);
	
	ОбновитьИтогиПодобранныхТоваров(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьКорзину(Команда)
	
	Корзина.Очистить();
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьПодбор()
	
	СтруктураЗакрытия = Новый Структура("Корзина, ПеренестиВДокумент", Корзина, ПеренестиВДокумент);
	Закрыть(СтруктураЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура КорзинаПриИзменении(Элемент)
	
	ОбновитьИтогиПодобранныхТоваров(ЭтаФорма);
	
КонецПроцедуры

//Обновляет итоги подобранных товаров в форме Корзина справочника Номенклатура
&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьИтогиПодобранныхТоваров(Форма)
	
	Если ЗначениеЗаполнено(Форма.ОтборВидЦен) Тогда
		Форма.НадписьПодобраноТоваров = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Подобрано: %1 на сумму %2'"),
			Форма.Корзина.Итог("Количество"),
			Формат(Форма.Корзина.Итог("Сумма"),"ЧДЦ=2; ЧН=0"));
	Иначе
		Форма.НадписьПодобраноТоваров = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Подобрано: %1'"),
			Форма.Корзина.Итог("Количество")
			);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КорзинаХарактеристикаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущиеДанные = Элементы.Корзина.ТекущиеДанные;
	ОписаниеОповещения = Новый ОписаниеОповещения("КорзинаХарактеристикаНачалоВыбораЗавершение", ЭтотОбъект, ТекущиеДанные);
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Номенклатура", ТекущиеДанные.Номенклатура);
	Если ЗначениеЗаполнено(ОтборСклад) Тогда
		МассивСкладов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОтборСклад);
	Иначе
		МассивСкладов = ВсеСклады();
	КонецЕсли;
	СтруктураПараметров.Вставить("ОтборСклад", МассивСкладов);
	
	ОткрытьФорму("Обработка.ПанельИнформацииНоменклатуры.Форма.ФормаВыбораХарактеристики", СтруктураПараметров, ЭтотОбъект,,,,ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура КорзинаХарактеристикаНачалоВыбораЗавершение(Результат, ТекущиеДанные) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ТекущиеДанные.Характеристика = Результат;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВсеСклады()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Склады.Ссылка
	|ИЗ
	|	Справочник.Склады КАК Склады
	|ГДЕ
	|	Склады.ПометкаУдаления = ЛОЖЬ";
	РезультатЗапроса = Запрос.Выполнить();
	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Ссылка");
	
КонецФункции

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьРеализацияТоваровУслуг(Команда)
	СоздатьДокумент("РеализацияТоваровУслуг");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЧекККМ(Команда)
	СоздатьДокумент("ЧекККМ");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПоступлениеТоваровУслуг(Команда)
	СоздатьДокумент("ПоступлениеТоваровУслуг");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаказКлиента(Команда)
	СоздатьДокумент("ЗаказКлиента");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаказПоставщику(Команда)
	СоздатьДокумент("ЗаказПоставщику");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьЗаказНаПеремещение(Команда)
	СоздатьДокумент("ЗаказНаПеремещение");
КонецПроцедуры

&НаКлиенте
Процедура СоздатьПеремещениеТоваров(Команда)
	СоздатьДокумент("ПеремещениеТоваров");
КонецПроцедуры

#КонецОбласти

#Область СозданиеДокументов

&НаСервере
Функция ПараметрыСозданияДокумента()

	ДанныеЗаполнения = Новый Структура;
	ДанныеЗаполнения.Вставить("ВидЦен", ОтборВидЦен);
	Если ЗначениеЗаполнено(ОтборСклад) И НЕ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОтборСклад, "ЭтоГруппа") Тогда
		ДанныеЗаполнения.Вставить("Склад", ОтборСклад);
	КонецЕсли;
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ДанныеЗаполнения);
	ПараметрыФормы.Вставить("ПараметрыКорзины", ЗаписатьПодборВХранилище());
	ПараметрыФормы.Вставить("ВидЦен", ОтборВидЦен);
	Если ЗначениеЗаполнено(ОтборСклад) И НЕ ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ОтборСклад, "ЭтоГруппа") Тогда
		ПараметрыФормы.Вставить("Склад", ОтборСклад);
	КонецЕсли;
	
	Возврат ПараметрыФормы;
	
КонецФункции

&НаСервере
// Функция помещает результаты подбора в хранилище
//
// Возвращает структуру:
//	Структура
//		- Адрес в хранилище, куда помещена выбранная номенклатура (корзина);
//		- Уникальный идентификатор формы владельца, необходим для идентификации при обработке результатов подбора;
//
Функция ЗаписатьПодборВХранилище() 
	
	ПодобранныеТовары = Корзина.Выгрузить();
	АдресКорзиныВХранилище = ПоместитьВоВременноеХранилище(ПодобранныеТовары, УникальныйИдентификатор);
	Возврат Новый Структура("АдресКорзиныВХранилище, УникальныйИдентификаторФормыВладельца", АдресКорзиныВХранилище, УникальныйИдентификатор);
	
КонецФункции

&НаКлиенте
Процедура СоздатьДокумент(ИмяДокумента)
	
	Если ИмяДокумента = "ЧекККМ" Тогда
		Документ = "Документ.ЧекККМ.Форма.ФормаДокументаРМК";
	Иначе
		Документ = СтрШаблон("Документ.%1.ФормаОбъекта", ИмяДокумента);
	КонецЕсли;
	
	ПараметрыФормы = ПараметрыСозданияДокумента();
	ОткрытьФорму(Документ, ПараметрыФормы,,Новый УникальныйИдентификатор);
	ПеренестиВДокумент = Истина;
	ЗакрытьФормуПеренестиКорзину();
	
КонецПроцедуры

#КонецОбласти