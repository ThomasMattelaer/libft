/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlcat.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 10:35:22 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 10:35:22 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

size_t	ft_strlcat(char *dst, const char *src, size_t size)
{
	size_t	i;
	size_t	dst_length;

	i = 0;
	dst_length = ft_strlen(dst);
	if (dst_length >= size)
		return (size + ft_strlen(src));
	if (size == 0)
		return (dst_length + ft_strlen(src));
	while (src[i] && (dst_length + i) < size - 1)
	{
		dst[dst_length + i] = src[i];
		i++;
	}
	dst[dst_length + i] = '\0';
	return (dst_length + ft_strlen(src));
}
// #include <stdio.h>
// #include <string.h>

// int	main(void)
// {
// 	char b1[20];

// 	ft_strlcpy(b1, "Hello", 20);
// 	printf("T1 size=0              : ft=%zu | expected=5\n",
// 		ft_strlcat(b1, "World", 0));

// 	ft_strlcpy(b1, "Bonjour", 20);
// 	printf("T2 size < dst_len      : ft=%zu | expected=5\n",
// 		ft_strlcat(b1, "XX", 3));

// 	ft_strlcpy(b1, "Hi", 20);
// 	printf("T3 size == dst_len     : ft=%zu | expected=4\n",
// 		ft_strlcat(b1, "42", 2));

// 	ft_strlcpy(b1, "Hello ", 20);
// 	printf("T4 concat normale      : ft=%zu | expected=11\n",
// 		ft_strlcat(b1, "World", 20));

// 	ft_strlcpy(b1, "Hi", 20);
// 	printf("T5 buffer limite       : ft=%zu | expected=5\n",
// 		ft_strlcat(b1, "123", 5));

// 	ft_strlcpy(b1, "Test", 20);
// 	printf("T6 src vide            : ft=%zu | expected=4\n",
// 		ft_strlcat(b1, "", 10));

// 	b1[0] = '\0';
// 	printf("T7 dst vide            : ft=%zu | expected=3\n",
// 		ft_strlcat(b1, "abc", 10));

// 	ft_strlcpy(b1, "A", 20);
// 	printf("T8 size = 1            : ft=%zu | expected=2\n",
// 		ft_strlcat(b1, "B", 1));

// 	ft_strlcpy(b1, "Start ", 20);
// 	printf("T9 grosse troncature   : ft=%zu | expected=32\n",
// 		ft_strlcat(b1, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 20));

// 	return (0);
// }
