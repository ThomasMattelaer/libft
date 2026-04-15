/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strjoin.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 13:46:41 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 13:46:41 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_strjoin(char const *s1, char const *s2)
{
	char	*sjoin;
	size_t	i;
	size_t	j;

	i = 0;
	j = 0;
	if (!s1 || !s2)
		return (NULL);
	sjoin = malloc(sizeof(char) * (ft_strlen(s1) + ft_strlen(s2) + 1));
	if (!sjoin)
		return (NULL);
	while (s1[i])
	{
		sjoin[j++] = s1[i];
		i++;
	}
	i = 0;
	while (s2[i])
	{
		sjoin[j++] = s2[i];
		i++;
	}
	sjoin[j] = '\0';
	return (sjoin);
}
// #include <stdio.h>
// int	main(void)
// {
// 	printf("T1 basic join           : ft='%s' | expected='HelloWorld'\n",
// 		ft_strjoin("Hello", "World"));

// 	printf("T2 with space           : ft='%s' | expected='Hello World'\n",
// 		ft_strjoin("Hello ", "World"));

// 	printf("T3 s1 empty             : ft='%s' | expected='World'\n",
// 		ft_strjoin("", "World"));

// 	printf("T4 s2 empty             : ft='%s' | expected='Hello'\n",
// 		ft_strjoin("Hello", ""));

// 	printf("T5 both empty           : ft='%s' | expected=''\n",
// 		ft_strjoin("", ""));

// 	printf("T6 long strings         : ft='%s' | expected='abcdef123456'\n",
// 		ft_strjoin("abcdef", "123456"));

// 	printf("T7 single char          : ft='%s' | expected='ab'\n",
// 		ft_strjoin("a", "b"));

// 	printf("T8 special chars        : ft='%s' | expected='Hello\nWorld'\n",
// 		ft_strjoin("Hello\n", "World"));

// 	printf("T9 spaces               : ft='%s' | expected='   42'\n",
// 		ft_strjoin("   ", "42"));

// 	printf("T10 numbers             : ft='%s' | expected='123456'\n",
// 		ft_strjoin("123", "456"));

// 	return (0);
// }
