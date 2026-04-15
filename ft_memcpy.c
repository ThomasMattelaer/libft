/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memcpy.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 09:08:11 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 09:08:11 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_memcpy(void *dst, const void *src, size_t n)
{
	size_t				i;
	unsigned char		*d;
	const unsigned char	*s;

	if (!dst && !src)
		return (NULL);
	d = (unsigned char *)dst;
	s = (unsigned char *)src;
	i = 0;
	if (n == 0)
		return (dst);
	while (i < n)
	{
		d[i] = s[i];
		i++;
	}
	return (dst);
}
// #include <stdio.h>
// #include <string.h>

// int main() {

//     // Initialize a variable
//     int a = 20;
//     int b = 10;

//     printf("Value of b before calling ft_memcpy: %d\n", b);

//     // Use memcpy to copy the value of 'a' into 'b'
//     ft_memcpy(&b, &a, sizeof(int));

//     printf("Value of b after calling ft_memcpy: %d\n", b);

//     return 0;
// }
