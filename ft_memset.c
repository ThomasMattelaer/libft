/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_memset.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-07 09:08:29 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-07 09:08:29 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_memset(void *b, int c, size_t len)
{
	unsigned char	*ptr;
	unsigned char	uc;
	size_t			i;

	i = 0;
	ptr = b;
	uc = (unsigned char)c;
	while (i < len)
	{
		ptr[i] = uc;
		i++;
	}
	return (b);
}
// #include <stdio.h>
// #include <string.h>

// int main()
// {
//     char str[50] = "GeeksForGeeks is for programming geeks.";
//     printf("\nBefore memset(): %s\n", str);

//     // Fill 8 characters starting from str[13] with '.'
//     ft_memset(str + 13, '.', 8*sizeof(char));

//     printf("After memset():  %s", str);
//     return 0;
// }
