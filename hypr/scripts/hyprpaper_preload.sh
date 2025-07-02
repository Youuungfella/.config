#!/bin/bash
WALLPAPER_DIR="$HOME/Images/wallpapers"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Очищаем конфиг
> "$CONFIG_FILE"

# Preload всех PNG-файлов
find "$WALLPAPER_DIR" -type f -name "*.png" | while read -r img; do
    echo "preload = $img" >> "$CONFIG_FILE"
done

# Выбираем случайную картинку
RANDOM_WALL=$(find "$WALLPAPER_DIR" -type f -name "*.png" | shuf -n 1)
echo "wallpaper = ,$RANDOM_WALL" >> "$CONFIG_FILE"

# Перезапускаем hyprpaper
killall hyprpaper
hyprpaper &
