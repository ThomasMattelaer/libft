/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_striteri.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-09 12:24:26 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-09 12:24:26 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_striteri(char *s, void (*f)(unsigned int, char*))
{
	size_t	i;

	i = 0;
	if (!s || !f)
		return ;
	while (s[i])
	{
		f(i, &s[i]);
		i++;
	}
}
// #include <stdio.h>
// void	to_upper(unsigned int i, char *c)
// {
// 	(void)i;
// 	if (*c >= 'a' && *c <= 'z')
// 		*c -= 32;
// }
// int	main(void)
// {
// 	char s1[] = "hello";
// 	ft_striteri(s1, to_upper);
// 	printf("T1 upper               : ft='%s' | expected='HELLO'\n", s1);

// 	char s3[] = "";
// 	ft_striteri(s3, to_upper);
// 	printf("T3 empty string        : ft='%s' | expected=''\n", s3);

// 	char s4[] = "42!";
// 	ft_striteri(s4, to_upper);
// 	printf("T4 non alpha           : ft='%s' | expected='42!'\n", s4);

// 	return (0);
// }
