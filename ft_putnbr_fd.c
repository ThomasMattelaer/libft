/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_putnbr_fd.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tmattela <tmattela@student.42belgium.com>  #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026-04-09 15:02:49 by tmattela          #+#    #+#             */
/*   Updated: 2026-04-09 15:02:49 by tmattela         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_putnbr_fd(int n, int fd)
{
	int		tab[33];
	int		i;
	long	nbl;

	i = 0;
	nbl = n;
	if (nbl == 0)
	{
		write(fd, "0", 1);
		return ;
	}
	if (nbl < 0)
	{
		write(fd, "-", 1);
		nbl *= -1;
	}
	while (nbl > 0)
	{
		tab[i++] = (nbl % 10) + 48;
		nbl /= 10;
	}
	while (i > 0)
		write(fd, &tab[--i], 1);
}
