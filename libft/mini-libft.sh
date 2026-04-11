#!/bin/bash

GREEN='\033[38;5;84m'
RED='\033[38;5;197m'
BLUE='\033[38;5;45m'
PURPLE='\033[38;5;63m'
PINK='\033[38;5;207m'
BLACK='\033[38;5;0m'
BG_GREEN='\033[48;5;84m'
BG_RED='\033[48;5;197m'
GREY='\033[38;5;8m'
BOLD='\033[1m'
DEFAULT='\033[0m'

LIBFT_DIR="$(pwd)"
OBJS=()
while IFS= read -r obj; do
    OBJS+=("$obj")
done < <(find "$LIBFT_DIR" -maxdepth 1 -name 'ft_*.o' | sort)

if [ ${#OBJS[@]} -eq 0 ]; then
    printf "${RED}No libft object files found.${DEFAULT}\n"
    printf "Compile first: ${GREY}gcc -Wall -Wextra -Werror -c ft_*.c${DEFAULT}\n"
    exit 1
fi

pass=0
fail=0
total_pass=0
total_fail=0
result=""
func_index=0
test_index=0
start_time=$(date +%s)

TMPDIR_TESTS=$(mktemp -d)
trap 'rm -rf "$TMPDIR_TESTS"' EXIT

print_header()
{
    printf "${PINK}"
    printf "\n"
    printf "  ██╗     ██╗██████╗ ███████╗████████╗\n"
    printf "  ██║     ██║██╔══██╗██╔════╝╚══██╔══╝\n"
    printf "  ██║     ██║██████╔╝█████╗     ██║   \n"
    printf "  ██║     ██║██╔══██╗██╔══╝     ██║   \n"
    printf "  ███████╗██║██████╔╝██║        ██║   \n"
    printf "  ╚══════╝╚═╝╚═════╝ ╚═╝        ╚═╝   \n"
    printf "${DEFAULT}"
    printf "${BLUE}  libft tester${DEFAULT} — mini moulinette style\n\n"
}

space() { printf "\n"; }

begin_func()
{
    func_name="$1"
    pass=0
    fail=0
    test_index=0
}

end_func()
{
    total_pass=$((total_pass + pass))
    total_fail=$((total_fail + fail))
    [ $func_index -gt 0 ] && result+=", "
    if [ "$fail" -eq 0 ]; then
        printf "${BG_GREEN}${BLACK}${BOLD} PASS ${DEFAULT}${PURPLE} %s${DEFAULT}\n" "$func_name"
        result+="${GREEN}${func_name}: OK${DEFAULT}"
    else
        printf "${BG_RED}${BOLD} FAIL ${DEFAULT}${PURPLE} %s${DEFAULT}\n" "$func_name"
        result+="${RED}${func_name}: KO${DEFAULT}"
    fi
    space
    func_index=$((func_index + 1))
}

check_int()
{
    local desc="$1"
    local got="$2"
    local expected="$3"
    test_index=$((test_index + 1))
    local idx="[$test_index]"

    if [ "$got" = "$expected" ]; then
        printf "  ${GREEN}✓${DEFAULT} ${GREY}%-4s${DEFAULT} %-50s ${GREEN}%s${DEFAULT}\n" \
            "$idx" "$desc" "$got"
        pass=$((pass + 1))
    else
        printf "  ${RED}✗${DEFAULT} ${GREY}%-4s${DEFAULT} %-50s ${RED}got: %s${DEFAULT} | expected: ${GREEN}%s${DEFAULT}\n" \
            "$idx" "$desc" "$got" "$expected"
        fail=$((fail + 1))
    fi
}

check_str()
{
    local desc="$1"
    local got="$2"
    local expected="$3"
    test_index=$((test_index + 1))
    local idx="[$test_index]"

    if [ "$got" = "$expected" ]; then
        printf "  ${GREEN}✓${DEFAULT} ${GREY}%-4s${DEFAULT} %-50s ${GREEN}\"%s\"${DEFAULT}\n" \
            "$idx" "$desc" "$got"
        pass=$((pass + 1))
    else
        printf "  ${RED}✗${DEFAULT} ${GREY}%-4s${DEFAULT} %-50s ${RED}got: \"%s\"${DEFAULT} | expected: ${GREEN}\"%s\"${DEFAULT}\n" \
            "$idx" "$desc" "$got" "$expected"
        fail=$((fail + 1))
    fi
}

compile_test()
{
    local src="$1"
    local out="$2"

    gcc -Wall -Wextra -Werror -g -o "$out" "$src" "${OBJS[@]}"
    if [ $? -ne 0 ]; then
        printf "\n${RED}Compilation failed for:${DEFAULT} %s\n" "$out"
        exit 1
    fi

    if [ ! -x "$out" ]; then
        printf "\n${RED}Executable not created:${DEFAULT} %s\n" "$out"
        exit 1
    fi
}

run_test()
{
    local exe="$1"
    shift

    if [ ! -x "$exe" ]; then
        printf "\n${RED}Missing executable:${DEFAULT} %s\n" "$exe"
        exit 1
    fi

    local output
    output=$("$exe" "$@")
    local status=$?

    if [ $status -ge 128 ]; then
        printf "Signal %d" "$((status - 128))"
        return
    fi

    if [ $status -ne 0 ]; then
        printf "Error (code $status)"
        return
    fi

    printf "%s" "$output"
}

get_val()
{
    printf '%s\n' "$2" | grep "^$1:" | cut -d: -f2-
}

print_header
printf "${GREEN} Running tests for libft...\n${DEFAULT}"
space

cat > "$TMPDIR_TESTS/t_isalpha.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_isalpha(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", !!ft_isalpha(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_isalpha.c" "$TMPDIR_TESTS/t_isalpha"
begin_func "ft_isalpha"
check_int "ft_isalpha(97)   lowercase a"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 97)")"   "1"
check_int "ft_isalpha(122)  lowercase z boundary"   "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 122)")"  "1"
check_int "ft_isalpha(65)   uppercase A"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 65)")"   "1"
check_int "ft_isalpha(90)   uppercase Z boundary"   "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 90)")"   "1"
check_int "ft_isalpha(48)   digit 0"                "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 48)")"   "0"
check_int "ft_isalpha(32)   space"                  "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 32)")"   "0"
check_int "ft_isalpha(0)    nul byte"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 0)")"    "0"
check_int "ft_isalpha(123)  just after z"           "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 123)")"  "0"
check_int "ft_isalpha(64)   just before A"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 64)")"   "0"
check_int "ft_isalpha(91)   just after Z"           "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 91)")"   "0"
check_int "ft_isalpha(96)   just before a"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalpha" 96)")"   "0"
end_func

cat > "$TMPDIR_TESTS/t_isdigit.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_isdigit(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", !!ft_isdigit(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_isdigit.c" "$TMPDIR_TESTS/t_isdigit"
begin_func "ft_isdigit"
check_int "ft_isdigit(48)   digit 0 min"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 48)")"   "1"
check_int "ft_isdigit(57)   digit 9 max"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 57)")"   "1"
check_int "ft_isdigit(53)   digit 5 middle"         "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 53)")"   "1"
check_int "ft_isdigit(47)   just before 0"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 47)")"   "0"
check_int "ft_isdigit(58)   just after 9"           "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 58)")"   "0"
check_int "ft_isdigit(97)   letter a"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 97)")"   "0"
check_int "ft_isdigit(0)    nul byte"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 0)")"    "0"
check_int "ft_isdigit(32)   space"                  "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isdigit" 32)")"   "0"
end_func

cat > "$TMPDIR_TESTS/t_isalnum.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_isalnum(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", !!ft_isalnum(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_isalnum.c" "$TMPDIR_TESTS/t_isalnum"
begin_func "ft_isalnum"
check_int "ft_isalnum(97)   letter a"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 97)")"   "1"
check_int "ft_isalnum(90)   letter Z"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 90)")"   "1"
check_int "ft_isalnum(48)   digit 0"                "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 48)")"   "1"
check_int "ft_isalnum(57)   digit 9"                "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 57)")"   "1"
check_int "ft_isalnum(64)   @ special"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 64)")"   "0"
check_int "ft_isalnum(91)   just after Z"           "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 91)")"   "0"
check_int "ft_isalnum(47)   just before 0"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 47)")"   "0"
check_int "ft_isalnum(0)    nul byte"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isalnum" 0)")"    "0"
end_func

cat > "$TMPDIR_TESTS/t_isascii.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_isascii(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", !!ft_isascii(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_isascii.c" "$TMPDIR_TESTS/t_isascii"
begin_func "ft_isascii"
check_int "ft_isascii(0)    min nul"                "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" 0)")"    "1"
check_int "ft_isascii(127)  max"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" 127)")"  "1"
check_int "ft_isascii(65)   A"                      "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" 65)")"   "1"
check_int "ft_isascii(128)  just above max"         "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" 128)")"  "0"
check_int "ft_isascii(255)  far above"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" 255)")"  "0"
check_int "ft_isascii(-1)   negative"               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isascii" -1)")"   "0"
end_func

cat > "$TMPDIR_TESTS/t_isprint.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_isprint(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", !!ft_isprint(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_isprint.c" "$TMPDIR_TESTS/t_isprint"
begin_func "ft_isprint"
check_int "ft_isprint(32)   space min printable"    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 32)")"   "1"
check_int "ft_isprint(126)  tilde max printable"    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 126)")"  "1"
check_int "ft_isprint(65)   A"                      "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 65)")"   "1"
check_int "ft_isprint(31)   just below min"         "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 31)")"   "0"
check_int "ft_isprint(127)  DEL"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 127)")"  "0"
check_int "ft_isprint(0)    nul"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 0)")"    "0"
check_int "ft_isprint(9)    tab"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_isprint" 9)")"    "0"
end_func

cat > "$TMPDIR_TESTS/t_toupper.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_toupper(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", ft_toupper(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_toupper.c" "$TMPDIR_TESTS/t_toupper"
begin_func "ft_toupper"
check_int "ft_toupper(97)   a -> A"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 97)")"   "65"
check_int "ft_toupper(122)  z -> Z"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 122)")"  "90"
check_int "ft_toupper(109)  m -> M"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 109)")"  "77"
check_int "ft_toupper(65)   A already upper"        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 65)")"   "65"
check_int "ft_toupper(90)   Z already upper"        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 90)")"   "90"
check_int "ft_toupper(49)   digit 1 unchanged"      "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 49)")"   "49"
check_int "ft_toupper(123)  { just after z"         "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 123)")"  "123"
check_int "ft_toupper(96)   backtick just before a" "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 96)")"   "96"
check_int "ft_toupper(0)    nul unchanged"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_toupper" 0)")"    "0"
end_func

cat > "$TMPDIR_TESTS/t_tolower.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
int ft_tolower(int c);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", ft_tolower(atoi(argv[1])));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_tolower.c" "$TMPDIR_TESTS/t_tolower"
begin_func "ft_tolower"
check_int "ft_tolower(65)   A -> a"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 65)")"   "97"
check_int "ft_tolower(90)   Z -> z"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 90)")"   "122"
check_int "ft_tolower(77)   M -> m"                 "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 77)")"   "109"
check_int "ft_tolower(97)   a already lower"        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 97)")"   "97"
check_int "ft_tolower(122)  z already lower"        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 122)")"  "122"
check_int "ft_tolower(49)   digit 1 unchanged"      "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 49)")"   "49"
check_int "ft_tolower(91)   [ just after Z"         "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 91)")"   "91"
check_int "ft_tolower(64)   @ just before A"        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 64)")"   "64"
check_int "ft_tolower(0)    nul unchanged"          "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_tolower" 0)")"    "0"
end_func

cat > "$TMPDIR_TESTS/t_atoi.c" << 'EOF'
#include <stdio.h>
int ft_atoi(const char *str);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%d\n", ft_atoi(argv[1]));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_atoi.c" "$TMPDIR_TESTS/t_atoi"
begin_func "ft_atoi"
check_int "ft_atoi 42"                              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "42")")"              "42"
check_int "ft_atoi -42"                             "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "-42")")"             "-42"
check_int "ft_atoi    +84 with spaces"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "   +84")")"          "84"
check_int "ft_atoi 0"                               "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "0")")"               "0"
check_int "ft_atoi 0042 leading zeros"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "0042")")"            "42"
check_int "ft_atoi 2147483647 INT_MAX"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "2147483647")")"      "2147483647"
check_int "ft_atoi -2147483648 INT_MIN"             "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "-2147483648")")"     "-2147483648"
check_int "ft_atoi 42abc stops at alpha"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "42abc")")"           "42"
check_int "ft_atoi abc no digit"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "abc")")"             "0"
check_int "ft_atoi +-12 double sign"                "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "+-12")")"            "0"
check_int "ft_atoi + sign only"                     "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "+")")"               "0"
check_int "ft_atoi - sign only"                     "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "-")")"               "0"
check_int "ft_atoi   -0 negative zero"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "  -0")")"            "0"
check_int "ft_atoi tab+newline+space+42"            "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_atoi" "$(printf '\t\n 42')")")" "42"
end_func

cat > "$TMPDIR_TESTS/t_strlen.c" << 'EOF'
#include <stdio.h>
#include <stddef.h>
size_t ft_strlen(const char *s);
int main(int argc, char **argv)
{
    if (argc < 2) return 1;
    printf("T1:%zu\n", ft_strlen(argv[1]));
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strlen.c" "$TMPDIR_TESTS/t_strlen"
begin_func "ft_strlen"
check_int "ft_strlen Hello == 5"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" "Hello")")"         "5"
check_int "ft_strlen empty == 0"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" "")")"              "0"
check_int "ft_strlen 0123456789 == 10"              "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" "0123456789")")"    "10"
check_int "ft_strlen space == 1"                    "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" " ")")"             "1"
check_int "ft_strlen a == 1"                        "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" "a")")"             "1"
check_int "ft_strlen Hello World == 11"             "$(get_val T1 "$(run_test "$TMPDIR_TESTS/t_strlen" "Hello World")")"   "11"
end_func



cat > "$TMPDIR_TESTS/t_memset.c" << 'EOF'
#include <stdio.h>
#include <string.h>
void *ft_memset(void *b, int c, size_t len);
int main(void)
{
    char buf[30];
    memset(buf, 0, sizeof(buf));
    ft_memset(buf, 'X', 5); buf[5] = '\0';
    printf("T1:%s\n", buf);
    memset(buf, 'A', 10); buf[10] = '\0';
    ft_memset(buf, 'B', 3);
    printf("T2:%c%c%c%c\n", buf[0], buf[1], buf[2], buf[3]);
    memset(buf, 'Z', 10);
    ft_memset(buf, 0, 5);
    printf("T3:%d\n", (int)buf[0]);
    memset(buf, 'A', 5); buf[5] = '\0';
    ft_memset(buf, 'X', 0);
    printf("T4:%s\n", buf);
    void *r = ft_memset(buf, 'C', 3);
    printf("T5:%d\n", r == (void *)buf);
    ft_memset(buf, 200, 1);
    printf("T6:%d\n", (unsigned char)buf[0]);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_memset.c" "$TMPDIR_TESTS/t_memset"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_memset")"
begin_func "ft_memset"
check_str "ft_memset X 5 basic fill"                "$(get_val T1 "$OUTPUT")" "XXXXX"
check_str "ft_memset B 3 partial rest=A"            "$(get_val T2 "$OUTPUT")" "BBBA"
check_int "ft_memset 0 5 zero fill buf[0]==0"       "$(get_val T3 "$OUTPUT")" "0"
check_str "ft_memset n=0 no change"                 "$(get_val T4 "$OUTPUT")" "AAAAA"
check_int "ft_memset returns dst"                   "$(get_val T5 "$OUTPUT")" "1"
check_int "ft_memset value 200 stored as byte"      "$(get_val T6 "$OUTPUT")" "200"
end_func

cat > "$TMPDIR_TESTS/t_bzero.c" << 'EOF'
#include <stdio.h>
#include <string.h>
void ft_bzero(void *s, size_t n);
int main(void)
{
    char buf[20];
    memset(buf, 'A', 20);
    ft_bzero(buf, 5);
    printf("T1:%d\n", (int)buf[0]);
    printf("T2:%d\n", (int)buf[4]);
    printf("T3:%d\n", (int)buf[5]);
    memset(buf, 'Z', 5); buf[5] = '\0';
    ft_bzero(buf, 0);
    printf("T4:%s\n", buf);
    memset(buf, 'A', 10);
    ft_bzero(buf, 10);
    printf("T5:%d\n", (int)buf[9]);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_bzero.c" "$TMPDIR_TESTS/t_bzero"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_bzero")"
begin_func "ft_bzero"
check_int "ft_bzero 5 buf[0]==0"                    "$(get_val T1 "$OUTPUT")" "0"
check_int "ft_bzero 5 buf[4]==0"                    "$(get_val T2 "$OUTPUT")" "0"
check_int "ft_bzero 5 buf[5]==65 untouched"         "$(get_val T3 "$OUTPUT")" "65"
check_str "ft_bzero n=0 no change"                  "$(get_val T4 "$OUTPUT")" "ZZZZZ"
check_int "ft_bzero 10 buf[9]==0"                   "$(get_val T5 "$OUTPUT")" "0"
end_func

cat > "$TMPDIR_TESTS/t_memcpy.c" << 'EOF'
#include <stdio.h>
#include <string.h>
void *ft_memcpy(void *dst, const void *src, size_t n);
int main(void)
{
    char buf[30];
    ft_memcpy(buf, "Hello", 6); printf("T1:%s\n", buf);
    ft_memcpy(buf, "ABCDE", 3); buf[3] = '\0'; printf("T2:%s\n", buf);
    memset(buf, 'Z', 5); buf[5] = '\0';
    ft_memcpy(buf, "A", 1); printf("T3:%s\n", buf);
    void *r = ft_memcpy(buf, "Hi", 3);
    printf("T4:%d\n", r == (void *)buf);
    char src[5] = {'A', '\0', 'B', '\0', 'C'};
    ft_memcpy(buf, src, 5);
    printf("T5:%d %d %d %d %d\n", buf[0], buf[1], buf[2], buf[3], buf[4]);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_memcpy.c" "$TMPDIR_TESTS/t_memcpy"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_memcpy")"
begin_func "ft_memcpy"
check_str "ft_memcpy Hello n=6"                     "$(get_val T1 "$OUTPUT")" "Hello"
check_str "ft_memcpy ABCDE n=3 partial"             "$(get_val T2 "$OUTPUT")" "ABC"
check_str "ft_memcpy A n=1"                         "$(get_val T3 "$OUTPUT")" "AZZZZ"
check_int "ft_memcpy returns dst"                   "$(get_val T4 "$OUTPUT")" "1"
check_str "ft_memcpy with nul bytes inside"         "$(get_val T5 "$OUTPUT")" "65 0 66 0 67"
end_func

cat > "$TMPDIR_TESTS/t_memmove.c" << 'EOF'
#include <stdio.h>
#include <string.h>
void *ft_memmove(void *dst, const void *src, size_t n);
int main(void)
{
    char buf[30];
    strcpy(buf, "Hello");
    ft_memmove(buf + 2, buf, 3); buf[5] = '\0';
    printf("T1:%s\n", buf);
    strcpy(buf, "Hello");
    ft_memmove(buf, buf + 1, 4); buf[4] = '\0';
    printf("T2:%s\n", buf);
    strcpy(buf, "Hello");
    ft_memmove(buf, buf, 5);
    printf("T3:%s\n", buf);
    strcpy(buf, "Hello");
    ft_memmove(buf + 1, buf, 0);
    printf("T4:%s\n", buf);
    strcpy(buf, "Hello");
    void *r = ft_memmove(buf, buf + 1, 4); buf[4] = '\0';
    printf("T5:%d\n", r == (void *)buf);
    strcpy(buf, "ABCDEFGH");
    ft_memmove(buf + 1, buf, 7); buf[8] = '\0';
    printf("T6:%s\n", buf);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_memmove.c" "$TMPDIR_TESTS/t_memmove"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_memmove")"
begin_func "ft_memmove"
check_str "ft_memmove buf+2 buf 3 overlap dst>src"  "$(get_val T1 "$OUTPUT")" "HeHel"
check_str "ft_memmove buf buf+1 4 overlap dst<src"  "$(get_val T2 "$OUTPUT")" "ello"
check_str "ft_memmove buf buf 5 dst==src"           "$(get_val T3 "$OUTPUT")" "Hello"
check_str "ft_memmove n=0 no change"                "$(get_val T4 "$OUTPUT")" "Hello"
check_int "ft_memmove returns dst"                  "$(get_val T5 "$OUTPUT")" "1"
check_str "ft_memmove shift right ABCDEFGH"         "$(get_val T6 "$OUTPUT")" "AABCDEFG"
end_func

cat > "$TMPDIR_TESTS/t_memchr.c" << 'EOF'
#include <stdio.h>
void *ft_memchr(const void *s, int c, size_t n);
int main(void)
{
    void *r;
    r = ft_memchr("Hello", 'l', 5); printf("T1:%s\n", r ? (char *)r : "NULL");
    r = ft_memchr("Hello", 'z', 5); printf("T2:%s\n", r ? (char *)r : "NULL");
    r = ft_memchr("Hello", 'l', 2); printf("T3:%s\n", r ? (char *)r : "NULL");
    r = ft_memchr("Hi", '\0', 3);   printf("T4:%s\n", r ? "found" : "NULL");
    r = ft_memchr("Hello", 'H', 0); printf("T5:%s\n", r ? (char *)r : "NULL");
    r = ft_memchr("Hello", 'H', 5); printf("T6:%s\n", r ? (char *)r : "NULL");
    r = ft_memchr("Hello", 'o', 5); printf("T7:%s\n", r ? (char *)r : "NULL");
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_memchr.c" "$TMPDIR_TESTS/t_memchr"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_memchr")"
begin_func "ft_memchr"
check_str "ft_memchr Hello l n=5 found"             "$(get_val T1 "$OUTPUT")" "llo"
check_str "ft_memchr Hello z n=5 not found"         "$(get_val T2 "$OUTPUT")" "NULL"
check_str "ft_memchr Hello l n=2 beyond n"          "$(get_val T3 "$OUTPUT")" "NULL"
check_str "ft_memchr nul byte within n"             "$(get_val T4 "$OUTPUT")" "found"
check_str "ft_memchr n=0 always NULL"               "$(get_val T5 "$OUTPUT")" "NULL"
check_str "ft_memchr Hello H n=5 first char"        "$(get_val T6 "$OUTPUT")" "Hello"
check_str "ft_memchr Hello o n=5 last char"         "$(get_val T7 "$OUTPUT")" "o"
end_func

cat > "$TMPDIR_TESTS/t_memcmp.c" << 'EOF'
#include <stdio.h>
int ft_memcmp(const void *s1, const void *s2, size_t n);
int main(void)
{
    printf("T1:%d\n", ft_memcmp("abc", "abc", 3) == 0);
    printf("T2:%d\n", ft_memcmp("abc", "abd", 3) < 0);
    printf("T3:%d\n", ft_memcmp("abd", "abc", 3) > 0);
    printf("T4:%d\n", ft_memcmp("abc", "xyz", 0) == 0);
    printf("T5:%d\n", ft_memcmp("\x80", "\x01", 1) > 0);
    printf("T6:%d\n", ft_memcmp("abcXXX", "abcYYY", 3) == 0);
    printf("T7:%d\n", ft_memcmp("aXX", "aYY", 3) < 0);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_memcmp.c" "$TMPDIR_TESTS/t_memcmp"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_memcmp")"
begin_func "ft_memcmp"
check_int "ft_memcmp abc abc 3 equal"               "$(get_val T1 "$OUTPUT")" "1"
check_int "ft_memcmp abc abd 3 s1 < s2"             "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_memcmp abd abc 3 s1 > s2"             "$(get_val T3 "$OUTPUT")" "1"
check_int "ft_memcmp n=0 always equal"              "$(get_val T4 "$OUTPUT")" "1"
check_int "ft_memcmp x80 x01 unsigned comparison"   "$(get_val T5 "$OUTPUT")" "1"
check_int "ft_memcmp abcXXX abcYYY n=3 equal"       "$(get_val T6 "$OUTPUT")" "1"
check_int "ft_memcmp aXX aYY n=3 differ at 1"       "$(get_val T7 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_strchr.c" << 'EOF'
#include <stdio.h>
char *ft_strchr(const char *s, int c);
int main(void)
{
    char *r;
    r = ft_strchr("Hello", 'l');  printf("T1:%s\n", r ? r : "NULL");
    r = ft_strchr("Hello", 'z');  printf("T2:%s\n", r ? r : "NULL");
    r = ft_strchr("Hello", '\0'); printf("T3:[%s]\n", r ? r : "NULL");
    r = ft_strchr("Hello", 'H');  printf("T4:%s\n", r ? r : "NULL");
    r = ft_strchr("abcabc", 'b'); printf("T5:%s\n", r ? r : "NULL");
    r = ft_strchr("", 'a');       printf("T6:%s\n", r ? r : "NULL");
    r = ft_strchr("", '\0');      printf("T7:[%s]\n", r ? r : "NULL");
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strchr.c" "$TMPDIR_TESTS/t_strchr"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strchr")"
begin_func "ft_strchr"
check_str "ft_strchr Hello l first occurrence"      "$(get_val T1 "$OUTPUT")" "llo"
check_str "ft_strchr Hello z not found"             "$(get_val T2 "$OUTPUT")" "NULL"
check_str "ft_strchr Hello nul byte"                "$(get_val T3 "$OUTPUT")" "[]"
check_str "ft_strchr Hello H first char"            "$(get_val T4 "$OUTPUT")" "Hello"
check_str "ft_strchr abcabc b first of two"         "$(get_val T5 "$OUTPUT")" "bcabc"
check_str "ft_strchr empty string"                  "$(get_val T6 "$OUTPUT")" "NULL"
check_str "ft_strchr nul in empty string"           "$(get_val T7 "$OUTPUT")" "[]"
end_func

cat > "$TMPDIR_TESTS/t_strrchr.c" << 'EOF'
#include <stdio.h>
char *ft_strrchr(const char *s, int c);
int main(void)
{
    char *r;
    r = ft_strrchr("Hello", 'l');   printf("T1:%s\n", r ? r : "NULL");
    r = ft_strrchr("Hello", 'z');   printf("T2:%s\n", r ? r : "NULL");
    r = ft_strrchr("Hello", '\0');  printf("T3:[%s]\n", r ? r : "NULL");
    r = ft_strrchr("abcabc", 'a');  printf("T4:%s\n", r ? r : "NULL");
    r = ft_strrchr("Hello", 'H');   printf("T5:%s\n", r ? r : "NULL");
    r = ft_strrchr("Hello", 'o');   printf("T6:%s\n", r ? r : "NULL");
    r = ft_strrchr("", 'a');        printf("T7:%s\n", r ? r : "NULL");
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strrchr.c" "$TMPDIR_TESTS/t_strrchr"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strrchr")"
begin_func "ft_strrchr"
check_str "ft_strrchr Hello l last occurrence"      "$(get_val T1 "$OUTPUT")" "lo"
check_str "ft_strrchr Hello z not found"            "$(get_val T2 "$OUTPUT")" "NULL"
check_str "ft_strrchr Hello nul byte"               "$(get_val T3 "$OUTPUT")" "[]"
check_str "ft_strrchr abcabc a last occurrence"     "$(get_val T4 "$OUTPUT")" "abc"
check_str "ft_strrchr Hello H unique"               "$(get_val T5 "$OUTPUT")" "Hello"
check_str "ft_strrchr Hello o last char"            "$(get_val T6 "$OUTPUT")" "o"
check_str "ft_strrchr empty string"                 "$(get_val T7 "$OUTPUT")" "NULL"
end_func

cat > "$TMPDIR_TESTS/t_strncmp.c" << 'EOF'
#include <stdio.h>
int ft_strncmp(const char *s1, const char *s2, size_t n);
int main(void)
{
    printf("T1:%d\n", ft_strncmp("abc", "abc", 3) == 0);
    printf("T2:%d\n", ft_strncmp("abc", "xyz", 0) == 0);
    printf("T3:%d\n", ft_strncmp("abcX", "abcY", 4) < 0);
    printf("T4:%d\n", ft_strncmp("abcX", "abcY", 3) == 0);
    printf("T5:%d\n", ft_strncmp("\x80", "\x01", 1) > 0);
    printf("T6:%d\n", ft_strncmp("abc", "abcd", 4) < 0);
    printf("T7:%d\n", ft_strncmp("abcd", "abc", 4) > 0);
    printf("T8:%d\n", ft_strncmp("hi", "hi", 100) == 0);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strncmp.c" "$TMPDIR_TESTS/t_strncmp"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strncmp")"
begin_func "ft_strncmp"
check_int "ft_strncmp abc abc n=3 equal"            "$(get_val T1 "$OUTPUT")" "1"
check_int "ft_strncmp n=0 always equal"             "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_strncmp abcX abcY n=4 s1<s2"          "$(get_val T3 "$OUTPUT")" "1"
check_int "ft_strncmp abcX abcY n=3 equal"          "$(get_val T4 "$OUTPUT")" "1"
check_int "ft_strncmp x80 x01 unsigned comparison"  "$(get_val T5 "$OUTPUT")" "1"
check_int "ft_strncmp abc abcd n=4 s1<s2"           "$(get_val T6 "$OUTPUT")" "1"
check_int "ft_strncmp abcd abc n=4 s1>s2"           "$(get_val T7 "$OUTPUT")" "1"
check_int "ft_strncmp hi hi n=100 equal"            "$(get_val T8 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_strdup.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *ft_strdup(const char *s);
int main(void)
{
    char *r;
    r = ft_strdup("Hello"); printf("T1:%s\n", r); free(r);
    r = ft_strdup(""); printf("T2:[%s]\n", r); free(r);
    r = ft_strdup("Hello"); printf("T3:%d\n", r != NULL); free(r);
    const char *orig = "Hello";
    r = ft_strdup(orig);
    r[0] = 'J';
    printf("T4:%s %s\n", r, orig);
    free(r);
    r = ft_strdup("abcdefghijklmnopqrstuvwxyz");
    printf("T5:%zu\n", strlen(r));
    free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strdup.c" "$TMPDIR_TESTS/t_strdup"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strdup")"
begin_func "ft_strdup"
check_str "ft_strdup Hello"                         "$(get_val T1 "$OUTPUT")" "Hello"
check_str "ft_strdup empty string"                  "$(get_val T2 "$OUTPUT")" "[]"
check_int "ft_strdup returns non-null"              "$(get_val T3 "$OUTPUT")" "1"
check_str "ft_strdup independent copy"              "$(get_val T4 "$OUTPUT")" "Jello Hello"
check_int "ft_strdup 26 char string"                "$(get_val T5 "$OUTPUT")" "26"
end_func

cat > "$TMPDIR_TESTS/t_strlcpy.c" << 'EOF'
#include <stdio.h>
#include <stddef.h>
#include <string.h>
size_t ft_strlcpy(char *dst, const char *src, size_t dstsize);
int main(void)
{
    char buf[30];
    printf("T1:%zu\n", ft_strlcpy(buf, "Hello", 100));
    printf("T2:%s\n", buf);
    printf("T3:%zu\n", ft_strlcpy(buf, "Hello", 3));
    printf("T4:%s\n", buf);
    memset(buf, 'A', 5); buf[5] = '\0';
    printf("T5:%zu\n", ft_strlcpy(buf, "Hello", 0));
    printf("T6:%s\n", buf);
    printf("T7:%zu\n", ft_strlcpy(buf, "Hello", 1));
    printf("T8:[%s]\n", buf);
    printf("T9:%zu\n", ft_strlcpy(buf, "Hello", 6));
    printf("T10:%s\n", buf);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strlcpy.c" "$TMPDIR_TESTS/t_strlcpy"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strlcpy")"
begin_func "ft_strlcpy"
check_int "ft_strlcpy Hello n=100 returns 5"        "$(get_val T1 "$OUTPUT")" "5"
check_str "ft_strlcpy Hello n=100 result"           "$(get_val T2 "$OUTPUT")" "Hello"
check_int "ft_strlcpy Hello n=3 returns 5"          "$(get_val T3 "$OUTPUT")" "5"
check_str "ft_strlcpy Hello n=3 truncated to He"    "$(get_val T4 "$OUTPUT")" "He"
check_int "ft_strlcpy Hello n=0 returns 5"          "$(get_val T5 "$OUTPUT")" "5"
check_str "ft_strlcpy Hello n=0 dst untouched"      "$(get_val T6 "$OUTPUT")" "AAAAA"
check_int "ft_strlcpy Hello n=1 returns 5"          "$(get_val T7 "$OUTPUT")" "5"
check_str "ft_strlcpy Hello n=1 only nul"           "$(get_val T8 "$OUTPUT")" "[]"
check_int "ft_strlcpy Hello n=6 exact fit ret 5"    "$(get_val T9 "$OUTPUT")" "5"
check_str "ft_strlcpy Hello n=6 exact fit result"   "$(get_val T10 "$OUTPUT")" "Hello"
end_func

cat > "$TMPDIR_TESTS/t_strlcat.c" << 'EOF'
#include <stdio.h>
#include <stddef.h>
size_t ft_strlcpy(char *dst, const char *src, size_t dstsize);
size_t ft_strlcat(char *dst, const char *src, size_t dstsize);
int main(void)
{
    char buf[30];
    ft_strlcpy(buf, "Hello", 30);
    printf("T1:%zu\n", ft_strlcat(buf, " World", 30));
    printf("T2:%s\n", buf);
    ft_strlcpy(buf, "Hi", 30);
    printf("T3:%zu\n", ft_strlcat(buf, "Hello", 4));
    printf("T4:%s\n", buf);
    ft_strlcpy(buf, "Hi", 30);
    printf("T5:%zu\n", ft_strlcat(buf, "Hello", 2));
    printf("T6:%s\n", buf);
    ft_strlcpy(buf, "Hi", 30);
    printf("T7:%zu\n", ft_strlcat(buf, "Hello", 0));
    printf("T8:%s\n", buf);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strlcat.c" "$TMPDIR_TESTS/t_strlcat"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strlcat")"
begin_func "ft_strlcat"
check_int "ft_strlcat Hello+World n=30 returns 11"  "$(get_val T1 "$OUTPUT")" "11"
check_str "ft_strlcat Hello+World result"           "$(get_val T2 "$OUTPUT")" "Hello World"
check_int "ft_strlcat Hi+Hello n=4 returns 7"       "$(get_val T3 "$OUTPUT")" "7"
check_str "ft_strlcat Hi+Hello n=4 truncated HiH"   "$(get_val T4 "$OUTPUT")" "HiH"
check_int "ft_strlcat Hi+Hello n=2 dstsize==len->7" "$(get_val T5 "$OUTPUT")" "7"
check_str "ft_strlcat Hi+Hello n=2 dst untouched"   "$(get_val T6 "$OUTPUT")" "Hi"
check_int "ft_strlcat Hi+Hello n=0 returns 5"       "$(get_val T7 "$OUTPUT")" "5"
check_str "ft_strlcat Hi+Hello n=0 dst untouched"   "$(get_val T8 "$OUTPUT")" "Hi"
end_func

cat > "$TMPDIR_TESTS/t_strnstr.c" << 'EOF'
#include <stdio.h>
char *ft_strnstr(const char *haystack, const char *needle, size_t len);
int main(void)
{
    char *r;
    r = ft_strnstr("Hello", "llo", 5);      printf("T1:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "xyz", 5);      printf("T2:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "", 5);         printf("T3:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "llo", 4);      printf("T4:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "Hello", 5);    printf("T5:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "H", 0);        printf("T6:%s\n", r ? r : "NULL");
    r = ft_strnstr("Hi", "Hello", 5);       printf("T7:%s\n", r ? r : "NULL");
    r = ft_strnstr("", "Hello", 5);         printf("T8:%s\n", r ? r : "NULL");
    r = ft_strnstr("", "", 0);              printf("T9:[%s]\n", r ? r : "NULL");
    r = ft_strnstr("Hello", "lo", 5);       printf("T10:%s\n", r ? r : "NULL");
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strnstr.c" "$TMPDIR_TESTS/t_strnstr"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strnstr")"
begin_func "ft_strnstr"
check_str "ft_strnstr Hello llo n=5 found"          "$(get_val T1 "$OUTPUT")" "llo"
check_str "ft_strnstr Hello xyz n=5 not found"      "$(get_val T2 "$OUTPUT")" "NULL"
check_str "ft_strnstr Hello empty needle"           "$(get_val T3 "$OUTPUT")" "Hello"
check_str "ft_strnstr Hello llo n=4 beyond n"       "$(get_val T4 "$OUTPUT")" "NULL"
check_str "ft_strnstr Hello Hello n=5 full match"   "$(get_val T5 "$OUTPUT")" "Hello"
check_str "ft_strnstr Hello H n=0"                  "$(get_val T6 "$OUTPUT")" "NULL"
check_str "ft_strnstr Hi Hello needle>haystack"     "$(get_val T7 "$OUTPUT")" "NULL"
check_str "ft_strnstr empty haystack"               "$(get_val T8 "$OUTPUT")" "NULL"
check_str "ft_strnstr both empty n=0"               "$(get_val T9 "$OUTPUT")" "[]"
check_str "ft_strnstr Hello lo n=5 end match"       "$(get_val T10 "$OUTPUT")" "lo"
end_func

cat > "$TMPDIR_TESTS/t_substr.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char *ft_substr(char const *s, unsigned int start, size_t len);
int main(void)
{
    char *r;
    r = ft_substr("Hello World", 6, 5);  printf("T1:%s\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 0, 3);        printf("T2:%s\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 10, 3);       printf("T3:[%s]\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 3, 100);      printf("T4:%s\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 0, 0);        printf("T5:[%s]\n", r ? r : "NULL"); free(r);
    r = ft_substr(NULL, 0, 5);           printf("T6:%s\n", r ? r : "NULL");
    r = ft_substr("Hello", 5, 3);        printf("T7:[%s]\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 0, 5);        printf("T8:%s\n", r ? r : "NULL"); free(r);
    r = ft_substr("Hello", 1, 1);        printf("T9:%s\n", r ? r : "NULL"); free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_substr.c" "$TMPDIR_TESTS/t_substr"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_substr")"
begin_func "ft_substr"
check_str "ft_substr Hello World start=6 len=5"     "$(get_val T1 "$OUTPUT")" "World"
check_str "ft_substr Hello start=0 len=3"           "$(get_val T2 "$OUTPUT")" "Hel"
check_str "ft_substr Hello start=10 beyond len"     "$(get_val T3 "$OUTPUT")" "[]"
check_str "ft_substr Hello start=3 len=100"         "$(get_val T4 "$OUTPUT")" "lo"
check_str "ft_substr Hello len=0"                   "$(get_val T5 "$OUTPUT")" "[]"
check_str "ft_substr NULL returns NULL"             "$(get_val T6 "$OUTPUT")" "NULL"
check_str "ft_substr Hello start==strlen"           "$(get_val T7 "$OUTPUT")" "[]"
check_str "ft_substr Hello start=0 len=strlen"      "$(get_val T8 "$OUTPUT")" "Hello"
check_str "ft_substr Hello start=1 len=1"           "$(get_val T9 "$OUTPUT")" "e"
end_func

cat > "$TMPDIR_TESTS/t_strjoin.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *ft_strjoin(char const *s1, char const *s2);
int main(void)
{
    char *r;
    r = ft_strjoin("Hello", " World"); printf("T1:%s\n", r); free(r);
    r = ft_strjoin("", "World");       printf("T2:%s\n", r); free(r);
    r = ft_strjoin("Hello", "");       printf("T3:%s\n", r); free(r);
    r = ft_strjoin("", "");            printf("T4:[%s]\n", r); free(r);
    r = ft_strjoin("abc", "def");
    printf("T5:%zu\n", strlen(r));
    printf("T6:%s\n", r);
    free(r);
    r = ft_strjoin("a", "b");
    printf("T7:%d\n", r != NULL);
    free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strjoin.c" "$TMPDIR_TESTS/t_strjoin"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strjoin")"
begin_func "ft_strjoin"
check_str "ft_strjoin Hello + World"                "$(get_val T1 "$OUTPUT")" "Hello World"
check_str "ft_strjoin empty + World"                "$(get_val T2 "$OUTPUT")" "World"
check_str "ft_strjoin Hello + empty"                "$(get_val T3 "$OUTPUT")" "Hello"
check_str "ft_strjoin both empty"                   "$(get_val T4 "$OUTPUT")" "[]"
check_int "ft_strjoin abc+def strlen==6"            "$(get_val T5 "$OUTPUT")" "6"
check_str "ft_strjoin abc+def result"               "$(get_val T6 "$OUTPUT")" "abcdef"
check_int "ft_strjoin returns non-null"             "$(get_val T7 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_strtrim.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char *ft_strtrim(char const *s1, char const *set);
int main(void)
{
    char *r;
    r = ft_strtrim("  Hello  ", " ");      printf("T1:%s\n", r); free(r);
    r = ft_strtrim("xxHelloxx", "x");      printf("T2:%s\n", r); free(r);
    r = ft_strtrim("Hello", "");           printf("T3:%s\n", r); free(r);
    r = ft_strtrim("", " ");               printf("T4:[%s]\n", r); free(r);
    r = ft_strtrim("aaaa", "a");           printf("T5:[%s]\n", r); free(r);
    r = ft_strtrim("  Hello  ", "eHlo ");  printf("T6:[%s]\n", r); free(r);
    r = ft_strtrim("Hello", "xyz");        printf("T7:%s\n", r); free(r);
    r = ft_strtrim("   Hello", " ");       printf("T8:%s\n", r); free(r);
    r = ft_strtrim("Hello   ", " ");       printf("T9:%s\n", r); free(r);
    r = ft_strtrim("abHelloab", "ab");     printf("T10:%s\n", r); free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strtrim.c" "$TMPDIR_TESTS/t_strtrim"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strtrim")"
begin_func "ft_strtrim"
check_str "ft_strtrim trim spaces both sides"       "$(get_val T1 "$OUTPUT")" "Hello"
check_str "ft_strtrim trim x both sides"            "$(get_val T2 "$OUTPUT")" "Hello"
check_str "ft_strtrim empty set no change"          "$(get_val T3 "$OUTPUT")" "Hello"
check_str "ft_strtrim empty string"                 "$(get_val T4 "$OUTPUT")" "[]"
check_str "ft_strtrim all chars trimmed"            "$(get_val T5 "$OUTPUT")" "[]"
check_str "ft_strtrim multi-char set all removed"   "$(get_val T6 "$OUTPUT")" "[]"
check_str "ft_strtrim set not in string"            "$(get_val T7 "$OUTPUT")" "Hello"
check_str "ft_strtrim left side only"               "$(get_val T8 "$OUTPUT")" "Hello"
check_str "ft_strtrim right side only"              "$(get_val T9 "$OUTPUT")" "Hello"
check_str "ft_strtrim multi-char set ab"            "$(get_val T10 "$OUTPUT")" "Hello"
end_func

cat > "$TMPDIR_TESTS/t_calloc.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
void *ft_calloc(size_t count, size_t size);
int main(void)
{
    char *r;
    r = ft_calloc(5, 1);
    printf("T1:%d\n", r[0] == 0 && r[2] == 0 && r[4] == 0); free(r);
    r = ft_calloc(5, 1); printf("T2:%d\n", r != NULL); free(r);
    r = ft_calloc(0, 1); printf("T3:%d\n", r != NULL); free(r);
    int *arr = ft_calloc(4, sizeof(int));
    printf("T4:%d\n", arr[0] == 0 && arr[3] == 0); free(arr);
    r = ft_calloc(1, 0); printf("T5:%d\n", r != NULL); free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_calloc.c" "$TMPDIR_TESTS/t_calloc"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_calloc")"
begin_func "ft_calloc"
check_int "ft_calloc 5 1 all bytes zero"            "$(get_val T1 "$OUTPUT")" "1"
check_int "ft_calloc 5 1 returns non-null"          "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_calloc 0 1 returns non-null"          "$(get_val T3 "$OUTPUT")" "1"
check_int "ft_calloc 4 sizeof-int all zero"         "$(get_val T4 "$OUTPUT")" "1"
check_int "ft_calloc 1 0 returns non-null"          "$(get_val T5 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_itoa.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char *ft_itoa(int n);
int main(void)
{
    char *r;
    r = ft_itoa(0);           printf("T1:%s\n", r); free(r);
    r = ft_itoa(42);          printf("T2:%s\n", r); free(r);
    r = ft_itoa(-42);         printf("T3:%s\n", r); free(r);
    r = ft_itoa(2147483647);  printf("T4:%s\n", r); free(r);
    r = ft_itoa(-2147483648); printf("T5:%s\n", r); free(r);
    r = ft_itoa(1000000);     printf("T6:%s\n", r); free(r);
    r = ft_itoa(-1);          printf("T7:%s\n", r); free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_itoa.c" "$TMPDIR_TESTS/t_itoa"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_itoa")"
begin_func "ft_itoa"
check_str "ft_itoa 0"                               "$(get_val T1 "$OUTPUT")" "0"
check_str "ft_itoa 42"                              "$(get_val T2 "$OUTPUT")" "42"
check_str "ft_itoa -42"                             "$(get_val T3 "$OUTPUT")" "-42"
check_str "ft_itoa INT_MAX"                         "$(get_val T4 "$OUTPUT")" "2147483647"
check_str "ft_itoa INT_MIN"                         "$(get_val T5 "$OUTPUT")" "-2147483648"
check_str "ft_itoa 1000000"                         "$(get_val T6 "$OUTPUT")" "1000000"
check_str "ft_itoa -1"                              "$(get_val T7 "$OUTPUT")" "-1"
end_func

cat > "$TMPDIR_TESTS/t_split.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char **ft_split(char const *s, char c);
int main(void)
{
    char **r;
    int i;

    r = ft_split("Hello World", ' ');
    printf("T1:%s\n", r[0]); printf("T2:%s\n", r[1]); printf("T3:%s\n", r[2] ? r[2] : "NULL");
    i = 0; while (r[i]) free(r[i++]); free(r);

    r = ft_split("one:two:three", ':');
    printf("T4:%s\n", r[0]); printf("T5:%s\n", r[1]); printf("T6:%s\n", r[2]);
    i = 0; while (r[i]) free(r[i++]); free(r);

    r = ft_split("  spaces  ", ' ');
    printf("T7:%s\n", r[0]); printf("T8:%s\n", r[1] ? r[1] : "NULL");
    i = 0; while (r[i]) free(r[i++]); free(r);

    r = ft_split("", ' ');
    printf("T9:%s\n", r[0] ? r[0] : "NULL");
    free(r);

    r = ft_split("nodel", ':');
    printf("T10:%s\n", r[0]);
    i = 0; while (r[i]) free(r[i++]); free(r);

    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_split.c" "$TMPDIR_TESTS/t_split"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_split")"
begin_func "ft_split"
check_str "ft_split Hello World[0]"                 "$(get_val T1 "$OUTPUT")" "Hello"
check_str "ft_split Hello World[1]"                 "$(get_val T2 "$OUTPUT")" "World"
check_str "ft_split Hello World[2] NULL"            "$(get_val T3 "$OUTPUT")" "NULL"
check_str "ft_split one:two:three[0]"               "$(get_val T4 "$OUTPUT")" "one"
check_str "ft_split one:two:three[1]"               "$(get_val T5 "$OUTPUT")" "two"
check_str "ft_split one:two:three[2]"               "$(get_val T6 "$OUTPUT")" "three"
check_str "ft_split spaces word[0]"                 "$(get_val T7 "$OUTPUT")" "spaces"
check_str "ft_split spaces NULL terminator"         "$(get_val T8 "$OUTPUT")" "NULL"
check_str "ft_split empty string NULL"              "$(get_val T9 "$OUTPUT")" "NULL"
check_str "ft_split no delimiter"                   "$(get_val T10 "$OUTPUT")" "nodel"
end_func

cat > "$TMPDIR_TESTS/t_strmapi.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
char *ft_strmapi(char const *s, char (*f)(unsigned int, char));
char upper_if_even(unsigned int i, char c)
{
    if (i % 2 == 0 && c >= 'a' && c <= 'z') return c - 32;
    return c;
}
int main(int argc, char **argv)
{
    char *r;
    if (argc > 1 && argv[1][0] == 'n')
    {
        r = ft_strmapi(NULL, upper_if_even);
        printf("T5:%s\n", r ? r : "NULL");
        return 0;
    }
    r = ft_strmapi("hello", upper_if_even); printf("T1:%s\n", r); free(r);
    r = ft_strmapi("", upper_if_even);      printf("T2:%s\n", r ? r : "ALLOC_FAIL"); free(r);
    r = ft_strmapi("abcde", upper_if_even); printf("T3:%s\n", r); free(r);
    r = ft_strmapi("12345", upper_if_even); printf("T4:%s\n", r); free(r);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_strmapi.c" "$TMPDIR_TESTS/t_strmapi"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_strmapi")"
_null_out=$("$TMPDIR_TESTS/t_strmapi" n 2>/dev/null)
_null_status=$?
if [ $_null_status -ge 128 ]; then
    _strmapi_null="CRASH"
else
    _strmapi_null="$(get_val T5 "$_null_out")"
fi
begin_func "ft_strmapi"
check_str "ft_strmapi upper even indices"           "$(get_val T1 "$OUTPUT")" "HeLlO"
check_str "ft_strmapi empty string returns empty"   "$(get_val T2 "$OUTPUT")" ""
check_str "ft_strmapi abcde upper even"             "$(get_val T3 "$OUTPUT")" "AbCdE"
check_str "ft_strmapi digits unchanged"             "$(get_val T4 "$OUTPUT")" "12345"
check_str "ft_strmapi NULL returns NULL"            "$_strmapi_null"          "NULL"
end_func

cat > "$TMPDIR_TESTS/t_striteri.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
void ft_striteri(char *s, void (*f)(unsigned int, char *));
void upper_at(unsigned int i, char *c)
{
    if (i % 2 == 0 && *c >= 'a' && *c <= 'z') *c -= 32;
}
int main(int argc, char **argv)
{
    if (argc > 1 && argv[1][0] == 'n')
    {
        ft_striteri(NULL, upper_at);
        printf("T4:ok\n");
        return 0;
    }
    char s1[] = "hello";
    ft_striteri(s1, upper_at); printf("T1:%s\n", s1);
    char s2[] = "";
    ft_striteri(s2, upper_at); printf("T2:%s\n", s2);
    char s3[] = "abcde";
    ft_striteri(s3, upper_at); printf("T3:%s\n", s3);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_striteri.c" "$TMPDIR_TESTS/t_striteri"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_striteri")"
_null_out=$("$TMPDIR_TESTS/t_striteri" n 2>/dev/null)
_null_status=$?
if [ $_null_status -ge 128 ]; then
    _striteri_null="CRASH"
else
    _striteri_null="$(get_val T4 "$_null_out")"
fi
begin_func "ft_striteri"
check_str "ft_striteri upper even indices"          "$(get_val T1 "$OUTPUT")" "HeLlO"
check_str "ft_striteri empty string"                "$(get_val T2 "$OUTPUT")" ""
check_str "ft_striteri abcde upper even"            "$(get_val T3 "$OUTPUT")" "AbCdE"
check_str "ft_striteri NULL does not crash"         "$_striteri_null"         "ok"
end_func

cat > "$TMPDIR_TESTS/t_putchar_fd.c" << 'EOF'
#include <unistd.h>
void ft_putchar_fd(char c, int fd);
int main(void)
{
    ft_putchar_fd('A', 1); write(1, "\n", 1);
    ft_putchar_fd('z', 1); write(1, "\n", 1);
    ft_putchar_fd('0', 1); write(1, "\n", 1);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_putchar_fd.c" "$TMPDIR_TESTS/t_putchar_fd"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_putchar_fd")"
begin_func "ft_putchar_fd"
check_str "ft_putchar_fd A"                         "$(printf '%s\n' "$OUTPUT" | sed -n '1p')" "A"
check_str "ft_putchar_fd z"                         "$(printf '%s\n' "$OUTPUT" | sed -n '2p')" "z"
check_str "ft_putchar_fd 0"                         "$(printf '%s\n' "$OUTPUT" | sed -n '3p')" "0"
end_func

cat > "$TMPDIR_TESTS/t_putstr_fd.c" << 'EOF'
#include <unistd.h>
void ft_putstr_fd(char *s, int fd);
int main(void)
{
    ft_putstr_fd("Hello", 1); write(1, "\n", 1);
    ft_putstr_fd("42", 1);    write(1, "\n", 1);
    ft_putstr_fd("a", 1);     write(1, "\n", 1);
    write(1, "BEFORE", 6);
    ft_putstr_fd("", 1);
    write(1, "AFTER\n", 6);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_putstr_fd.c" "$TMPDIR_TESTS/t_putstr_fd"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_putstr_fd")"
begin_func "ft_putstr_fd"
check_str "ft_putstr_fd Hello"                      "$(printf '%s\n' "$OUTPUT" | sed -n '1p')" "Hello"
check_str "ft_putstr_fd 42"                         "$(printf '%s\n' "$OUTPUT" | sed -n '2p')" "42"
check_str "ft_putstr_fd single char"                "$(printf '%s\n' "$OUTPUT" | sed -n '3p')" "a"
check_str "ft_putstr_fd empty writes nothing"       "$(printf '%s\n' "$OUTPUT" | sed -n '4p')" "BEFOREAFTER"
end_func

cat > "$TMPDIR_TESTS/t_putendl_fd.c" << 'EOF'
#include <stdio.h>
void ft_putendl_fd(char *s, int fd);
int main(void)
{
    ft_putendl_fd("Hello", 1);
    ft_putendl_fd("World", 1);
    ft_putendl_fd("", 1);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_putendl_fd.c" "$TMPDIR_TESTS/t_putendl_fd"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_putendl_fd")"
begin_func "ft_putendl_fd"
check_str "ft_putendl_fd Hello newline"             "$(printf '%s\n' "$OUTPUT" | sed -n '1p')" "Hello"
check_str "ft_putendl_fd World newline"             "$(printf '%s\n' "$OUTPUT" | sed -n '2p')" "World"
check_str "ft_putendl_fd empty newline"             "$(printf '%s\n' "$OUTPUT" | sed -n '3p')" ""
end_func

cat > "$TMPDIR_TESTS/t_putnbr_fd.c" << 'EOF'
#include <unistd.h>
void ft_putnbr_fd(int n, int fd);
int main(void)
{
    write(1, "BEFORE", 6); ft_putnbr_fd(42, 1);          write(1, "AFTER\n", 6);
    write(1, "BEFORE", 6); ft_putnbr_fd(-42, 1);         write(1, "AFTER\n", 6);
    write(1, "BEFORE", 6); ft_putnbr_fd(0, 1);           write(1, "AFTER\n", 6);
    write(1, "BEFORE", 6); ft_putnbr_fd(2147483647, 1);  write(1, "AFTER\n", 6);
    write(1, "BEFORE", 6); ft_putnbr_fd(-2147483648, 1); write(1, "AFTER\n", 6);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_putnbr_fd.c" "$TMPDIR_TESTS/t_putnbr_fd"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_putnbr_fd")"
begin_func "ft_putnbr_fd"
check_str "ft_putnbr_fd 42"                         "$(printf '%s\n' "$OUTPUT" | sed -n '1p')" "BEFORE42AFTER"
check_str "ft_putnbr_fd -42"                        "$(printf '%s\n' "$OUTPUT" | sed -n '2p')" "BEFORE-42AFTER"
check_str "ft_putnbr_fd 0"                          "$(printf '%s\n' "$OUTPUT" | sed -n '3p')" "BEFORE0AFTER"
check_str "ft_putnbr_fd INT_MAX"                    "$(printf '%s\n' "$OUTPUT" | sed -n '4p')" "BEFORE2147483647AFTER"
check_str "ft_putnbr_fd INT_MIN"                    "$(printf '%s\n' "$OUTPUT" | sed -n '5p')" "BEFORE-2147483648AFTER"
end_func

cat > "$TMPDIR_TESTS/t_lstnew.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
int main(void)
{
    t_list *n;
    n = ft_lstnew((void *)"hello");
    printf("T1:%s\n", (char *)n->content);
    printf("T2:%d\n", n->next == NULL);
    free(n);
    n = ft_lstnew(NULL);
    printf("T3:%d\n", n->content == NULL);
    printf("T4:%d\n", n->next == NULL);
    free(n);
    n = ft_lstnew((void *)"x");
    printf("T5:%d\n", n != NULL);
    free(n);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstnew.c" "$TMPDIR_TESTS/t_lstnew"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstnew")"
begin_func "ft_lstnew"
check_str "ft_lstnew content set"                   "$(get_val T1 "$OUTPUT")" "hello"
check_int "ft_lstnew next is NULL"                  "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_lstnew NULL content stored"           "$(get_val T3 "$OUTPUT")" "1"
check_int "ft_lstnew NULL content next NULL"        "$(get_val T4 "$OUTPUT")" "1"
check_int "ft_lstnew returns non-null"              "$(get_val T5 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_lstadd_front.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_front(t_list **lst, t_list *new);
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew((void *)"A");
    t_list *b = ft_lstnew((void *)"B");
    t_list *c = ft_lstnew((void *)"C");
    ft_lstadd_front(&lst, a);
    printf("T1:%s\n", (char *)lst->content);
    ft_lstadd_front(&lst, b);
    printf("T2:%s\n", (char *)lst->content);
    printf("T3:%s\n", (char *)lst->next->content);
    ft_lstadd_front(&lst, c);
    printf("T4:%s\n", (char *)lst->content);
    printf("T5:%d\n", lst->next->next->next == NULL);
    t_list *lst2 = NULL;
    t_list *d = ft_lstnew((void *)"D");
    ft_lstadd_front(&lst2, d);
    printf("T6:%s\n", (char *)lst2->content);
    free(a); free(b); free(c); free(d);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstadd_front.c" "$TMPDIR_TESTS/t_lstadd_front"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstadd_front")"
begin_func "ft_lstadd_front"
check_str "ft_lstadd_front first node is head"      "$(get_val T1 "$OUTPUT")" "A"
check_str "ft_lstadd_front new head is B"           "$(get_val T2 "$OUTPUT")" "B"
check_str "ft_lstadd_front old head still A"        "$(get_val T3 "$OUTPUT")" "A"
check_str "ft_lstadd_front new head is C"           "$(get_val T4 "$OUTPUT")" "C"
check_int "ft_lstadd_front list ends with NULL"     "$(get_val T5 "$OUTPUT")" "1"
check_str "ft_lstadd_front onto NULL list"          "$(get_val T6 "$OUTPUT")" "D"
end_func

cat > "$TMPDIR_TESTS/t_lstsize.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
int ft_lstsize(t_list *lst);
int main(void)
{
    t_list *lst = NULL;
    printf("T1:%d\n", ft_lstsize(lst));
    t_list *a = ft_lstnew((void *)"a");
    ft_lstadd_back(&lst, a);
    printf("T2:%d\n", ft_lstsize(lst));
    t_list *b = ft_lstnew((void *)"b");
    t_list *c = ft_lstnew((void *)"c");
    ft_lstadd_back(&lst, b);
    ft_lstadd_back(&lst, c);
    printf("T3:%d\n", ft_lstsize(lst));
    free(a); free(b); free(c);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstsize.c" "$TMPDIR_TESTS/t_lstsize"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstsize")"
begin_func "ft_lstsize"
check_int "ft_lstsize NULL list == 0"               "$(get_val T1 "$OUTPUT")" "0"
check_int "ft_lstsize 1 element == 1"               "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_lstsize 3 elements == 3"              "$(get_val T3 "$OUTPUT")" "3"
end_func

cat > "$TMPDIR_TESTS/t_lstlast.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
t_list *ft_lstlast(t_list *lst);
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew((void *)"A");
    t_list *b = ft_lstnew((void *)"B");
    t_list *c = ft_lstnew((void *)"C");
    ft_lstadd_back(&lst, a);
    printf("T1:%s\n", (char *)ft_lstlast(lst)->content);
    ft_lstadd_back(&lst, b);
    ft_lstadd_back(&lst, c);
    printf("T2:%s\n", (char *)ft_lstlast(lst)->content);
    printf("T3:%d\n", ft_lstlast(lst)->next == NULL);
    free(a); free(b); free(c);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstlast.c" "$TMPDIR_TESTS/t_lstlast"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstlast")"
begin_func "ft_lstlast"
check_str "ft_lstlast single node"                  "$(get_val T1 "$OUTPUT")" "A"
check_str "ft_lstlast last of 3 nodes"              "$(get_val T2 "$OUTPUT")" "C"
check_int "ft_lstlast next is NULL"                 "$(get_val T3 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_lstadd_back.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew((void *)"A");
    t_list *b = ft_lstnew((void *)"B");
    t_list *c = ft_lstnew((void *)"C");
    ft_lstadd_back(&lst, a);
    printf("T1:%s\n", (char *)lst->content);
    ft_lstadd_back(&lst, b);
    printf("T2:%s\n", (char *)lst->next->content);
    ft_lstadd_back(&lst, c);
    printf("T3:%s\n", (char *)lst->next->next->content);
    printf("T4:%d\n", lst->next->next->next == NULL);
    printf("T5:%s\n", (char *)lst->content);
    free(a); free(b); free(c);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstadd_back.c" "$TMPDIR_TESTS/t_lstadd_back"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstadd_back")"
begin_func "ft_lstadd_back"
check_str "ft_lstadd_back first node is head"       "$(get_val T1 "$OUTPUT")" "A"
check_str "ft_lstadd_back B appended at back"       "$(get_val T2 "$OUTPUT")" "B"
check_str "ft_lstadd_back C appended at back"       "$(get_val T3 "$OUTPUT")" "C"
check_int "ft_lstadd_back list ends with NULL"      "$(get_val T4 "$OUTPUT")" "1"
check_str "ft_lstadd_back head unchanged"           "$(get_val T5 "$OUTPUT")" "A"
end_func

cat > "$TMPDIR_TESTS/t_lstdelone.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstdelone(t_list *lst, void (*del)(void *));
int g_del_count = 0;
void del_fn(void *c) { (void)c; g_del_count++; }
int main(void)
{
    /* T1: del is called exactly once */
    t_list *a = ft_lstnew(malloc(1));
    ft_lstdelone(a, del_fn);
    printf("T1:%d\n", g_del_count);

    /* T2: next node is NOT freed/touched */
    t_list *b = ft_lstnew(malloc(1));
    t_list *c = ft_lstnew(malloc(1));
    b->next = c;
    ft_lstdelone(b, free);
    /* c must still be accessible and its content intact */
    printf("T2:%d\n", c != NULL && c->content != NULL);
    free(c->content);
    free(c);

    /* T3: del_fn called per node (not content of next) */
    g_del_count = 0;
    t_list *d = ft_lstnew(malloc(1));
    ft_lstdelone(d, del_fn);
    printf("T3:%d\n", g_del_count);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstdelone.c" "$TMPDIR_TESTS/t_lstdelone"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstdelone")"
begin_func "ft_lstdelone"
check_int "ft_lstdelone calls del once"             "$(get_val T1 "$OUTPUT")" "1"
check_int "ft_lstdelone next node untouched"        "$(get_val T2 "$OUTPUT")" "1"
check_int "ft_lstdelone del called on single node"  "$(get_val T3 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_lstclear.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
void ft_lstclear(t_list **lst, void (*del)(void *));
int g_del_count = 0;
void del_fn(void *c) { (void)c; g_del_count++; }
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew(malloc(1));
    t_list *b = ft_lstnew(malloc(1));
    t_list *c = ft_lstnew(malloc(1));
    ft_lstadd_back(&lst, a);
    ft_lstadd_back(&lst, b);
    ft_lstadd_back(&lst, c);
    ft_lstclear(&lst, del_fn);
    printf("T1:%d\n", lst == NULL);
    printf("T2:%d\n", g_del_count);
    t_list *lst2 = NULL;
    ft_lstclear(&lst2, del_fn);
    printf("T3:%d\n", lst2 == NULL);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstclear.c" "$TMPDIR_TESTS/t_lstclear"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstclear")"
begin_func "ft_lstclear"
check_int "ft_lstclear sets lst to NULL"            "$(get_val T1 "$OUTPUT")" "1"
check_int "ft_lstclear calls del 3 times"           "$(get_val T2 "$OUTPUT")" "3"
check_int "ft_lstclear on NULL list safe"           "$(get_val T3 "$OUTPUT")" "1"
end_func

cat > "$TMPDIR_TESTS/t_lstiter.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
void ft_lstiter(t_list *lst, void (*f)(void *));
void print_content(void *c) { printf("%s\n", (char *)c); }
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew((void *)"one");
    t_list *b = ft_lstnew((void *)"two");
    t_list *c = ft_lstnew((void *)"three");
    ft_lstadd_back(&lst, a);
    ft_lstadd_back(&lst, b);
    ft_lstadd_back(&lst, c);
    ft_lstiter(lst, print_content);
    free(a); free(b); free(c);
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstiter.c" "$TMPDIR_TESTS/t_lstiter"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstiter")"
begin_func "ft_lstiter"
check_str "ft_lstiter visits node 1"                "$(printf '%s\n' "$OUTPUT" | sed -n '1p')" "one"
check_str "ft_lstiter visits node 2"                "$(printf '%s\n' "$OUTPUT" | sed -n '2p')" "two"
check_str "ft_lstiter visits node 3"                "$(printf '%s\n' "$OUTPUT" | sed -n '3p')" "three"
end_func

cat > "$TMPDIR_TESTS/t_lstmap.c" << 'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef struct s_list { void *content; struct s_list *next; } t_list;
t_list *ft_lstnew(void *content);
void ft_lstadd_back(t_list **lst, t_list *new);
void ft_lstclear(t_list **lst, void (*del)(void *));
t_list *ft_lstmap(t_list *lst, void *(*f)(void *), void (*del)(void *));
void *dup_upper(void *c)
{
    char *s = (char *)c;
    char *r = malloc(strlen(s) + 1);
    int i = 0;
    while (s[i]) { r[i] = (s[i] >= 'a' && s[i] <= 'z') ? s[i] - 32 : s[i]; i++; }
    r[i] = '\0';
    return r;
}
int main(void)
{
    t_list *lst = NULL;
    t_list *a = ft_lstnew((void *)"hello");
    t_list *b = ft_lstnew((void *)"world");
    ft_lstadd_back(&lst, a);
    ft_lstadd_back(&lst, b);
    t_list *res = ft_lstmap(lst, dup_upper, free);
    printf("T1:%s\n", res ? (char *)res->content : "NULL");
    printf("T2:%s\n", res && res->next ? (char *)res->next->content : "NULL");
    printf("T3:%d\n", res && res->next && res->next->next == NULL);
    printf("T4:%s\n", (char *)lst->content);
    ft_lstclear(&res, free);
    free(a); free(b);
    /* NULL input must return NULL without crashing */
    t_list *null_res = ft_lstmap(NULL, dup_upper, free);
    printf("T5:%s\n", null_res ? "non-null" : "NULL");
    return 0;
}
EOF
compile_test "$TMPDIR_TESTS/t_lstmap.c" "$TMPDIR_TESTS/t_lstmap"
OUTPUT="$(run_test "$TMPDIR_TESTS/t_lstmap")"
begin_func "ft_lstmap"
check_str "ft_lstmap first node transformed"        "$(get_val T1 "$OUTPUT")" "HELLO"
check_str "ft_lstmap second node transformed"       "$(get_val T2 "$OUTPUT")" "WORLD"
check_int "ft_lstmap result ends with NULL"         "$(get_val T3 "$OUTPUT")" "1"
check_str "ft_lstmap original list untouched"       "$(get_val T4 "$OUTPUT")" "hello"
check_str "ft_lstmap NULL input returns NULL"       "$(get_val T5 "$OUTPUT")" "NULL"
end_func

end_time=$(date +%s)
elapsed=$((end_time - start_time))
total=$((total_pass + total_fail))

printf "${PURPLE}─────────────────────────────────────────────────────────${DEFAULT}\n"
space
printf "Result:   ${result}\n"
space
if [ "$total_fail" -eq 0 ]; then
    printf "Tests:    ${GREEN}${total_pass}/${total} passed${DEFAULT}\n"
    printf "Status:   ${BG_GREEN}${BLACK}${BOLD} ALL PASSED ${DEFAULT}\n"
else
    printf "Tests:    ${GREEN}${total_pass}${DEFAULT}/${total} passed   ${RED}${total_fail} failed${DEFAULT}\n"
    printf "Status:   ${BG_RED}${BOLD} SOME FAILED ${DEFAULT}\n"
fi
printf "${GREY}Completed in ${PINK}${elapsed}s${DEFAULT}\n"
space