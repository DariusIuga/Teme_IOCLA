#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    short pid;
    char prio;
    short time;
} proc __attribute__((packed));

void sort_procs(proc *procs, int len)
{
    int i = 0, j;
    proc temp;
loop1:
    if (i >= len)
    {
        return;
    }

    j = i + 1;
loop2:
    if (j >= len)
    {
        i++;
        goto loop1;
    }

    if (procs[i].prio > procs[j].prio)
    {
        goto swap;
    }
    else if (procs[i].prio == procs[j].prio && procs[i].time > procs[j].time)
    {
        goto swap;
    }
    else if (procs[i].prio == procs[j].prio && procs[i].time == procs[j].time && procs[i].pid > procs[j].pid)
    {
        goto swap;
    }

next:
    j++;
    goto loop2;
    return;
swap:
    temp = procs[i];
    procs[i] = procs[j];
    procs[j] = temp;
    goto next;
}

int main(void)
{
    // Exemplu de utilizare
    proc procs[] = {
        {28, '3', 16},
        {54, '3', 16},
        {34, '2', 49},
        {53, '1', 51},
        {63, '5', 50},
        {21, '5', 60},
        {58, '2', 39},
        {37, '1', 41},
        {64, '1', 14},
        {36, '5', 56},
        {51, '3', 11},
        {40, '5', 10},
        {99, '2', 57}};
    int len = sizeof(procs) / sizeof(proc);

    sort_procs(procs, len);

    int i;
    for (i = 0; i < len; i++)
    {
        printf("%d %c %d\n", procs[i].pid, procs[i].prio, procs[i].time);
    }

    return 0;
}