#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "structs.h"

#define BUF_LENGTH 20
#define p_m_u power_management_unit
#define NR_OPS sensors[i].nr_operations
#define OPS_IDXS sensors[i].operations_idxs

extern void get_operations(void **operations);

void changeSensorPriority(sensor *sensors, int nrSensors);
void swapSensors(sensor *sensor1, sensor *sensor2);
void printSensor(sensor sensor);
void analyzeSensor(sensor sensor);
bool isInvalid(sensor sensor);
void clearSensors(sensor **sensors, int *nrSensors);

int main(int argc, char const *argv[])
{
	if (argc < 2)
	{
		fprintf(stderr, "Provide a binary file as a parameter!\n");
		return 1;
	}

	FILE *input = fopen(argv[1], "rb");
	if (input == NULL)
	{
		fprintf(stderr, "Error: Can't open binary input file!\n");
		return 1;
	}

	sensor *sensors;
	int nrSensors, i;
	char line[BUF_LENGTH], *token;

	fread(&nrSensors, sizeof(int), 1, input);

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
			sensors[i].sensor_data = (p_m_u *)malloc(sizeof(p_m_u));
			fread(sensors[i].sensor_data, sizeof(p_m_u), 1, input);
		}

		fread(&NR_OPS, sizeof(int), 1, input);
		OPS_IDXS = (int *)malloc(NR_OPS * sizeof(int));
		fread(OPS_IDXS, sizeof(int), NR_OPS, input);
	}
	fclose(input);

	changeSensorPriority(sensors, nrSensors);

	// Input from terminal
	if (fgets(line, BUF_LENGTH, stdin) == NULL)
	{
		fprintf(stderr, "Eroare la citirea liniei din terminal\n");
	}
	while (1)
	{
		token = strtok(line, " \n");

		if (strcmp(token, "print") == 0)
		{
			token = strtok(NULL, "\n");
			i = atoi(token);
			if (i < 0 || i > nrSensors - 1)
			{
				printf("Index not in range!\n");
			}
			else
			{
				printSensor(sensors[i]);
			}
		}
		else if (strcmp(token, "analyze") == 0)
		{
			token = strtok(NULL, "\n");
			i = atoi(token);
			if (i < 0 || i > nrSensors - 1)
			{
				printf("Index not in range!\n");
			}
			else
			{
				analyzeSensor(sensors[i]);
			}
		}
		else if (strcmp(token, "clear") == 0)
		{
			clearSensors(&sensors, &nrSensors);
		}
		else if (strcmp(token, "exit") == 0)
		{
			for (i = 0; i < nrSensors; i++)
			{
				free(sensors[i].sensor_data);
				free(sensors[i].operations_idxs);
			}
			free(sensors);
			break;
		}

		fgets(line, BUF_LENGTH, stdin);
	}

	return 0;
}

void changeSensorPriority(sensor *sensors, int nrSensors)
{
	int i, j, pmuIndex = 0;
	for (i = 0; i < nrSensors; ++i)
	{
		if (sensors[i].sensor_type == PMU)
		{
			for (j = i; j > pmuIndex; --j)
			{
				swapSensors(&sensors[j], &sensors[j - 1]);
			}
			++pmuIndex;
		}
	}
}

void swapSensors(sensor *sensor1, sensor *sensor2)
{
	sensor temp = *sensor1;
	*sensor1 = *sensor2;
	*sensor2 = temp;
}

void printSensor(sensor sensor)
{
	tire_sensor *tire;
	p_m_u *pmu;
	switch (sensor.sensor_type)
	{
	case TIRE:
	{
		tire = (tire_sensor *)sensor.sensor_data;

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
		pmu = (p_m_u *)sensor.sensor_data;

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

void analyzeSensor(sensor sensor)
{
	int i;
	void (*operations[8])(void *);

	get_operations((void **)operations);

	for (i = 0; i < sensor.nr_operations; i++)
	{
		operations[sensor.operations_idxs[i]](sensor.sensor_data);
	}
}

bool isInvalid(sensor sensor)
{
	tire_sensor *tire;
	p_m_u *pmu;
	switch (sensor.sensor_type)
	{
	case TIRE:
	{
		tire = (tire_sensor *)sensor.sensor_data;
		if (tire->pressure < 19 || tire->pressure > 28)
		{
			return true;
		}
		if (tire->temperature < 0 || tire->temperature > 120)
		{
			return true;
		}
		if (tire->wear_level < 0 || tire->wear_level > 100)
		{
			return true;
		}
		break;
	}
	case PMU:
	{
		pmu = (p_m_u *)sensor.sensor_data;
		if (pmu->voltage < 10 || pmu->voltage > 20)
		{
			return true;
		}
		if (pmu->current < -100 || pmu->current > 100)
		{
			return true;
		}
		if (pmu->power_consumption < 0 || pmu->power_consumption > 1000)
		{
			return true;
		}
		if (pmu->energy_regen < 0 || pmu->energy_regen > 100)
		{
			return true;
		}
		if (pmu->energy_storage < 0 || pmu->energy_storage > 100)
		{
			return true;
		}
		break;
	}
	default:
	{
		fprintf(stderr, "Error: Invalid sensor type!\n");
		exit(1);
		return true;
	}
	}

	return false;
}

void clearSensors(sensor **sensors, int *nrSensors)
{
	int i, newSize = 0;
	for (i = 0; i < *nrSensors; ++i)
	{
		if (isInvalid((*sensors)[i]))
		{
			free((*sensors)[i].sensor_data);
			free((*sensors)[i].operations_idxs);
		}
		else
		{
			(*sensors)[newSize++] = (*sensors)[i];
		}
	}

	*nrSensors = newSize;

	sensor *new = (sensor *)realloc(*sensors, *nrSensors * sizeof(sensor));
	if (new == NULL)
	{
		printf("Error: failed to reallocate memory\n");
		exit(1);
	}
	*sensors = new;
}
