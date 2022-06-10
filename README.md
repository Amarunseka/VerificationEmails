# VerificationEmails
## В данном приложении реализован функционал проверки email адреса на валидность и существование.
### Приложение состоит из одного экрана с textField'ом и кнопкой запуска проверки
При вводе email’а локально проверяется его валидность на отсутствие запрещенных символов и  наличие необходимых в адресе.

[![01_onlyName](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/01_onlyName.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/01_onlyName.png)
[![05_wrongCharacter](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/05_wrongCharacter.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/05_wrongCharacter.png)

После ввода символа «@» на выбор предлагаются некоторые домены.

[![02_nameAndDog](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/02_nameAndDog.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/02_nameAndDog.png)
[![03_nameDogAndY](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/03_nameDogAndY.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/03_nameDogAndY.png)

Когда email проходит локальную проверку валидности активируется возможность проверки существования email’а удаленно. Путем отправки запроса на сервер. 

[![04_fullEmail](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/04_fullEmail.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/04_fullEmail.png)

Есть несколько вариантов ответов:
- email – существует. (доставлено)
- email’а -  не существует (не доставлено)
- возможна ошибка в написании домена, предлагается возможная замена.
- а также дополнительные события

[![06_emailDeliverible](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/06_emailDeliverible.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/06_emailDeliverible.png)
[![07_emailUndeliverible](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/07_emailUndeliverible.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/07_emailUndeliverible.png)
[![08_sugestToChange](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/small/08_sugestToChange.png)](https://github.com/Amarunseka/VerificationEmails/blob/main/assets/08_sugestToChange.png)

___
### Проект выполнен на архитектуре MVC

### Используемый API - api.kickbox.com
