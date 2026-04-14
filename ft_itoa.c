/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_itoa.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-09 08:29:05 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-09 08:29:05 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static	int	int_len(long nb)
{
	int	count;

	count = 0;
	if (nb < 0)
	{
		count++;
		nb *= -1;
	}
	if (nb == 0)
		count++;
	while (nb != 0)
	{
		nb /= 10;
		count++;
	}
	return (count);
}

char	*ft_itoa(int n)
{
	long	nb;
	char	*str;
	int		len;

	nb = n;
	len = int_len(nb);
	str = malloc(sizeof(char) * (len + 1));
	if (!str)
		return (NULL);
	if (nb < 0)
	{
		str[0] = '-';
		nb *= -1;
	}
	str[len] = 0;
	len = len - 1;
	if (nb == 0)
		str[0] = '0';
	while (nb != 0)
	{
		str[len] = (nb % 10) + '0';
		nb /= 10;
		len--;
	}
	return (str);
}
// #include <stdio.h>

// int	main(void)
// {
// 	int	tests[] = {0, 1, -1, 42, -42, 2147483647, -2147483648, 9999999};
// 	int	i = 0;

// 	while (i < 8)
// 	{
// 		int n = tests[i];
// 		char *s1 = ft_itoa(n);
// 		char *s2 = malloc(50);

// 		sprintf(s2, "%d", n);
// 		printf("n = %d\n", n);
// 		printf("ft_itoa : %s\n", s1);
// 		printf("itoa    : %s\n", s2);
// 		printf("----\n");

// 		free(s1);
// 		free(s2);

// 		i++;
// 	}
// 	return (0);
// }
