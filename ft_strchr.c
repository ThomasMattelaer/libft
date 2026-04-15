/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strchr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 11:21:42 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 11:21:42 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_strchr(const char *s, int c)
{
	int	i;

	i = 0;
	while (s[i])
	{
		if (s[i] == (unsigned char) c)
			return ((char *) &s[i]);
		i++;
	}
	if ((unsigned char) c == '\0')
		return ((char *) &s[i]);
	return (NULL);
}
// #include <stdio.h>
// #include <string.h>

// int main(void)
// {
// 	printf("T1 nul mid		: ft=%s\n",
// 	ft_strchr("ab\0cd", 'c'));

// 	printf("T2 s empty		: ft=%s\n",
// 	ft_strchr("", 'c'));

// 	printf("T3 c backslash 0		: ft=%s\n",
// 	ft_strchr("test 42", '\0'));

// 	printf("T4 casual behavior: ft=%s\n",
// 	ft_strchr("test 42 le boss", 'e'));
// }
