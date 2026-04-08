/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strjoin.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 13:46:41 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 13:46:41 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_strjoin(char const *s1, char const *s2)
{
	char	*sjoin;
	size_t	i;
	size_t	j;

	i = 0;
	j = 0;
	if (!s1 || !s2)
		return (NULL);
	sjoin = malloc(sizeof(char) * (ft_strlen(s1) + ft_strlen(s2) + 1));
	if (!sjoin)
		return (NULL);
	while (s1[i])
	{
		sjoin[j++] = s1[i];
		i++;
	}
	i = 0;
	while (s2[i])
	{
		sjoin[j++] = s2[i];
		i++;
	}
	sjoin[j] = '\0';
	return (sjoin);
}
