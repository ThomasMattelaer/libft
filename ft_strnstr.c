/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strnstr.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 08:29:20 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 08:29:20 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"
#include <stdlib.h>

char	*ft_strnstr(const char *big, const char *little, size_t len)
{
	size_t	k;
	size_t	i;
	size_t	little_len;

	if (little[0] == '\0')
		return ((char *)big);
	i = 0;
	little_len = ft_strlen(little);
	while (big[i] && i < len)
	{
		k = 0;
		while (little[k] && little[k] == big[i + k] && (i + k) < len)
		{
			k++;
			if (k == little_len)
				return ((char *)&big[i]);
		}
		i++;
	}
	return (NULL);
}
