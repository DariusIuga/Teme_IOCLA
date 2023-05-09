#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    int len = 10;
    char *plain = (char *)malloc(len * sizeof(char));
    char *enc_string = (char *)malloc(len * sizeof(char));
    int step = 25;
    int i = 0;

    plain = "ZZZZZZZZZZ";

loop:
    if (i >= len)
    {
        goto done;
    }
    enc_string[i] = plain[i] + step;
    if (enc_string[i] > 'Z')
    {
        enc_string[i] -= 26;
    }
    ++i;
    goto loop;

done:
    printf("%s\n", enc_string);

    return 0;
}