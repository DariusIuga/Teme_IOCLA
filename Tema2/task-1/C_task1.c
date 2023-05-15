#include <stdio.h>
#include <stdlib.h>

void simple(int len, char *plain, char *enc_string, int step)
{
    int i = 0;
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
}

int main(void)
{
    int len = 25;
    char *plain = (char *)malloc(len * sizeof(char));
    char *enc_string = (char *)malloc(len * sizeof(char));
    int step = 15;

    plain = "THYROPARATHYROIDECTOMIZED";

    simple(len, plain, enc_string, step);

    return 0;
}