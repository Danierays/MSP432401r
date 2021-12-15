/**
 * @file main.c
 * @brief Main entry point to the C1M2 Assessment
 *
 * This file contains the main code for the C1M2 assesment. Students
 * are not to change any of the code, they are instead supposed to compile
 * these files with their makefile.
 *
 *
 */
#include "platform.h"
#include "memory.h"

#define MAX_LENGTH (10)
char buffer[MAX_LENGTH];

/* A pretty boring main file */
int main(void) {
  unsigned int i;
  char value;

  /* Code below does some arbitrary memory Reads & writes */
  clear_all(buffer, MAX_LENGTH);
  set_all( ( buffer + 8 ), 43, 2); 
  set_value(buffer, 0, 0x61);
  value = get_value(buffer, 9);
  set_value(buffer, 9, (value + 0x27));
  set_value(buffer, 3, 0x37);
  set_value(buffer, 1, 88);
  set_value(buffer, 4, '2');
  value = get_value(buffer, 1);
  set_value(buffer, 2, 121);
  set_value(buffer, 7, (value - 12));
  set_value(buffer, 5, 0x5F);

  for ( i = 0; i < MAX_LENGTH; i++ ){
    PRINTF("%c", buffer[i]);
  }
  PRINTF("\n");
  return 0;
}

