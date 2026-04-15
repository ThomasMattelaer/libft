/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_substr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 13:22:28 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 13:22:28 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

char	*ft_substr(char const *s, unsigned int start, size_t len)
{
	char	*sub;
	size_t	i;
	size_t	s_len;

	i = 0;
	s_len = ft_strlen(s);
	if (!s)
		return (NULL);
	if (start > s_len)
		return (ft_strdup(""));
	if (len > (s_len - start))
		len = (s_len - start);
	sub = malloc(sizeof(char) * (len +1));
	if (!sub)
		return (NULL);
	while (s[start + i] && i < len)
	{
		sub[i] = s[start + i];
		i++;
	}
	sub[i] = '\0';
	return (sub);
}
// #include <stdio.h>

// int main(void)
// {
// 	char *s;

// 	s = ft_substr("tripouille", 1, 1);
// 	printf("result substring: %s\n", s);
// 	return (0);
// }
