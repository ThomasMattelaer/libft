/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_calloc.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-08 10:44:03 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-08 10:44:03 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_calloc(size_t nmemb, size_t size)
{
	void	*ptr;

	if (size != 0 && ((nmemb * size) / size) != nmemb)
		return (NULL);
	ptr = malloc(nmemb * size);
	if (!ptr)
		return (NULL);
	ft_bzero(ptr, nmemb * size);
	return (ptr);
}
// #include <stdio.h>

// int	main(void)
// {
// 	size_t	n = 0;
// 	size_t	size = 1;
// 	int		i = 0;

// 	while (i < 5)
// 	{
// 		printf("test %d (n=%zu, size=%zu)\n", i, n, size);

// 		char *p1 = ft_calloc(n, size);
// 		char *p2 = calloc(n, size);

// 		printf("ft_calloc : ");
// 		for (size_t j = 0; j < n * size; j++)
// 			printf("%d ", p1 ? p1[j] : -1);
// 		printf("\n");

// 		printf("calloc    : ");
// 		for (size_t j = 0; j < n * size; j++)
// 			printf("%d ", p2 ? p2[j] : -1);
// 		printf("\n");

// 		printf("----\n");

// 		free(p1);
// 		free(p2);

// 		n++;
// 		i++;
// 	}
// 	return (0);
// }
