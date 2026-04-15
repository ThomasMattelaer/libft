/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strnstr.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 08:29:20 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 08:29:20 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_strnstr(const char *big, const char *little, size_t len)
{
	size_t	k;
	size_t	i;
	size_t	little_len;

	if (little[0] == '\0')
		return ((char *)big);
	i = 0;
	little_len = ft_strlen(little);
	while (big[i] && i < len)
	{
		k = 0;
		while (little[k] && little[k] == big[i + k] && (i + k) < len)
		{
			k++;
			if (k == little_len)
				return ((char *)&big[i]);
		}
		i++;
	}
	return (NULL);
}
// #include <stdio.h>
// #include <string.h>

// int main(void)
// {
// 	printf("T1 n=0		: ft=%s\n",
// 	ft_strnstr("bonjour, comment ca va ?", "co", 0));

// 	printf("T2 little is backslash 0		: ft=%s\n",
// 	ft_strnstr("bonjour, comment ca va ? ", "\0", 3));

// 	printf("T3 s1 empty		: ft=%s\n",
// 	ft_strnstr("", "abc", 3));

// 	printf("T4 s2 empty		: ft=%s\n",
// 	ft_strnstr("abc", "", 3));

// 	printf("T5 both empty:		ft=%s\n",
// 	ft_strnstr("", "", 0));

// 	printf("T6 unsigned		: ft=%s\n",
// 	ft_strnstr("\x80", "\x01", 1));

// 	printf("T7 n>len		: ft=%s\n",
// 	ft_strnstr("hi", "hi", 100));

// 	printf("T8 nul mid		: ft=%s\n",
// 	ft_strnstr("ab\0cd", "cd", 5));

// 	printf("T9 classic behaviour		: ft=%s\n",
// 	ft_strnstr("Hello les frerots", "les", 15));

// 	return (0);
// }
