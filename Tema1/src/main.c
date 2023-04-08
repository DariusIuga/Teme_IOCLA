#include <stdio.h>
#include <stdlib.h>
#include "structs.h"

void changeSensorPriority(sensor *, unsigned int);
void swapSensors(sensor *, sensor *);
void printSensors(sensor *, unsigned int);

int main(int argc, char const *argv[])
{
	// DEBUGGING MODE:

	// argc = 2;
	// argv[1] = "input_sensors.dat";

	// DEBUGGING MODE
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

	sensor *sensors;
	unsigned int nrSensors, i;
	fread(&nrSensors, sizeof(unsigned int), 1, input);

	sensors = (sensor *)malloc(nrSensors * sizeof(sensor));

	for (i = 0; i < nrSensors; i++)
	{
		fread(&sensors[i].sensor_type, sizeof(enum sensor_type), 1, input);

		if (sensors[i].sensor_type == TIRE)
		{
			sensors[i].sensor_data = (tire_sensor *)malloc(sizeof(tire_sensor));
			fread(sensors[i].sensor_data, sizeof(tire_sensor), 1, input);
		}
		else if (sensors[i].sensor_type == PMU)
		{
			sensors[i].sensor_data = (power_management_unit *)malloc(sizeof(power_management_unit));
			fread(sensors[i].sensor_data, sizeof(power_management_unit), 1, input);
		}

		fread(&sensors[i].nr_operations, sizeof(int), 1, input);
		sensors[i].operations_idxs = (int *)malloc(sensors[i].nr_operations * sizeof(int));
		fread(sensors[i].operations_idxs, sizeof(int), sensors[i].nr_operations, input);
	}
	fclose(input);

	changeSensorPriority(sensors, nrSensors);
	printSensors(sensors, nrSensors);

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

void changeSensorPriority(sensor *sensors, unsigned int nrSensors)
{
	unsigned int i, lastPmuIndex = 0;
	for (i = 0; i < nrSensors; ++i)
	{
		if (sensors[i].sensor_type == PMU)
		{
			if (lastPmuIndex != i)
			{
				swapSensors(&sensors[lastPmuIndex], &sensors[i]);
			}
			++lastPmuIndex;
		}
	}
}

void swapSensors(sensor *sensor1, sensor *sensor2)
{
	sensor temp = *sensor1;
	*sensor1 = *sensor2;
	*sensor2 = temp;
}

void printSensors(sensor *sensors, unsigned int nrSensors)
{
	tire_sensor *tire;
	power_management_unit *pmu;
	unsigned int i;
	for (i = 0; i < nrSensors; ++i)
	{
		switch (sensors[i].sensor_type)
		{
		case TIRE:
		{
			tire = (tire_sensor *)sensors[i].sensor_data;

			printf("Tire Sensor\n");
			printf("Pressure: %.2f\n", tire->pressure);
			printf("Temperature: %.2f\n", tire->temperature);
			printf("Wear Level: %d%%\n", tire->wear_level);
			if (tire->performace_score != 0)
			{
				printf("Performance Score: %d\n", tire->performace_score);
			}
			else
			{
				printf("Performance Score: Not Calculated\n");
			}

			break;
		}
		case PMU:
		{
			pmu = (power_management_unit *)sensors[i].sensor_data;

			printf("Power Management Unit\n");
			printf("Voltage: %.2f\n", pmu->voltage);
			printf("Current: %.2f\n", pmu->current);
			printf("Power Consumption: %.2f\n", pmu->power_consumption);
			printf("Energy Regen: %d%%\n", pmu->energy_regen);
			printf("Energy Storage: %d%%\n", pmu->energy_storage);

			break;
		}
		default:
		{
			fprintf(stderr, "Error: Invalid sensor type!\n");
			exit(1);
		}
		}
	}
}
