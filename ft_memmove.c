#include "libft.h"

void *ft_memmove(void *dst, const void *src, size_t len)
{
    unsigned char *d; 
    unsigned char *s;
    int i; 

    d = dst; 
    s = src; 
    if (len == 0 || d == s)
      return (dst); 
    if (d>s)
    {
      i = (len - 1);
      while(len > 0)
      {
        d[i] = s[i]; 
        i--;
        len--; 
      }
    }
    else
    {
      i = 0; 
      while(len > 0)
      {
        d[i] = s[i]; 
        i++;
        len--; 
      } 
    }
    return (dst); 
}