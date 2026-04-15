/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memchr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 07:46:16 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 07:46:16 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */
#include "libft.h"

void	*ft_memchr(const void *src, int c, size_t n)
{
	unsigned char	*s;
	size_t			i;

	s = (unsigned char *)src;
	i = 0;
	while (i < n)
	{
		if (s[i] == (unsigned char)c)
			return (&s[i]);
		i++;
	}
	return (NULL);
}
// #include <stdio.h>
// #include <string.h>
// int main ()
// {
//    const char str[] = "Tutorialspoint";
//    const char ch = 'a';
//    char *ret;
//    ret = memchr(str, ch, strlen(str));
//    printf("String after |%c| is - |%s|\n", ch, ret);
//    return(0);
// }
