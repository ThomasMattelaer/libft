/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 11:15:38 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 11:15:38 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strdup(const char *s)
{
	char	*dup;
	size_t	i;

	i = 0;
	dup = malloc(sizeof(char) * (ft_strlen(s) + 1));
	if (!dup)
		return (NULL);
	while (s[i])
	{
		dup[i] = s[i];
		i++;
	}
	dup[i] = '\0';
	return (dup);
}
// #include <stdio.h>
// int	main(void)
// {
// 	char *s;

// 	s = ft_strdup("Hello");
// 	printf("T1 basic               : ft='%s' | expected='Hello'\n", s);

// 	s = ft_strdup("");
// 	printf("T2 empty string        : ft='%s' | expected=''\n", s);

// 	s = ft_strdup("42 Network");
// 	printf("T3 with space          : ft='%s' | expected='42 Network'\n", s);

// 	s = ft_strdup("abcdef");
// 	printf("T4 long string         : ft='%s' | expected='abcdef'\n", s);

// 	s = ft_strdup("a");
// 	printf("T5 single char         : ft='%s' | expected='a'\n", s);

// 	s = ft_strdup("Hello\nWorld");
// 	printf("T6 special chars       : ft='%s' | expected='Hello\nWorld'\n", s);

// 	s = ft_strdup("   ");
// 	printf("T7 spaces              : ft='%s' | expected='   '\n", s);

// 	return (0);
// }
