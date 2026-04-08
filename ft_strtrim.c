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

char	*ft_strtrim(char const *s1, char const *set)
{
	size_t	i;
	size_t	j;
	char	*strim;

	if (!s1 || !set)
		return (NULL);
	strim = malloc(sizeof(char) * (ft_strlen(s1) - ft_strlen(set) + 1));
	if (!strim)
		return (NULL);
	ft_strnstr(s1, set, ft_strlen(set));
	
}
