/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strrchr.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 13:29:32 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 13:29:32 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_strrchr(const char *s, int c)
{
	int	i;

	i = (ft_strlen(s));
	while (i >= 0)
	{
		if (s[i] == (char) c)
			return ((char *) &s[i]);
		i--;
	}
	return (NULL);
}
// #include <stdio.h>
// #include <string.h>

// int main(void)
// {
// 	printf("T1 nul mid		: ft=%s\n",
// 	ft_strrchr("ab\0cd", 'c'));

// 	printf("T2 s empty		: ft=%s\n",
// 	ft_strrchr("", 'c'));

// 	printf("T3 c backslash 0		: ft=%s\n",
// 	ft_strrchr("test 42", '\0'));

// 	printf("T4 casual behavior: ft=%s\n",
// 	ft_strrchr("test 42 le boss", 'e'));
// }
