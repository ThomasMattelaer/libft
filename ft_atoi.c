/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 10:17:53 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 10:17:53 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"
#include <limits.h>

int	ft_atoi(const char *nptr)
{
	size_t	i;
	long	nb;
	int		minus;

	i = 0;
	nb = 0;
	minus = 1;
	while (nptr[i] == ' ' || (nptr[i] >= 9 && nptr[i] <= 13))
		i++;
	if (nptr[i] == '+' || nptr[i] == '-')
	{
		if (nptr[i] == '-')
			minus *= -1;
		i++;
	}
	while (nptr[i] >= '0' && nptr[i] <= '9')
	{
		if (nb > (nb * 10) + (nptr[i] - '0') && minus == 1)
			return ((int)LONG_MAX);
		if (nb > (nb * 10) + (nptr[i] - '0') && minus == -1)
			return ((int)LONG_MIN);
		nb = (nb * 10) + (nptr[i] - '0');
		i++;
	}
	return ((int)(nb * minus));
}
// #include <stdio.h>

// int	main(void)
// {
// 	char	*tests[] = {
// 		"42",
// 		"   42",
// 		"   -42",
// 		"+42",
// 		"--42",
// 		"++42",
// 		"  +--+1234ab567",
// 		"2147483647",
// 		"-2147483648",
// 		"2147483648",
// 		"-2147483649",
// 		"abc",
// 		"9999999999999999999",
// 		"",
// 		NULL
// 	};
// 	int	i = 0;

// 	while (tests[i])
// 	{
// 		printf("input: \"%s\"\n", tests[i]);
// 		printf("atoi: %d\n", atoi(tests[i]));
// 		printf("ft_atoi: %d\n", ft_atoi(tests[i]));
// 		printf("----\n");
// 		i++;
// 	}
// 	return (0);
// }
