#include "libft.h"

void * ft_memset(void *b, int c, size_t len)
{
  unsigned char *ptr;
  unsigned char uc; 

  ptr = b;
  uc = (unsigned char)c; 
  while (len > 0)
  {
    *ptr = uc;
    ptr++; 
    len--;
  }
  return (b);
}