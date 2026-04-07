#include "libft.h"

size_t strlcpy(char * restrict dst, const char * restrict src, size_t dstsize)
{
  size_t str_length; 

  if (dstsize == 0)
    return (ft_strlen(dst));
  str_length = ft_strlen(src);
  if (dstsize < src)
    return (str_length + dstsize);
  return (ft_strlen(dst));
}