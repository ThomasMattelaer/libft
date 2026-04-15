/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memcmp.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 08:20:57 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 08:20:57 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

int	ft_memcmp(const void *src1, const void *src2, size_t n)
{
	size_t			i;
	unsigned char	*s1;
	unsigned char	*s2;

	s1 = (unsigned char *)src1;
	s2 = (unsigned char *)src2;
	i = 0;
	while (i < n && s1[i] == s2[i])
		i++;
	if (i == n)
		return (0);
	return ((int)(s1[i] - s2[i]));
}
// #include <stdio.h>
// #include <string.h>

// int main() {
//     int res = 0;
//     char s1[10] = "geeks";
//     char s2[10] = "greeks";

//     res = ft_memcmp(s1, s2, strlen(s1));

//     if (res > 0)
//         printf("s1 is greater");
//     else if (res < 0)
//         printf("s2 is greater");
//     else
//         printf("both are equal");

//     return 0;
// }
