#ifndef LIBFT_H
# define LIBFT_H

#include <stddef.h>

int ft_isprint(int c);
int ft_isdigit(int c);
int ft_isascii(int c);
int ft_isalpha(int c);
int ft_isalnum(int c);
size_t ft_strlen(const char *s);
void * ft_memset(void *b, int c, size_t len);
void *ft_memcpy (void *restrict dst, const void *restrict src, size_t n);
void *ft_memmove(void *dst, const void *src, size_t len);

#endif