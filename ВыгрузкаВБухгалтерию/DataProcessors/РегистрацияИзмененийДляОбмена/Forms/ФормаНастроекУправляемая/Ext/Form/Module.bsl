﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗагружатьИзменения = Параметры.ЗагружатьИзменения;
	ОтображатьКоличествоОбъектовДляКоторыхЗарегистрированыИзменения = Параметры.ОтображатьКоличествоОбъектовДляКоторыхЗарегистрированыИзменения;
	РегистрироватьДвиженияДокументов = Параметры.РегистрироватьДвиженияДокументов;
	РежимОбновления = Параметры.РежимОбновления;
	
	Элементы.РежимОбновления.СписокВыбора.Добавить(0, "Только для элементов, для которых включена авторегистрация изменений");
	Элементы.РежимОбновления.СписокВыбора.Добавить(1, "Для всех элементов");
	
КонецПроцедуры

&НаКлиенте
Процедура ОК(Команда)
	
	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("ЗагружатьИзменения", ЗагружатьИзменения);
	СтруктураВозврата.Вставить("ОтображатьКоличествоОбъектовДляКоторыхЗарегистрированыИзменения", ОтображатьКоличествоОбъектовДляКоторыхЗарегистрированыИзменения);
	СтруктураВозврата.Вставить("РегистрироватьДвиженияДокументов", РегистрироватьДвиженияДокументов);
	СтруктураВозврата.Вставить("РежимОбновления", РежимОбновления);
	Оповестить("ИзменениеНастроекУправлениеРегистрациейИзменений", СтруктураВозврата, ЭтаФорма);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Закрыть();
	
КонецПроцедуры