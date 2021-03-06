﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура КУТ_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	УстановитьЗадолженностьПоставщика();
	
КонецПроцедуры

&НаКлиенте
Процедура КУТ_ОбработкаНавигационнойСсылкиПеред(НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ВзаиморасчетыПоОрганизации" Тогда
		СтандартнаяОбработка = Ложь;
		
		УсловияОтбора = Новый Структура("Партнер, Организация", Объект.Партнер, Объект.Организация);
		ПараметрыФормы = Новый Структура("Отбор, СформироватьПриОткрытии", УсловияОтбора, Истина);
	
		ОткрытьФорму("Отчет.РасчетыСПоставщиками.Форма", ПараметрыФормы, ЭтотОбъект);  
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "Взаиморасчеты" Тогда
		СтандартнаяОбработка = Ложь;
		
		УсловияОтбора = Новый Структура("Партнер", Объект.Партнер);
		ПараметрыФормы = Новый Структура("Отбор, СформироватьПриОткрытии", УсловияОтбора, Истина);
	
		ОткрытьФорму("Отчет.РасчетыСПоставщиками.Форма", ПараметрыФормы, ЭтотОбъект);  
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура КУТ_ПослеЗаписиНаСервереПосле(ТекущийОбъект, ПараметрыЗаписи)
	
	УстановитьЗадолженностьПоставщика();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КУТ_ПартнерПриИзмененииПосле(Элемент)
	
	УстановитьЗадолженностьПоставщика();
	
КонецПроцедуры

&НаКлиенте
Процедура КУТ_ОрганизацияПриИзмененииПосле(Элемент)
	
	УстановитьЗадолженностьПоставщика();
	
КонецПроцедуры

&НаКлиенте
Процедура КУТ_ДатаПриИзмененииПосле(Элемент)
	
	УстановитьЗадолженностьПоставщика();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьЗадолженностьПоставщика()
	
	Обработки.ЗадолженностьПартнеров.УстановитьЗадолженностьПоставщика(ЭтотОбъект, Объект);
	
КонецПроцедуры

#КонецОбласти
