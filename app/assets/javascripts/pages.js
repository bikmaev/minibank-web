document.addEventListener('DOMContentLoaded', function() {
    var pageUtils = {
        showRegistrationForm: function() {
            console.log('Registration');
            var form = document.getElementById('registrationFormWrapper');
            var message = document.getElementById('registrationMessage');
            if (form) {
                form.style.display = 'block';
            }
            if (message) {
                message.innerHTML = '';
            }
        },

        hideRegistrationForm: function() {
            var form = document.getElementById('registrationFormWrapper');
            var message = document.getElementById('registrationMessage');
            if (form) {
                form.style.display = 'none';
            }
            if (message) {
                message.innerHTML = '';
            }
        },
        showLoginForm: function() {
            console.log('Registration');
            var form = document.getElementById('loginFormWrapper');
            if (form) {
                form.style.display = 'block';
            }
        },

        hideLoginForm: function() {
            var form = document.getElementById('loginFormWrapper');
            if (form) {
                form.style.display = 'none';
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

            var cancelRegButton = document.getElementById('registrationCancelButton');
            if (cancelRegButton) {
                cancelRegButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    pageUtils.hideRegistrationForm();
                });
            }

            var loginButton = document.getElementById('loginButton');
            if (loginButton) {
                loginButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    pageUtils.showLoginForm();
                });
            }

            var cancelLoginButton = document.getElementById('loginCancelButton');
            if (cancelLoginButton) {
                cancelLoginButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    pageUtils.hideLoginForm();
                });
            }

            var formRegistration = document.getElementById('registrationForm');
            if (formRegistration) {
                formRegistration.addEventListener('submit', function(e) {
                    e.preventDefault(); // Предотвращает стандартное действие отправки формы

                    var formData = new FormData(e.target); // Получает данные формы
                    var xhr = new XMLHttpRequest(); // Создает новый XMLHttpRequest

                    xhr.open('POST', e.target.action, true); // Настраивает запрос
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
                    xhr.onload = function() {
                        var message = document.getElementById('registrationMessage');
                        if (xhr.status === 201) {
                            // Обновляет содержимое страницы
                            var response = JSON.parse(xhr.responseText);
                            //alert(response.message);
                            message.innerHTML = response.message;

                        } else {
                            console.log('Request failed.  Returned status of ' + xhr.status);
                            var errorResponse = JSON.parse(xhr.responseText);
                            //alert(errorResponse.error);
                            message.innerHTML = errorResponse.error;
                        }
                    };
                    xhr.send(new URLSearchParams(formData)); // Отправляет данные формы на сервер
                });
            }

            var formLogin = document.getElementById('loginForm');
            if (formLogin) {
                formLogin.addEventListener('submit', function(e) {
                    e.preventDefault(); // Предотвращает стандартное действие отправки формы

                    var formData = new FormData(e.target); // Получает данные формы
                    var xhr = new XMLHttpRequest(); // Создает новый XMLHttpRequest

                    xhr.open('POST', e.target.action, true); // Настраивает запрос
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
                    xhr.onload = function() {
                        var message = document.getElementById('registrationMessage');
                        if (xhr.status === 200) {
                            // Обновляет содержимое страницы
                            var response = JSON.parse(xhr.responseText);
                            //alert(response.message);
                            message.innerHTML = response.message;

                        } else {
                            console.log('Request failed.  Returned status of ' + xhr.status);
                            var errorResponse = JSON.parse(xhr.responseText);
                            //alert(errorResponse.error);
                            message.innerHTML = errorResponse.error;
                        }
                    };
                    xhr.send(new URLSearchParams(formData)); // Отправляет данные формы на сервер
                });
            }
        }
    };

    pageUtils.init();
});