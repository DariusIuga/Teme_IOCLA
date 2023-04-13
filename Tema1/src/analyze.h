extern void get_operations(void **operations);

void analyzeSensor(sensor sensor)
{
    int i;
    void (*operations)(void *);
    get_operations(*operations);

    for (i = 0; i < sensor.nr_operations; i++)
    {
        operations[sensor.operations_idxs[i]](sensor.sensor_data);
    }
}
