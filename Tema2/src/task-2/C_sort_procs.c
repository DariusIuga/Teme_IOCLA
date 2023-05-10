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
    // Field-ul prio reprezinta prioritatea pe care o are un proces atunci cand acesta ruleaza pe procesor.
    // Fiecare proces are o astfel de prioritate, de la 1 la 5, 1 reprezentand prioritate maxima de rulare, iar 5 reprezentand prioritate minima de rulare.
    int i = 0;
    int swapped = 1;
    proc temp;

    goto start;

swap:
    temp = proc_1;
    proc_1 = proc_2;
    proc_2 = temp;
    swapped = 1;

start:
    if (swapped)
    {
        swapped = 0;
        i = 0;
        goto loop;
    }

    return;

loop:
    if (i < len - 1)
    {
        // Pentru a sorta procesele, stabilim urmatoarele reguli :
        //     1) Procesele trebuie sa apara in ordine crescatoare in functie de prioritate.
        //     2) Pentru procesele cu aceeasi prioritate, acestea se vor ordona crescator in functie de cuanta de timp.
        //     3) Pentru procese cu aceeasi prioritate si cu aceeasi cuanta de timp, acestea vor fi ordonate crescator dupa id.

        if ((procs[i].prio < procs[i + 1].prio) || (procs[i].prio == procs[i + 1].prio && procs[i].time > procs[i + 1].time) ||
            (procs[i].prio == procs[i + 1].prio && procs[i].time == procs[i + 1].time && procs[i].pid > procs[i + 1].pid))
            {
                goto swap;
            }
        i++;
        goto loop;
    }
    else
    {
        goto start;
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
