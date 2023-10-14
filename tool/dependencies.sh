#!/bin/bash

check_dependencies() {
    local to_install=()

    for dep in "$@"; do
        if ! command -v "$dep" &>/dev/null; then
            to_install+=("$dep")
        fi
    done

    if (( ${#to_install[@]} > 0 )); then
        echo "Установка отсутствующих зависимостей: ${to_install[*]}"
        sudo apt-get update
        for dep in "${to_install[@]}"; do
            sudo apt-get install -y "$dep"
        done
    else
        echo "Все зависимости установлены."
    fi
}
