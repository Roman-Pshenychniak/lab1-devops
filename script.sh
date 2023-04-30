#!/bin/bash

# URL для перевірки
url="http://localhost/"

# Коди стану HTTP, які ми хочемо вважати "успішними"
http_success_codes=("2%3" "3%3")

# Функція для запису повідомлення про помилку в лог файл
function log_error {
  echo "$(date): HTTP status code is not successful: $status_code" >> /path/to/log.txt
}

# Функція для відправки повідомлення про помилку на пошту
#function send_email {
#  echo "Subject: Server Error\n\nHTTP status code is not successful: $status_code" | ssmtp cagalp89@gmail.com
#}

# Отримати код стану HTTP від сервера
status_code=$(curl -s -o /dev/null -w "%{http_code}" $url)

# Перевірка, чи є код стану HTTP успішним
for code in ${http_success_codes[@]}; do
  if [[ $status_code == $code ]]; then
    exit 0
  fi
done

# Якщо код стану HTTP не є успішним, записати помилку в лог файл або надіслати повідомлення на електронну пошту
if [[ -f /path/to/log.txt ]]; then
  log_error
#else
  #send_email
fi
