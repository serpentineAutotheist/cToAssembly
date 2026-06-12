#include <stdio.h>

// Prototype
void fc_table(int upper, int lower, int step); 
void fc_table_optimized(int upper, int lower, int step);

int main() {
    fc_table(300, 0, 10); // Optimization Level 2
    printf("\n\n");
    printf("GCC Optimization Level 1");
    fc_table_optimized(300,0,10); // Optimization Level 3
    return 0;
}

__attribute__((optimize("O2")))
void fc_table(int upper, int lower, int step) {
    float fahr, celsius;
    fahr = lower;
    printf("Fahrenheit - Celsius Conversion Chart\n");
    while (fahr <= upper) {
        printf("%3.0fF - %6.1fC\n", fahr, (5.0/9.0)*(fahr-32));
        fahr += step;
    }
}

__attribute__((optimize("O3")))
void fc_table_optimized(int upper, int lower, int step) {
    float fahr, celsius;
    fahr = lower;
    printf("Fahrenheit - Celsius Conversion Chart\n");
    while (fahr <= upper) {
        printf("%3.0fF - %6.1fC\n", fahr, (5.0/9.0)*(fahr-32));
        fahr += step;
    }
}
