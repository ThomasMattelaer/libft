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
// #include <stdio.h>
// #include "libft.h"

// int main(void)
// {
//     printf("T1  spaces both sides       : ft='%s' | expected='Hello'\n",
//         ft_strtrim("   Hello   ", " "));
//     printf("T2  x both sides            : ft='%s' | expected='Hello'\n",
//         ft_strtrim("xxxHelloxxx", "x"));
//     printf("T3  empty set no change     : ft='%s' | expected='Hello'\n",
//         ft_strtrim("Hello", ""));
//     printf("T4  empty string            : ft='%s' | expected=''\n",
//         ft_strtrim("", " "));
//     printf("T5  all chars trimmed       : ft='%s' | expected=''\n",
//         ft_strtrim("aaaa", "a"));
//     printf("T6  multi-char set          : ft='%s' | expected='Hello'\n",
//         ft_strtrim("abHelloba", "ab"));
//     printf("T7  set not in string       : ft='%s' | expected='Hello'\n",
//         ft_strtrim("Hello", "xyz"));
//     printf("T8  left side only          : ft='%s' | expected='Hello'\n",
//         ft_strtrim("xxxHello", "xxx"));
//     printf("T9  right side only         : ft='%s' | expected='Hello'\n",
//         ft_strtrim("Helloxxx", "xxx"));
//     printf("T10 single char             : ft='%s' | expected=''\n",
//         ft_strtrim("a", "a"));
//     printf("T11 trim newline and tab    : ft='%s' | expected='Hello'\n",
//         ft_strtrim("\t\nHello\n\t", "\t\n"));
//     printf("T12 only set chars          : ft='%s' | expected=''\n",
//         ft_strtrim("abcabc", "abc"));
//     printf("T13 no trim needed          : ft='%s' | expected='Hello'\n",
//         ft_strtrim("Hello", "xyz"));
//     printf("T14 set longer than string  : ft='%s' | expected=''\n",
//         ft_strtrim("ab", "abcdefgh"));
//     return (0);
// }
