/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strtrim.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 14:01:38 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 14:01:38 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

static char	*create_strim(char *strim, const char *s1, size_t start, size_t end)
{
	size_t	i;

	i = 0;
	while ((end - start) >= i)
	{
		strim[i] = s1[start + i];
		i++;
	}
	strim[i] = '\0';
	return (strim);
}

char	*ft_strtrim(char const *s1, char const *set)
{
	size_t	start;
	size_t	end;
	char	*strim;

	if (!s1 || !set)
		return (NULL);
	start = 0;
	while (ft_strchr(set, s1[start]))
		start++;
	end = ft_strlen(s1) - 1;
	while (ft_strchr(set, s1[end]) && end > 0)
		end--;
	if (end < start || ft_strlen(s1) == 0)
		return (ft_strdup(""));
	strim = malloc(sizeof(char) * (end - start + 2));
	if (!strim)
		return (NULL);
	strim = create_strim(strim, s1, start, end);
	return (strim);
}
