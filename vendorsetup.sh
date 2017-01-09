for combo in $(curl -s https://raw.githubusercontent.com/Hexa-Project/HEXABOT/cm-14.1/hexabot-supported-device | sed -e 's/#.*$//' | grep cm-14.1 | awk '{printf "hexa_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
