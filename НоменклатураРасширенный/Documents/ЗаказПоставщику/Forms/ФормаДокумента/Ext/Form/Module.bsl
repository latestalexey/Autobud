﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура Номенклатура_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ Параметры.Свойство("ПараметрыКорзины") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Склад") Тогда
		Объект.Склад = Параметры.Склад;
	КонецЕсли;
	
	ПараметрыКорзины = Параметры.ПараметрыКорзины;
	Если ПараметрыКорзины.Свойство("АдресКорзиныВХранилище") И ЗначениеЗаполнено(ПараметрыКорзины.АдресКорзиныВХранилище) Тогда
		ТаблицаДляЗагрузки = ПолучитьИзВременногоХранилища(ПараметрыКорзины.АдресКорзиныВХранилище);
		Объект.Товары.Загрузить(ТаблицаДляЗагрузки);
		ПерезаполнитьРеквизитыТовары = Истина;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ПриОткрытии(Отказ)
	
	Если НЕ ПерезаполнитьРеквизитыТовары Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТекущаяСтрока Из Объект.Товары Цикл
		
		СтруктураПересчетаСуммы = ПолучитьСтруктуруПересчетаСуммыНДСВСтрокеТЧ(ЭтаФорма);
		
		СтруктураДействий = Новый Структура;
		СтруктураДействий.Вставить("ПроверитьХарактеристикуПоВладельцу", ТекущаяСтрока.Характеристика);
		СтруктураДействий.Вставить("ЗаполнитьПризнакАртикул", Новый Структура("Номенклатура", "Артикул"));
		СтруктураДействий.Вставить("ПроверитьЗаполнитьУпаковкуПоВладельцу", ТекущаяСтрока.Упаковка);
		СтруктураДействий.Вставить("ЗаполнитьПризнакАналитикаРасходовОбязательна");
		СтруктураДействий.Вставить("ЗаполнитьНоменклатуруПоставщикаПоНоменклатуре", Объект.Партнер);
		СтруктураДействий.Вставить("ПроверитьСтатьюАналитикуРасходов", ТекущаяСтрока.Номенклатура);
		СтруктураДействий.Вставить(
			"ПроверитьСопоставленнуюНоменклатуруПоставщика",
			ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруПроверкиСопоставленнойНоменклатурыПоставщикаВСтрокеТЧ(
			Объект,
			НеВыполнятьПроверкуСопоставленнойНоменклатурыПоставщика));
		СтруктураДействий.Вставить(
			"ПроверитьЗаполнитьСклад",
			ОбработкаТабличнойЧастиКлиентСервер.ПолучитьСтруктуруЗаполненияСкладаВСтрокеТЧ(
			Объект,
			СкладГруппа));
		СтруктураДействий.Вставить("ПересчитатьКоличествоЕдиниц");
	
		СтруктураДействий.Вставить("ЗаполнитьСтавкуНДС", Объект.НалогообложениеНДС);
		СтруктураДействий.Вставить("ЗаполнитьСтавкуНДСВозвратнойТары", Объект.ВернутьМногооборотнуюТару);
		СтруктураДействий.Вставить("ПересчитатьСуммуНДС", СтруктураПересчетаСуммы);
		СтруктураДействий.Вставить("ПересчитатьСуммуСНДС", СтруктураПересчетаСуммы);
		СтруктураДействий.Вставить("ПересчитатьСумму");
		СтруктураДействий.Вставить("ПересчитатьСуммуСУчетомРучнойСкидки", Новый Структура("Очищать", Истина));
		СтруктураДействий.Вставить("ЗаполнитьПризнакТипНоменклатуры", Новый Структура("Номенклатура", "ТипНоменклатуры"));
		СтруктураДействий.Вставить("ЗаполнитьПризнакБезВозвратнойТары", Объект.ВернутьМногооборотнуюТару);
		СтруктураДействий.Вставить("ЗаполнитьПризнакОтмененоБезВозвратнойТары", Объект.ВернутьМногооборотнуюТару);
		СтруктураДействий.Вставить("ЗаполнитьДубликатыЗависимыхРеквизитов", ЗависимыеРеквизиты());
		
		Если КонтролироватьАссортимент Тогда
			СтруктураПроверкиАссортимента = АссортиментКлиентСервер.ПараметрыПроверкиАссортимента();
			СтруктураПроверкиАссортимента.Ссылка = Объект.Ссылка;
			СтруктураПроверкиАссортимента.Склад = Объект.Склад;
			СтруктураПроверкиАссортимента.Дата = ?(ЗначениеЗаполнено(Объект.ЖелаемаяДатаПоступления), Объект.ЖелаемаяДатаПоступления, Объект.Дата);
			СтруктураПроверкиАссортимента.ТекстСообщения = НСтр("ru = 'Товар %1 не включен в ассортимент магазина. Заказывать его не рекомендуется.'");
			СтруктураПроверкиАссортимента.ИмяРесурсаАссортимента = "РазрешеныЗакупки";
			СтруктураПроверкиАссортимента.ПровереноМожноДобавлять = Истина;
			СтруктураПроверкиАссортимента.РазрешатьДобавление = Истина;
			//
			СтруктураДействий.Вставить("ПроверитьАссортиментСтроки", СтруктураПроверкиАссортимента);
		КонецЕсли;
		НаправленияДеятельностиКлиентСервер.СтруктураДействийВставитьПриДобавленииСтроки(ЭтаФорма, СтруктураДействий);
		СтруктураДействий.Вставить("НоменклатураПриИзмененииПереопределяемый", Новый Структура("ИмяФормы, ИмяТабличнойЧасти",
			ЭтаФорма.ИмяФормы, "Товары"));
		
		ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
		
		Если ТекущаяСтрока.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Товар") Или
			ТекущаяСтрока.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.МногооборотнаяТара") Или 
			ТекущаяСтрока.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Набор") Тогда
			ТекущаяСтрока.СписатьНаРасходы = Ложь;
			ТекущаяСтрока.СтатьяРасходов = ПредопределенноеЗначение("ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка");
			ТекущаяСтрока.АналитикаРасходов = Неопределено;
			ТекущаяСтрока.Подразделение = ПредопределенноеЗначение("Справочник.СтруктураПредприятия.ПустаяСсылка");
		ИначеЕсли ТекущаяСтрока.ТипНоменклатуры = ПредопределенноеЗначение("Перечисление.ТипыНоменклатуры.Услуга") Тогда
			ТекущаяСтрока.СписатьНаРасходы = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	РассчитатьИтоговыеПоказателиЗаказа(ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

