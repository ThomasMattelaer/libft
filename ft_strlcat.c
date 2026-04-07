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
	if (size == 0)
		return (dst_length + ft_strlen(src));
	if (dst_length >= size)
		return (size + ft_strlen(src));
	while (src[i] && (dst_length + i) < size - 1)
	{
		dst[dst_length + i] = src[i];
		i++;
	}
	dst[dst_length + i] = '\0';
	return (dst_length + ft_strlen(src));
}
