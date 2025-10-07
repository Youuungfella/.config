hyprctl clients -j | jq -r '.[] | "\(.workspace.name) | \(.class) | \(if (.title | length) > 50 then .title[:50] + "..." else .title end)" +
" | \(.address)"' | \
wofi -i --dmenu --prompt="Окна:" --width=1400 --hide-scroll --no-actions | \
awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $4); print $4}' | \
xargs -I {} hyprctl dispatch focuswindow address:{}
