#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.3.5-alpha
# date: 2024-12-09 22:13:40
replace__0_v0() {
    local source=$1
    local search=$2
    local replace=$3
    __AF_replace0_v0="${source//${search}/${replace}}"
    return 0
}
split__3_v0() {
    local text=$1
    local delimiter=$2
    __AMBER_ARRAY_0=()
    local result=("${__AMBER_ARRAY_0[@]}")
    IFS="${delimiter}" read -rd '' -a result < <(printf %s "$text")
    __AS=$?
    __AF_split3_v0=("${result[@]}")
    return 0
}

input__94_v0() {
    local prompt=$1
    read -p "$prompt"
    __AS=$?
    __AF_input94_v0="$REPLY"
    return 0
}
printf__99_v0() {
    local format=$1
    local args=("${!2}")
    args=("${format}" "${args[@]}")
    __AS=$?
    printf "${args[@]}"
    __AS=$?
}
echo_info__106_v0() {
    local message=$1
    __AMBER_ARRAY_1=("${message}")
    printf__99_v0 "\x1b[1;3;97;44m%s\x1b[0m
" __AMBER_ARRAY_1[@]
    __AF_printf99_v0__147_5="$__AF_printf99_v0"
    echo "$__AF_printf99_v0__147_5" >/dev/null 2>&1
}
error__109_v0() {
    local message=$1
    local exit_code=$2
    __AMBER_ARRAY_2=("${message}")
    printf__99_v0 "\x1b[1;3;97;41m%s\x1b[0m
" __AMBER_ARRAY_2[@]
    __AF_printf99_v0__162_5="$__AF_printf99_v0"
    echo "$__AF_printf99_v0__162_5" >/dev/null 2>&1
    if [ $(echo ${exit_code} '>' 0 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
        exit ${exit_code}
    fi
}
__AMBER_ARRAY_3=("ar" "fr" "sw" "rw")
declare -r __0_language_codes=("${__AMBER_ARRAY_3[@]}")
__AMBER_ARRAY_4=("Arabic" "French" "Swahili" "Kinyarwanda")
declare -r __1_language_names=("${__AMBER_ARRAY_4[@]}")
build_translation_url__115_v0() {
    local message=$1
    local target_language=$2
    replace__0_v0 "${message}" " " "%20"
    __AF_replace0_v0__8_15="${__AF_replace0_v0}"
    message="${__AF_replace0_v0__8_15}"
    __AF_build_translation_url115_v0="https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=${target_language}&dt=t&q=${message}&ie=UTF-8&oe=UTF-8"
    return 0
}
translate_message__116_v0() {
    local message=$1
    local target_language=$2
    build_translation_url__115_v0 "${message}" "${target_language}"
    __AF_build_translation_url115_v0__13_17="${__AF_build_translation_url115_v0}"
    declare -r url="${__AF_build_translation_url115_v0__13_17}"
    __AMBER_VAL_5=$(curl -s ${url} | jq -r '.[0][0][0]')
    __AS=$?
    if [ $__AS != 0 ]; then
        error__109_v0 "Failed to translate to ${target_language}." 1
        __AF_error109_v0__16_9="$__AF_error109_v0"
        echo "$__AF_error109_v0__16_9" >/dev/null 2>&1
    fi
    declare -r translated_message="${__AMBER_VAL_5}"
    replace__0_v0 "${translated_message}" "
" ""
    __AF_replace0_v0__19_12="${__AF_replace0_v0}"
    __AF_translate_message116_v0="${__AF_replace0_v0__19_12}"
    return 0
}
input__94_v0 "enter the key and message to translate in the format 'key=message': "
__AF_input94_v0__22_21="${__AF_input94_v0}"
__2_input_message="${__AF_input94_v0__22_21}"
split__3_v0 "${__2_input_message}" "="
__AF_split3_v0__24_21=("${__AF_split3_v0[@]}")
__3_message_array=("${__AF_split3_v0__24_21[@]}")
if [ $(echo "${#__3_message_array[@]}" '!=' 2 | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//') != 0 ]; then
    error__109_v0 "Invalid input format. The message should be in the format 'key=message'." 1
    __AF_error109_v0__27_5="$__AF_error109_v0"
    echo "$__AF_error109_v0__27_5" >/dev/null 2>&1
fi
index=0
for language_code in "${__0_language_codes[@]}"; do
    original_message="${__3_message_array[1]}"
    translate_message__116_v0 "${original_message}" "${language_code}"
    __AF_translate_message116_v0__32_30="${__AF_translate_message116_v0}"
    translated_message="${__AF_translate_message116_v0__32_30}"
    echo_info__106_v0 "${__1_language_names[${index}]}"
    __AF_echo_info106_v0__34_5="$__AF_echo_info106_v0"
    echo "$__AF_echo_info106_v0__34_5" >/dev/null 2>&1
    echo "${__3_message_array[0]}=${translated_message}
"
    ((index++)) || true
done
