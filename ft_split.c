/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 14:32:53 by tmattela          #+#    #+#             */
/*   Updated: 2026/04/14 18:09:22 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int	count_words(char *str, char c)
{
	int	i;
	int	count;

	i = 0;
	count = 0;
	while (str[i])
	{
		if ((str[i] != c && i == 0) || (str[i] != c && str[i - 1] == c))
			count++;
		i++;
	}
	return (count);
}

int	write_split(char **tab, char *str, char c)
{
	int	i;
	int	j;

	i = 0;
	while (str[i])
	{
		if (str[i] == c)
			i++;
		else
		{
			j = 0;
			while (str[i + j] != c && str[i + j])
				j++;
			*tab = malloc(sizeof(char) * (j + 1));
			if (!*tab)
				return (0);
			j = 0;
			while (str[i] != c && str[i])
				(*tab)[j++] = str[i++];
			(*tab)[j] = '\0';
			tab++;
		}
	}
	return (1);
}

char	**ft_split(char const *s, char c)
{
	char	**tab;
	int		words;
	int		success;
	char	**start;

	if (!s)
		return (NULL);
	words = count_words((char *)s, c);
	tab = (char **)malloc(sizeof(char *) * (words + 1));
	if (!tab)
		return (NULL);
	tab[words] = NULL;
	success = write_split(tab, (char *)s, c);
	if (success == 0)
	{
		start = tab;
		while (*tab)
		{
			free((*tab));
			tab++;
		}
		free(start);
		return (NULL);
	}
	return (tab);
}
// #include <stdio.h>
// int main()
// {
// 	char **feur;
// 	feur = ft_split("aaa\0bbbb", '\0');
// 	int i = 0;
// 	while (feur[i])
// 	{
// 		printf("%i: %s\n", i, feur[i]);
// 		free(feur[i++]);
// 	}
// 	printf("%i: %s\n", i, feur[i]);
// 	free(feur);
// }
