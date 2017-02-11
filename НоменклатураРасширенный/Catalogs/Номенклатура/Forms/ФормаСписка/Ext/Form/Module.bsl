﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура Номенклатура_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УправлениеСписком();
	УправлениеФормой(ЭтотОбъект);
	
	РедактированиеЗаказаКлиента = ПравоДоступа("Редактирование", Метаданные.Документы.ЗаказКлиента);
	РедактированиеЗаказаПоставщику = ПравоДоступа("Редактирование", Метаданные.Документы.ЗаказПоставщику);
	РедактированиеПоступления = ПравоДоступа("Редактирование", Метаданные.Документы.ПоступлениеТоваровУслуг);
	РедактированиеРеализации = ПравоДоступа("Редактирование", Метаданные.Документы.РеализацияТоваровУслуг);
	РедактированиеПеремещение = ПравоДоступа("Редактирование", Метаданные.Документы.ПеремещениеТоваров);
	РедактированиеЧекККМ = ПравоДоступа("Редактирование", Метаданные.Документы.ЧекККМ);
	
	Элементы.ДокументЗаказКлиента1.Видимость = РедактированиеЗаказаКлиента;
	Элементы.ДокументЗаказПоставщику1.Видимость = РедактированиеЗаказаПоставщику;
	Элементы.ДокументПоступлениеТоваровУслугСоздатьИзКорзины1.Видимость = РедактированиеПоступления;
	Элементы.ДокументРеализацияТоваровУслугСоздатьИзКорзины1.Видимость = РедактированиеРеализации;
	Элементы.СоздатьПеремещениеТоваров1.Видимость = РедактированиеПеремещение;
	Элементы.СоздатьЧекККМ1.Видимость = РедактированиеЧекККМ;
	
	Элементы.ДокументЗаказКлиента.Видимость = РедактированиеЗаказаКлиента;
	Элементы.ДокументЗаказПоставщику.Видимость = РедактированиеЗаказаПоставщику;
	Элементы.ДокументПоступлениеТоваровУслугСоздатьИзКорзины.Видимость = РедактированиеПоступления;
	Элементы.ДокументРеализацияТоваровУслугСоздатьИзКорзины.Видимость = РедактированиеРеализации;
	Элементы.СоздатьПеремещениеТоваров.Видимость = РедактированиеПеремещение;
	Элементы.СоздатьЧекККМ.Видимость = РедактированиеЧекККМ;
	
	ДоступныЦены = ПравоДоступа("Просмотр", Метаданные.РегистрыСведений.ЦеныНоменклатуры);
	ВсеСклады.ЗагрузитьЗначения(ВсеСклады());
	
КонецПроцедуры

&НаСервере
Процедура Номенклатура_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	
	// Установим условное оформление
	
	// 1. Итоги по складам
	Элемент = УсловноеОформление.Элементы.Добавить();
	
	ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
	ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(Элементы.ИнформацияПоСкладам.Имя);
	
	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("ИнформацияПоСкладам.ЭтоИтог");
	ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ОтборЭлемента.ПравоеЗначение = Истина;
	
	Элемент.Оформление.УстановитьЗначениеПараметра("ЦветФона", ЦветаСтиля.ИтогиФон);
	
КонецПроцедуры

&НаСервере
Процедура Номенклатура_ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	УправлениеСписком();
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура Номенклатура_ДекорацияКорзинаНажатие(Элемент)
	
	ОткрытьКорзину();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ДекорацияКорзинаПроверкаПеретаскивания(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ДекорацияКорзинаПеретаскивание(Элемент, ПараметрыПеретаскивания, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДобавитьВКорзину(ПараметрыПеретаскивания.Значение);
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_НадписьПодобраноТоваровНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьКорзину();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ОтборОрганизацияПриИзмененииПеред(Элемент)
	
	УправлениеСписком();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ОтборСкладПриИзменении(Элемент)
	
	УправлениеСписком();
	ВывестиИнформациюПоСкладам();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ОтборОстаткиПриИзменении(Элемент)
	
	УстановитьЗначениеПараметраПоказыватьТолькоОстаткиСпискаНоменклатуры(ЭтаФорма);
	ВывестиИнформациюПоСкладам();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ОтборВидЦенПриИзменении(Элемент)
	
	УправлениеФормой(ЭтотОбъект);
	УправлениеСписком();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ОтборВидЦенОчистка(Элемент, СтандартнаяОбработка)
	
	УправлениеФормой(ЭтотОбъект);
	УправлениеСписком();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ЦеныОтПриИзменении(Элемент)
	
	УправлениеСписком();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ЦеныДоПриИзменении(Элемент)
	
	УправлениеСписком();
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ПоказыватьСкладыПриИзмененииПеред(Элемент)
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ИспользоватьФильтрыПриИзменении(Элемент)
	
	УправлениеСписком();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыСписок

&НаКлиенте
Процедура Номенклатура_СписокРасширенныйПоискНоменклатураПриАктивизацииСтрокиПеред(Элемент)
	
	ПодключитьОбработчикОжидания("ВывестиИнформациюПоСкладам", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СписокСтандартныйПоискНоменклатураПриАктивизацииСтрокиПеред(Элемент)
	
	ПодключитьОбработчикОжидания("ВывестиИнформациюПоСкладам", 0.1, Истина);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийТаблицыФормыИнформацияПоСкладам

&НаКлиенте
Процедура Номенклатура_ИнформацияПоСкладамПриИзменении(Элемент)
	
	СортироватьСкладыНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Номенклатура_ДобавитьВКорзинуИзСписка(Команда)
	
	ТекущиеДанные = ТекущиеДанныеСписка();
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДобавитьВКорзину(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_ДобавитьВКорзинуИзСпискаСКоличествомПеред(Команда)
	
	ТекущиеДанные = ТекущиеДанныеСписка();
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДобавитьВКорзину(ТекущиеДанные, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьЗаказКлиента(Команда)
	СоздатьДокумент("ЗаказКлиента");
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьРеализацияТоваровУслуг(Команда)
	СоздатьДокумент("РеализацияТоваровУслуг");
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьЧекККМПеред(Команда)
	СоздатьДокумент("ЧекККМ");
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьЗаказПоставщику(Команда)
	СоздатьДокумент("ЗаказПоставщику");
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьПоступлениеТоваровУслуг(Команда)
	СоздатьДокумент("ПоступлениеТоваровУслуг");
КонецПроцедуры

&НаКлиенте
Процедура Номенклатура_СоздатьПеремещениеТоваровПеред(Команда)
	СоздатьДокумент("ПеремещениеТоваров");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ТекущиеДанныеСписка()
	
	Если Элементы.СтраницыСписков.ТекущаяСтраница = Элементы.СтраницаРасширенныйПоискНоменклатура Тогда
		ТекущиеДанные = Элементы.СписокРасширенныйПоискНоменклатура.ТекущиеДанные;
	Иначе
		ТекущиеДанные = Элементы.СписокСтандартныйПоискНоменклатура.ТекущиеДанные;
	КонецЕсли;
	
	Возврат ТекущиеДанные;
	
КонецФункции

#Область Корзина

&НаКлиенте
Процедура ОткрытьКорзину()
	
	Если Корзина.Количество() > 0 Тогда
		ПараметрыКорзины = ЗаписатьПодборВХранилище();
		ОткрытьКорзинуПродолжить(ПараметрыКорзины);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКорзинуПродолжить(ПараметрыКорзины)
	
	ПередаваемыеПараметры = Новый Структура;
	ПередаваемыеПараметры.Вставить("АдресКорзиныВХранилище", 
		?(ЗначениеЗаполнено(ПараметрыКорзины), ПараметрыКорзины.АдресКорзиныВХранилище, Неопределено));
	ПередаваемыеПараметры.Вставить("ОтборВидЦен", ОтборВидЦен);
	ПередаваемыеПараметры.Вставить("ОтборСклад", ОтборСклад);
	
	ПередаваемыеПараметры.Вставить("УникальныйИдентификаторФормыВладельца", УникальныйИдентификатор);
	ОповещениеКорзинаЗакрытие = Новый ОписаниеОповещения("КорзинаЗакрытие",ЭтотОбъект);
	ОткрытьФорму(
		"Обработка.ПанельИнформацииНоменклатуры.Форма.ФормаКорзина",
		ПередаваемыеПараметры, 
		ЭтотОбъект,
		,
		,
		,
		ОповещениеКорзинаЗакрытие,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура КорзинаЗакрытие(ПараметрЗакрытия, Параметры) Экспорт

	Корзина.Очистить();
	
	Если ПараметрЗакрытия = Неопределено Тогда
		//Закрытие без сохранения
	ИначеЕсли ПараметрЗакрытия="ПеренестиВДокумент" Тогда
		//Закрытие без сохранения
	Иначе 
		//Закрытие с сохранением
		Для каждого СтрокаКорзины Из ПараметрЗакрытия.Корзина Цикл
			НоваяСтрокаКорзины = Корзина.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаКорзины, СтрокаКорзины);
		КонецЦикла;
	КонецЕсли;
	
	УправлениеФормой(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьВКорзину(ВыбранныеСтроки, ЗапрашиватьКоличество = Ложь)
	
	Если ТипЗнч(ВыбранныеСтроки) = Тип("Массив") Тогда
		Для Каждого ВыделеннаяСтрока Из ВыбранныеСтроки Цикл
			ДобавитьСтрокуВКорзину(ВыделеннаяСтрока, ЗапрашиватьКоличество);
		КонецЦикла;
	ИначеЕсли ТипЗнч(ВыбранныеСтроки) = Тип("СправочникСсылка.Номенклатура") ИЛИ 
		ТипЗнч(ВыбранныеСтроки) = Тип("ДанныеФормыСтруктура") Тогда
		
		ДобавитьСтрокуВКорзину(ВыбранныеСтроки, ЗапрашиватьКоличество);
		
	КонецЕсли;
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Функция ДанныеСтрокиСписка(ВыделеннаяСтрока)
	
	Если Элементы.СтраницыСписков.ТекущаяСтраница = Элементы.СтраницаРасширенныйПоискНоменклатура Тогда
		ДанныеСтроки = Элементы.СписокРасширенныйПоискНоменклатура.ДанныеСтроки(ВыделеннаяСтрока);
	Иначе
		ДанныеСтроки = Элементы.СписокСтандартныйПоискНоменклатура.ДанныеСтроки(ВыделеннаяСтрока);
	КонецЕсли;
	
	Возврат ДанныеСтроки;

КонецФункции

&НаКлиенте
Процедура ДобавитьСтрокуВКорзину(ВыделеннаяСтрока, ЗапрашиватьКоличество)
	
	Если ТипЗнч(ВыделеннаяСтрока) = Тип("ДанныеФормыСтруктура") Тогда
		ДанныеСтроки = ВыделеннаяСтрока;
	Иначе
		ДанныеСтроки = ДанныеСтрокиСписка(ВыделеннаяСтрока);
	КонецЕсли;
	
	СтруктураВыбора = СтруктураВыбора();
	ЗаполнитьЗначенияСвойств(СтруктураВыбора, ДанныеСтроки);
	СтруктураВыбора.Номенклатура            = ДанныеСтроки.Ссылка;
	СтруктураВыбора.Количество              = 1;
	СтруктураВыбора.КоличествоУпаковок      = 1;
	СтруктураВыбора.ЗапрашиватьКоличество   = ЗапрашиватьКоличество;
	СтруктураВыбора.ВызватьУправлениеФормой = ЗапрашиватьКоличество;
	
	Если СтруктураВыбора.ИспользуютсяХарактеристики Тогда
		ДополнитьСтруктуруВыбораХарактеристикой(СтруктураВыбора);
	Иначе
		ДобавитьНоменклатуруВКорзинуЗапроситьКоличество(СтруктураВыбора);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьСтрокуВКорзинуЗавершение(Количество, СтруктураВыбора) Экспорт
	
	Если Количество = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтруктураВыбора.Количество = Количество;
	СтруктураВыбора.КоличествоУпаковок = Количество;
	
	СтруктураПоискаВКорзине = Новый Структура;
	СтруктураПоискаВКорзине.Вставить("Номенклатура",               СтруктураВыбора.Номенклатура);
	СтруктураПоискаВКорзине.Вставить("ИспользуютсяХарактеристики", СтруктураВыбора.ИспользуютсяХарактеристики);
	Если СтруктураВыбора.ИспользуютсяХарактеристики Тогда
		СтруктураПоискаВКорзине.Вставить("Характеристика", СтруктураВыбора.Характеристика);
	КонецЕсли;
	
	НайденныеСтроки = Корзина.НайтиСтроки(СтруктураПоискаВКорзине);
	Если НайденныеСтроки.Количество() = 0 Тогда
		СтрокаКорзины = Корзина.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаКорзины, СтруктураВыбора);
	Иначе
		СтрокаКорзины                    = НайденныеСтроки[0];
		СтрокаКорзины.Количество         = СтрокаКорзины.Количество + СтруктураВыбора.Количество;
		СтрокаКорзины.КоличествоУпаковок = СтрокаКорзины.Количество;
		//Если цена изменилась - перезаполняем новым значением
		СтрокаКорзины.Цена               = СтруктураВыбора.Цена;
	КонецЕсли;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ПересчитатьСумму");
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(СтрокаКорзины, СтруктураДействий, Неопределено);
	
	ПоказатьОповещениеПользователя(НСтр("ru = 'Подбор товаров'")
		,
		,
		НСтр("ru = 'Товар "+СтруктураВыбора.Номенклатура+" добавлен в корзину'"));
		
	Если СтруктураВыбора.ВызватьУправлениеФормой Тогда
		УправлениеФормой(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнитьСтруктуруВыбораХарактеристикой(СтруктураВыбора)

	ОписаниеОповещения = Новый ОписаниеОповещения("ДополнитьСтруктуруВыбораХарактеристикойЗавершение", ЭтотОбъект, СтруктураВыбора);
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Номенклатура", СтруктураВыбора.Номенклатура);
	Если ЗначениеЗаполнено(ОтборСклад) Тогда
		МассивСкладов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОтборСклад);
	Иначе
		МассивСкладов = ВсеСклады;
	КонецЕсли;
	СтруктураПараметров.Вставить("ОтборСклад", МассивСкладов);
	
	ОткрытьФорму(
		"Обработка.ПанельИнформацииНоменклатуры.Форма.ФормаВыбораХарактеристики", 
		СтруктураПараметров, 
		ЭтотОбъект,
		,
		,
		,
		ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ДополнитьСтруктуруВыбораХарактеристикойЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ДополнительныеПараметры.Характеристика          = Результат;
	ДополнительныеПараметры.ВызватьУправлениеФормой = Истина;
	ДобавитьНоменклатуруВКорзинуЗапроситьКоличество(ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьНоменклатуруВКорзинуЗапроситьКоличество(СтруктураВыбора)
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ДобавитьСтрокуВКорзинуЗавершение", ЭтотОбъект, СтруктураВыбора);
	
	Если СтруктураВыбора.ЗапрашиватьКоличество Тогда
		ПоказатьВводЧисла(ОписаниеОповещения, СтруктураВыбора.Количество, "Количество товара", 15, 3);
	Иначе
		ВыполнитьОбработкуОповещения(ОписаниеОповещения, СтруктураВыбора.Количество);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция СтруктураВыбора()
	
	Возврат Новый Структура(
		"Номенклатура,
		|ЕдиницаИзмерения,
		|Цена,
		|Количество,
		|КоличествоУпаковок,
		|ИспользуютсяХарактеристики,
		|Характеристика,
		|ЗапрашиватьКоличество,
		|ВызватьУправлениеФормой");
		
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

&НаКлиенте
Процедура СоздатьДокумент(ИмяДокумента)
	
	Если ИмяДокумента = "ЧекККМ" Тогда
		Документ = "Документ.ЧекККМ.Форма.ФормаДокументаРМК";
	Иначе
		Документ = СтрШаблон("Документ.%1.ФормаОбъекта", ИмяДокумента);
	КонецЕсли;
	ПараметрыФормы = ПараметрыСозданияДокумента();
	Корзина.Очистить();
	УправлениеФормой(ЭтаФорма);
	ОписаниеОповещения = Новый ОписаниеОповещения("СоздатьДокументЗавершение", ЭтотОбъект);
	ОткрытьФорму(Документ, ПараметрыФормы,,Новый УникальныйИдентификатор,,,ОписаниеОповещения);

КонецПроцедуры

&НаКлиенте
Процедура СоздатьДокументЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Элементы.СписокРасширенныйПоискНоменклатура.Обновить();
	Элементы.СписокСтандартныйПоискНоменклатура.Обновить();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	
	Если Форма.Корзина.Количество() = 0 Тогда
		Элементы.ГруппаСтраницыКартинки.ТекущаяСтраница = Элементы.ГруппаКорзинаПустая;
	Иначе
		Элементы.ГруппаСтраницыКартинки.ТекущаяСтраница = Элементы.ГруппаКорзинаПолная;
	КонецЕсли;
	
	Элементы.ЦеныДиапазон.Доступность = ЗначениеЗаполнено(Форма.ОтборВидЦен);
	
	Если Форма.ДоступныЦены Тогда
		Элементы.СписокРасширенныйПоискНоменклатураЦена.Видимость = ЗначениеЗаполнено(Форма.ОтборВидЦен);
		Элементы.СписокСтандартныйПоискНоменклатураЦена.Видимость = ЗначениеЗаполнено(Форма.ОтборВидЦен);
	КонецЕсли;
	
	Элементы.ИнформацияПоСкладам.Видимость = Форма.ПоказыватьИнформациюПоСкладам;
	
	ОбновитьНадписьПодобраноТоваров(Форма);
	
КонецПроцедуры

//Обновляет итоги подобранных товаров в форме Корзина справочника Номенклатура
&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьНадписьПодобраноТоваров(Форма)
	
	КоличествоТоваров = Форма.Корзина.Итог("Количество");
	СуммаТоваров      = Форма.Корзина.Итог("Сумма");
	
	Если Форма.Корзина.Количество()=0 Тогда
		Форма.НадписьПодобраноТоваров = НСтр("ru = 'перетащите товары в корзину'");
	ИначеЕсли ЗначениеЗаполнено(Форма.ОтборВидЦен) Тогда
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

#КонецОбласти

#Область Отборы

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

&НаСервере
Процедура УправлениеСписком()
	
	Если ЗначениеЗаполнено(ОтборСклад) Тогда
		МассивСкладов = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ОтборСклад);
	Иначе
		МассивСкладов = ВсеСклады.ВыгрузитьЗначения();
	КонецЕсли;
	СписокНоменклатура.Параметры.УстановитьЗначениеПараметра("ОтборСклад", МассивСкладов);
	СписокНоменклатура.Параметры.УстановитьЗначениеПараметра("ВидЦены",    ОтборВидЦен);
	УстановитьЗначениеПараметраПоказыватьТолькоОстаткиСпискаНоменклатуры(ЭтаФорма);
	
	ОтборыСписковКлиентСервер.ИзменитьЭлементОтбораСписка(
		СписокНоменклатура,
		"Цена",
		ЦенаОт,
		(ЦенаОт <> 0) И ЗначениеЗаполнено(ОтборВидЦен),
		ВидСравненияКомпоновкиДанных.БольшеИлиРавно);
	
	ОтборыСписковКлиентСервер.ИзменитьЭлементОтбораСписка(
		СписокНоменклатура,
		"Цена2",
		ЦенаДо,
		(ЦенаДо <> 0) И ЗначениеЗаполнено(ОтборВидЦен),
		ВидСравненияКомпоновкиДанных.МеньшеИлиРавно);
		
	Элементы.СписокРасширенныйПоискНоменклатура.Обновить();
	Элементы.СписокСтандартныйПоискНоменклатура.Обновить();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьЗначениеПараметраПоказыватьТолькоОстаткиСпискаНоменклатуры(Форма)
	
	ИспользованиеОтбора = (Форма.ОтборОстатки <> 0);
	ИспользуемыйВидСравнения = ?(
		Форма.ОтборОстатки = 1,
		ВидСравненияКомпоновкиДанных.Больше,
		ВидСравненияКомпоновкиДанных.МеньшеИлиРавно);
	
	ОтборыСписковКлиентСервер.ИзменитьЭлементОтбораСписка(
		Форма.СписокНоменклатура,
		"ВНаличии",
		0,
		ИспользованиеОтбора,
		ИспользуемыйВидСравнения);
	
КонецПроцедуры

#КонецОбласти

#Область ИнформацияПоСкладам

&НаКлиенте
Процедура ВывестиИнформациюПоСкладам()
	
	Если НЕ ПоказыватьИнформациюПоСкладам Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные = ТекущиеДанныеСписка();
	
	Если ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ЗаполнитьОстаткиПоСкладам(ТекущиеДанные.Ссылка);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьОстаткиПоСкладам(Номенклатура)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	МассивСкладов = ВсеСклады.ВыгрузитьЗначения();
	
	Если ЗначениеЗаполнено(ОтборСклад) Тогда
		Склад = ОтборСклад;
	Иначе
		Склад = МассивСкладов;
	КонецЕсли;
	Запрос.УстановитьПараметр("Склад",     Склад);
	Запрос.УстановитьПараметр("ВсеСклады", МассивСкладов);
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ПРЕДСТАВЛЕНИЕ(ТоварыНаСкладахОстатки.Склад) КАК Склад,
	|	ТоварыНаСкладахОстатки.ВНаличииОстаток КАК ВНаличии,
	|	ТоварыНаСкладахОстатки.ВНаличииОстаток - ТоварыНаСкладахОстатки.КОтгрузкеОстаток КАК СвободныйОстаток,
	|	ЛОЖЬ КАК ЭтоИтог
	|ПОМЕСТИТЬ ОстаткиПоСкладам
	|ИЗ
	|	РегистрНакопления.ТоварыНаСкладах.Остатки(
	|			,
	|			Номенклатура = &Номенклатура
	|				И Склад В ИЕРАРХИИ (&Склад)) КАК ТоварыНаСкладахОстатки
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	""Итого по складам"",
	|	ТоварыНаСкладахОстатки.ВНаличииОстаток,
	|	ТоварыНаСкладахОстатки.ВНаличииОстаток - ТоварыНаСкладахОстатки.КОтгрузкеОстаток,
	|	ИСТИНА
	|ИЗ
	|	РегистрНакопления.ТоварыНаСкладах.Остатки(
	|			,
	|			Склад В ИЕРАРХИИ (&ВсеСклады)
	|				И Номенклатура = &Номенклатура) КАК ТоварыНаСкладахОстатки
	|ГДЕ
	|	ТоварыНаСкладахОстатки.ВНаличииОстаток <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОстаткиПоСкладам.Склад,
	|	ОстаткиПоСкладам.ВНаличии,
	|	ОстаткиПоСкладам.СвободныйОстаток,
	|	ОстаткиПоСкладам.ЭтоИтог КАК ЭтоИтог
	|ИЗ
	|	ОстаткиПоСкладам КАК ОстаткиПоСкладам";
	ИнформацияПоСкладам.Загрузить(Запрос.Выполнить().Выгрузить());
	ИнформацияПоСкладам.Сортировать("ЭтоИтог, Склад", Новый СравнениеЗначений);
	
КонецПроцедуры

&НаСервере
Процедура СортироватьСкладыНаСервере();
	
	ИнформацияПоСкладам.Сортировать("ЭтоИтог", Новый СравнениеЗначений);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти