#include <stdio.h>
#include <stdlib.h>
#include "structs.h"

int main(int argc, char const *argv[])
{
	if (argc < 2)
	{
		fprintf(stderr, "Please provide the name of a binary file as a parameter!\n");
		return 1;
	}

	FILE *input = fopen(argv[1], "rb");
	if (input == NULL)
	{
		fprintf(stderr, "Error: Can't open binary input file!\n");
		return 1;
	}

	unsigned int nrSensors, i;
	fread(&nrSensors, sizeof(unsigned int), 1, input);

	sensor *sensors = (sensor *)malloc(nrSensors * sizeof(sensor));

	for (i = 0; i < nrSensors; i++)
	{
		fread(&sensors[i].sensor_type, sizeof(enum sensor_type), 1, input);

		if (sensors[i].sensor_type == TIRE)
		{
			fread(sensors[i].sensor_data, sizeof(tire_sensor), 1, input);
		}
		else if (sensors[i].sensor_type == PMU)
		{
			fread(sensors[i].sensor_data, sizeof(power_management_unit), 1, input);
		}

		fread(&sensors[i].nr_operations, sizeof(int), 1, input);
		sensors[i].operations_idxs = (int *)malloc(sensors[i].nr_operations * sizeof(int));
		fread(sensors[i].operations_idxs, sizeof(int), sensors[i].nr_operations, input);
	}

	fclose(input);

	// Use the sensor data here

	// Free the memory allocated for the sensor data

	for (i = 0; i < nrSensors; i++)
	{
		free(sensors[i].sensor_data);
		free(sensors[i].operations_idxs);
	}
	free(sensors);

	return 0;
}
