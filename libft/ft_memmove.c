/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memmove.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 09:08:23 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 09:08:23 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_memmove(void *dst, const void *src, size_t len)
{
	unsigned char		*d;
	const unsigned char	*s;
	size_t				i;

	d = (unsigned char *)dst;
	s = (unsigned char *)src;
	i = 0;
	if (len == 0 || d == s)
		return (dst);
	if (d > s)
		i = (len - 1);
	while (len > 0)
	{
		d[i] = s[i];
		if (d > s)
			i--;
		else
			i++;
		len--;
	}
	return (dst);
}
