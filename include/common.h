#ifndef COMMON_H
#define COMMON_H

#include <stdint.h>

/* -------------------------------------------------------------
 * Xtensa LX106 Special Register Numbers (accessed via RSR/WSR)
 * ------------------------------------------------------------- */
#define SR_EPC1     177
#define SR_EPS1     193
#define SR_EXCSAVE1 209
#define SR_SAR      3
#define SR_PS       230
#define SR_VECBASE  231
#define SR_INTENABLE 228
#define SR_INTERRUPT 226

#endif // COMMON_H