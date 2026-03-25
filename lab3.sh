#!/bin/bash

INITIALS="OS"                  
ROOT_DIR="${INITIALS}_DIR"          
SUBDIRS=("sub1" "sub2" "sub3")      

FIRST_NAME="Oleksandr"
LAST_NAME="Shkvarok"
GROUP="KI-406"
EMAIL="shkvarokoleksandr@gmail.com"
DATE=$(date +"%Y-%m-%d")   

mkdir -p "$ROOT_DIR"
for dir in "${SUBDIRS[@]}"; do
    mkdir -p "$ROOT_DIR/$dir"
    
    echo -e "Група: $GROUP\nДата: $DATE\nEmail: $EMAIL" > "$ROOT_DIR/$dir/${FIRST_NAME}.txt"
    
    echo -e "Група: $GROUP\nДата: $DATE\nEmail: $EMAIL" > "$ROOT_DIR/$dir/${LAST_NAME}.txt"
done

cp "$ROOT_DIR"/*/*.txt "$ROOT_DIR/"
echo "Каталоги та файли створено. Файли скопійовано у $ROOT_DIR."

FILE="$ROOT_DIR/${FIRST_NAME}.txt"
if grep -Eq "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}" "$FILE"; then
    echo "Email знайдено у файлі $FILE"
else
    echo "Email не знайдено у файлі $FILE"
fi

LOG_FILE="Apache_2.4-PHP_5.5-5.6_queriesa.log"

if [ -f "$LOG_FILE" ]; then
    echo ""
    echo "Аналіз логів Apache"
    
    echo "Повідомлення про помилку 404 для ci3:"
    grep "ci3" "$LOG_FILE" | grep " 404 " || echo "404 помилок не знайдено"

    NUM_404=$(grep "ci3" "$LOG_FILE" | grep -c " 404 ")
    echo "Кількість 404: $NUM_404"

    NUM_GECKO=$(awk '/ci3/ && /Gecko/ {count++} END {print count+0}' "$LOG_FILE")
echo "Кількість користувачів, що використовували Gecko: $NUM_GECKO"
else
    echo "Лог-файл $LOG_FILE не знайдено у поточному каталозі."
fi