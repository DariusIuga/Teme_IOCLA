#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    short quo;
    short remain;
} avg __attribute__((packed));

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

void run_procs(proc *procs, int len, avg *avg_out)
{
    char current = '1';
    char j = 0;
    int i = 0;
    int sum;
    int nr;

    while (i < len)
    {
        sum = 0;
        nr = 0;
        while (procs[i].prio == current)
        {
            sum += procs[i].time;
            nr++;
            i++;
        }
        if (nr == 0)
        {
            avg_out[j].quo = 0;
            avg_out[j].remain = 0;
        }
        else
        {
            avg_out[j].quo = sum / nr;
            avg_out[j].remain = sum % nr;
        }
        current++;
        j++;
    }
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
    avg avg_out[5];

    sort_procs(procs, len);
    run_procs(procs, len, avg_out);

    int i;
    for (i = 0; i < len; i++)
    {
        printf("%d %c %d\n", procs[i].pid, procs[i].prio, procs[i].time);
    }
    for (i = 0; i < 5; i++)
    {
        printf("%d %d\n", avg_out[i].quo, avg_out[i].remain);
    }

    return 0;
}