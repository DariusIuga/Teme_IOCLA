#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    short pid;
    char prio;
    short time;
} proc __attribute__((packed));

void swap_procs(proc *proc_1, proc *proc_2)
{
    proc temp = *proc_1;
    *proc_1 = *proc_2;
    *proc_2 = temp;
}

void sort_procs(proc *procs, int len)
{
    int i, j;
    proc temp;
    for (i = 0; i < len; i++)
    {
        for (j = i + 1; j < len; j++)
        {
            // Sortarea proceselor dupa prioritate
            // 1- prioritatea maxima, 5- prioritatea minima
            if (procs[i].prio < procs[j].prio)
            {
                swap_procs(&procs[i], &procs[j]);
            }
            // În caz de prioritate egală, sortare crescătoare după timp
            else if (procs[i].prio == procs[j].prio && procs[i].time > procs[j].time)
            {
                swap_procs(&procs[i], &procs[j]);
            }
            // În caz de prioritate și timp egal, sortare crescătoare după PID
            else if (procs[i].prio == procs[j].prio && procs[i].time == procs[j].time && procs[i].pid > procs[j].pid)
            {
                swap_procs(&procs[i], &procs[j]);
            }
        }
    }
}

int main(void)
{
    // Exemplu de utilizare
    proc procs[] = {
        {1, 'B', 50},
        {2, 'A', 20},
        {3, 'A', 30},
        {4, 'C', 30},
        {5, 'B', 30},
        {6, 'A', 30},
        {7, 'A', 20},
        {8, 'C', 20},
        {9, 'B', 40},
        {10, 'C', 40}};
    int len = sizeof(procs) / sizeof(proc);

    sort_procs(procs, len);

    int i;
    for (i = 0; i < len; i++)
    {
        printf("PID: %d, Prio: %c, Time: %d\n", procs[i].pid, procs[i].prio, procs[i].time);
    }

    return 0;
}
