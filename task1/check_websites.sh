#!/bin/bash

# Масив із URL вебсайтів
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Ім'я файлу логів
log_file="website_status.log"

# Очистити (або створити) файл логів
> "$log_file"

echo "Перевірка доступності вебсайтів..."

# Перевірка кожного сайту
for site in "${websites[@]}"; do
    # Виконання curl для перевірки статусу (слідкуємо за переадресаціями)
    status_code=$(curl -o /dev/null -s -w "%{http_code}" -L "$site")
    
    # Перевірка статусу
    if [ "$status_code" -eq 200 ]; then
        echo "$site is UP" | tee -a "$log_file"
    else
        echo "$site is DOWN (HTTP $status_code)" | tee -a "$log_file"
    fi
done

echo "Результати записані у файл $log_file"
