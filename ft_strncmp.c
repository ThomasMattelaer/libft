/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strncmp.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 15:20:30 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 15:20:30 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

int	ft_strncmp(const char *s1, const char *s2, size_t n)
{
	size_t			i;
	unsigned char	*str1;
	unsigned char	*str2;

	i = 0;
	str1 = (unsigned char *)s1;
	str2 = (unsigned char *)s2;
	while (str1[i] && str2[i] && str1[i] == str2[i] && i < n)
		i++;
	if (i == n)
		return (0);
	return ((int)(str1[i] - str2[i]));
}
// #include <stdio.h>
// #include <string.h>

// int main(void)
// {
// 	printf("T1 n=0		: ft=%d | std=%d\n",
// 	ft_strncmp("abc", "xyz", 0), strncmp("abc", "xyz", 0));

// 	printf("T2 s1==s2		: ft=%d | std=%d\n",
// 	ft_strncmp("abc", "abc", 3), strncmp("abc", "abc", 3));

// 	printf("T3 s1 empty		: ft=%d | std=%d\n",
// 	ft_strncmp("", "abc", 3), strncmp("", "abc", 3));

// 	printf("T4 s2 empty		: ft=%d | std=%d\n",
// 	ft_strncmp("abc", "", 3), strncmp("abc", "", 3));

// 	printf("T5 both empty:		ft=%d | std=%d\n",
// 	ft_strncmp("", "", 0), strncmp("", "", 0));

// 	printf("T6 unsigned		: ft=%d | std=%d\n",
// 	ft_strncmp("\x80", "\x01", 1), strncmp("\x80", "\x01", 1));

// 	printf("T7 n>len		: ft=%d | std=%d\n",
// 	ft_strncmp("hi", "hi", 100), strncmp("hi", "hi", 100));

// 	printf("T8 nul mid		: ft=%d | std=%d\n",
// 	ft_strncmp("ab\0cd", "ab\0xy", 5), strncmp("ab\0cd", "ab\0xy", 5));

// 	return (0);
// }
