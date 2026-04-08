/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 14:32:53 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 14:32:53 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

int	count_words(char *str, char c)
{
	int	i;
	int	count;

	i = 0;
	count = 0;
	while(str[i])
	{
		if(str[i] == c || (str[i] != c && i == 0))
			count++;
		i++;
	}
	return (count);
}

void	write_split(char **tab, char *str, char c)
{
	int	i;
	int	j;
	int	word;

	while(str[i])
	{
		if(str[i] == c)
			i++;
		else
		{
			j = 0;
			while(str[i + j] != c && str[i + j])
				j++;
			tab[word] = malloc(sizeof(char) * (j + 1));
			if (!tab[word])
				return (NULL);
			j = 0;
			while(str[i] != c && str[i])
				tab[word][j++] = str[i++];
			tab[word][j] = '\0';
			word++;
		}
	}
}

char	**ft_split(char const *s, char c)
{
	char	**tab;
	int		words;

	if(!s || !c)
		return (NULL);
	words = count_words(s, c);
	tab = (char **)malloc(sizeof(char *) * (words + 1));
	if(!tab)
		return (NULL);
	tab[words] = 0;
	write_split(tab, s, c);
	return (tab);
}
