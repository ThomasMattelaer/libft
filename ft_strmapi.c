/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strmapi.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-09 12:03:30 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-09 12:03:30 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

char	*ft_strmapi(char const *s, char (*f)(unsigned int, char))
{
	char	*res;
	size_t	i;

	if (!s || !f)
		return (NULL);
	res = malloc(sizeof(char) * (ft_strlen(s) + 1));
	if (!res)
		return (NULL);
	i = 0;
	while (s[i])
	{
		res[i] = f(i, s[i]);
		i++;
	}
	res[i] = 0;
	return (res);
}
// static char to_upper(unsigned int i, char c)
// {
//     (void)i;
//     return (c >= 'a' && c <= 'z') ? c - 32 : c;
// }
// #include <stdio.h>
// int main(void)
// {
//     char *r;

//     r = ft_strmapi("hello", to_upper);
//     printf("T1    : ft='%s' | expected='HELLO'\n", r);
//     free(r);

//     r = ft_strmapi("12345", to_upper);
//     printf("T2  digits unchanged        : ft='%s' |
// expected='12345'\n", r);
//     free(r);

//     r = ft_strmapi(NULL, to_upper);
//     printf("T3  NULL s                  : ft='%s' |
// expected='NULL'\n", r ? r : "NULL");

//     r = ft_strmapi("hello", NULL);
//     printf("T4  NULL f     : ft='%s' | expected='NULL'\n", r ? r : "NULL");

//     r = ft_strmapi("HELLO", to_upper);
//     printf("T5  already upper           : ft='%s' | expected='HELLO'\n", r);
//     free(r);

//     r = ft_strmapi("a", to_upper);
//     printf("T6  single char             : ft='%s' | expected='A'\n", r);
//     free(r);

//     return (0);
// }
