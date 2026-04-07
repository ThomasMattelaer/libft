#include "libft.h"

void *ft_memcpy (void *restrict dst, const void *restrict src, size_t n)
{ 
  int i; 
  unsigned char *d;
  unsigned char *s;

  d = dst; 
  s = src; 
  i = 0; 
  if(n == 0)
    return (dst); 
  while(n > 0)
  {
    d[i] = s[i];
    n--; 
    i++; 
  }
  return(dst); 
}