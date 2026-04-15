/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlcpy.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 09:08:35 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 09:08:35 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlcpy(char *dst, const char *src, size_t dstsize)
{
	size_t	i;

	i = 0;
	if (dstsize == 0)
		return (ft_strlen(src));
	while (dstsize > 1 && src[i])
	{
		dst[i] = src[i];
		dstsize--;
		i++;
	}
	dst[i] = '\0';
	return (ft_strlen(src));
}
// #include <stdio.h>
// int	main(void)
// {
// 	char	dst1[20];
// 	char	small1[3];

// 	printf("T1 size=0       ");
// 	printf("ft  = %zu\n", ft_strlcpy(dst1, "hello", 0));

// 	printf("T2 size < len(src)      ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "bonjour", 4), dst1);

// 	printf("T3 size = len + 1      ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "test1", 5), dst1);

// 	printf("T4 size > len(src)       ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "salut", 20), dst1);

// 	printf("T5 src vide          ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "", 10), dst1);

// 	printf("T6 petit buffer        ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(small1, "abcdef", 3), small1);

// 	printf("T7 nul au milieu       ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "ab\0cd", 10), dst1);

// 	printf("T8 size = 1         ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "hello", 1), dst1);

// 	printf("T9 copie classique         ");
// 	printf("ft  = %zu | dst = %s\n", ft_strlcpy(dst1, "42 Network", 20), dst1);
// }
