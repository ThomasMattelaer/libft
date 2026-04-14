/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_bzero.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium>      #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 08:59:34 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 08:59:34 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_bzero(void *s, size_t n)
{
	ft_memset(s, 0, n);
}

// #include <stdio.h>
// #include <strings.h>

// void	print_buffer(unsigned char *buf, size_t n)
// {
// 	size_t	i = 0;

// 	while (i < n)
// 	{
// 		printf("%d ", buf[i]);
// 		i++;
// 	}
// 	printf("\n");
// }

// int	main(void)
// {
// 	unsigned char	buf1[20] = "HelloWorld42Thomas";
// 	unsigned char	buf2[20] = "HelloWorld42Thomas";
// 	size_t			tests[] = {0, 1, 5, 10, 15};
// 	int				i = 0;

// 	while (i < 5)
// 	{
// 		printf("n = %zu\n", tests[i]);
// 		ft_bzero(buf1, tests[i]);
// 		bzero(buf2, tests[i]);
// 		printf("ft_bzero: ");
// 		print_buffer(buf1, 20);
// 		printf("bzero   : ");
// 		print_buffer(buf2, 20);
// 		printf("----\n");
// 		i++;
// 	}
// 	return (0);
// }
