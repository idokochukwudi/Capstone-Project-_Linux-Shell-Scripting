#!/bin/bash

# Function to generate multiplication table using list form for loop
generate_table_list_form() {
    local number=$1
    local start=$2
    local end=$3
    local order=$4

    if [[ $order == "d" ]]; then
        for i in $(seq $end -1 $start); do
            echo "$number x $i = $((number * i))"
        done
    else
        for i in $(seq $start $end); do
            echo "$number x $i = $((number * i))"
        done
    fi
}

# Function to generate multiplication table using C-style for loop
generate_table_c_style() {
    local number=$1
    local start=$2
    local end=$3
    local order=$4

    if [[ $order == "d" ]]; then
        for (( i=$end; i>=$start; i-- )); do
            echo "$number x $i = $((number * i))"
        done
    else
        for (( i=$start; i<=$end; i++ )); do
            echo "$number x $i = $((number * i))"
        done
    fi
}

# Function to prompt the user for input and validate it
prompt_user_input() {
    local prompt=$1
    local var
    while true; do
        read -p "$prompt" var
        if [[ $var =~ ^[0-9]+$ ]]; then
            echo $var
            return
        else
            echo "Invalid input. Please enter a valid number."
        fi
    done
}

# 1. Prompt the user to enter a number for the multiplication table.
while true; do
    number=$(prompt_user_input "Enter the number for the multiplication table: ")

    # 2. Ask if they want a full table or a partial table (p = partial table, f = full table)
    while true; do
        read -p "Do you want a full table (1-10) or a partial table? (f = full, p = partial): " table_choice
        if [[ $table_choice == "f" ]]; then
            start=1
            end=10
            break
        elif [[ $table_choice == "p" ]]; then
    # 3. Validate the range inputs and handle invalid or out-of-bound entries.
            start=$(prompt_user_input "Enter the start number of the range: ")
            end=$(prompt_user_input "Enter the end number of the range: ")
            if (( start > 0 && end > 0 && start <= end )); then
                break
            else
                echo "Invalid range. Please enter valid start and end numbers."
            fi
        else
            echo "Invalid choice. Please enter 'f' for full or 'p' for partial."
        fi
    done

# 4. Ask the user for the order of the table (ascending or descending).
    while true; do
        read -p "Do you want the table in ascending or descending order? (a = ascending, d = descending): " order
        if [[ $order == "a" || $order == "d" ]]; then
            break
        else
            echo "Invalid choice. Please enter 'a' for ascending or 'd' for descending."
        fi
    done

    # 5. Generate and display the multiplication table using both loop styles.
    echo "Multiplication Table using List Form For Loop:"
    generate_table_list_form $number $start $end $order

    echo ""
    echo "Multiplication Table using C-style For Loop:"
    generate_table_c_style $number $start $end $order

    # 6. Ask the user if they want to repeat the program for another number.
    read -p "Do you want to generate another table? (y/n): " repeat
    if [[ $repeat != "y" ]]; then
        break
    fi
done

echo "Goodbye!"
