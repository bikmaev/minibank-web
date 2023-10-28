document.addEventListener('DOMContentLoaded', function() {
    var pageUtils = {
        showRegistrationForm: function() {
            console.log('Registration');
            var form = document.getElementById('registrationFormWrapper');
            if (form) {
                form.style.display = 'block';
            }
        },

        init: function() {
            var registerButton = document.getElementById('registerButton');
            if (registerButton) {
                registerButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    pageUtils.showRegistrationForm();
                });
            }

            var form = document.getElementById('registrationForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault(); // Предотвращает стандартное действие отправки формы

                    var formData = new FormData(form); // Получает данные формы
                    var xhr = new XMLHttpRequest(); // Создает новый XMLHttpRequest

                    xhr.open('POST', form.action, true); // Настраивает запрос
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
                    xhr.onload = function() {
                        if (xhr.status === 201) {
                            // Обновляет содержимое страницы
                            // Например, можно показать уведомление о успешной регистрации
                            var response = JSON.parse(xhr.responseText);
                            alert(response.message);
                        } else {
                            console.log('Request failed.  Returned status of ' + xhr.status);
                            var errorResponse = JSON.parse(xhr.responseText);
                            alert(errorResponse.error);
                        }
                    };
                    xhr.send(new URLSearchParams(formData)); // Отправляет данные формы на сервер
                });
            }
        }
    };

    pageUtils.init();
});