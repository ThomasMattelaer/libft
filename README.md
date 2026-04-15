*This project has been created as part of the 42 curriculum by tmattela*

# LIBFT

## Description

libft is a project who the goal is to create a library with the core functions of the standards C library function. The goal of the project is to create our own library in order to reuse those functions in a future project.

## Instructions

In order to create the library, run:
```bash
make
```
This will compile all source files and generate the library libft.a


To remove object files run :
```bash
make clean
```

To remove the objects files and the library run:
```bash
make fclean
```

To rebuild from scratch run:
```bash
make re
```
## Resources

#### Documentation & references:
- https://www.geeksforgeeks.org/c/
- https://stackoverflow.com
- https://man7.org/linux/man-pages/
- https://en.cppreference.com/w/c.html
- https://pythontutor.com/
- https://www.geeksforgeeks.org/c/linked-list-in-c/
- https://claude.ai


#### AI Usage:
The LLM that has been used for this project is Claude. Claude was used throughout this project as a learning tool, in the spirit of the 42 pedagogy. It was never used to generate final coded solutions, but exclusively to understand concepts, clarify behavior, visualize data structures and upgrade testing/main.

## Detailed description

##### Part1 - Libc functions

1. ***ft_isalpha*** :	checks if a character is alphabetic
2. ***ft_isdigit*** :	checks if a character is a digit
3. ***ft_isalnum*** :	checks if a character is alphanumeric
4. ***ft_isascii*** :	checks if a character is a valid ASCII character
5. ***ft_isprint*** :	checks if a character is printable
6. ***ft_strlen***  :	returns the length of a string
7. ***ft_memset***  :	fills a memory area with a given byte
8. ***ft_bzero***   :	assign zeros to a memory area
9. ***ft_memcpy***  :	copies a memory area (without overlap)
10. ***ft_memmove***:	copies a memory area (overlap-safe)
11. ***ft_strlcpy***:	copies a string with size limit
12. ***ft_strlcat***:	appends a string with size limit
13. ***ft_toupper***:	converts a character to uppercase
14. ***ft_tolower***:	converts a character to lowercase
15. ***ft_strchr*** :	Locates first occurrence of a character in a string
16. ***ft_strrchr***:   Locates last occurrence of a character in a string
17. ***ft_strncmp***:   Compares two strings up to n characters
18. ***ft_memchr*** :   Searches a memory area for a byte
19. ***ft_memcmp*** :   Compares two memory areas
20. ***ft_strnstr***:   Locates a substring in a string, up to n characters
21. ***ft_atoi***   :   Converts a string to an integer
22. ***ft_calloc*** :   Allocates memory with only zeros inside
23. ***ft_strdup*** :   Duplicates a string

##### Part 2 - Additional Functions

24. ***ft_substr***    :   Extracts a substring from a string
25. ***ft_strjoin***   :   Concatenates two strings into a new one
26. ***ft_strtrim***   :   Trims characters from the start and the end of a string
27. ***ft_split***     :   Splits a string by a delimiter into an array
28. ***ft_itoa***      :   Converts an integer to a string
29. ***ft_strmapi***   :   Applies a function to each character, returning a new string
30. ***ft_striteri***  :   Applies a function to each character in place
31. ***ft_putchar_fd***:   Writes a character to a file descriptor
32. ***ft_putstr_fd*** :   Writes a string to a file descriptor
33. ***ft_putendl_fd***:   Writes a string followed by a newline to a file descriptor
34. ***ft_putnbr_fd*** :   Writes an integer to a file descriptor

##### Part 3 - Linked list

The library implements a singly linked list using the following structure:
```c
typedef struct s_list
{
    void            *content;
    struct s_list   *next;
}   t_list;
```
35. ***ft_lstnew***:        Creates a new list node
36. ***ft_lstadd_front***:  Adds a node at the front of the list
37. ***ft_lstsize***:       Returns the number of nodes in the list
38. ***ft_lstlast***:       Returns the last node of the list
39. ***ft_lstadd_back***:   Adds a node at the back of the list
40. ***ft_lstdelone***:     Deletes a single node using a given function
41. ***ft_lstclear***:      Deletes and frees all nodes of the list
42. ***ft_lstiter***:       Applies a function to each node's content
43. ***ft_lstmap***:        Applies a function to each node, returning a new list
