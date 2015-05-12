/*
 * test.c
 * Zhaonian Zou
 * Harbin Institute of Technology
 * Jun 22, 2011
 */

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "extmem.h"

#define BLOCK_SIZE 64

typedef struct R_struct {
    int A; // [1, 40]
    int B; // [1, 1000]
} R;

typedef struct S_struct {
    int C; // [20, 60]
    int D; // [1, 1000]
} S;

R gen_R() {
    R newR;
    newR.A = rand() % 40 + 1;
    newR.B = rand() % 1000 + 1;
    return newR;
}

S gen_S() {
    S newS;
    newS.C = rand() % 40 + 20;
    newS.D = rand() % 1000 + 1;
    return newS;
}

int main()
{
    Buffer buf; /* A buffer */
    R *blkR;   /* A pointer to R */
    S *blkS;   /* A pointer to S */
    int i = 0, j = 0;
    unsigned int rDiskBase = 12345678;
    unsigned int sDiskBase = 56781234;
    unsigned int * nextBlockAddr;
    char selection;

    srand((unsigned int)(time(0)));

    /* Initialize the buffer */
    if (!initBuffer(64*8, BLOCK_SIZE, &buf))
    {
        perror("Buffer Initialization Failed!\n");
        return -1;
    }

    for (i = 0; i < 16; i++) {
        blkR = (R *)getNewBlockInBuffer(&buf);
        for (j = 0; j < 7; j++) {
            *(blkR+j) = gen_R();
        }

        nextBlockAddr = (unsigned int *)(blkR + j);
        if(i < 15) {
            *nextBlockAddr = rDiskBase + (i+1)*BLOCK_SIZE;
            *(nextBlockAddr+1) = 0;
        } else {
            *nextBlockAddr = 0;
            *(nextBlockAddr+1) = 0;
        }
        if (writeBlockToDisk((unsigned char *)blkR, rDiskBase + i*BLOCK_SIZE, &buf) != 0)
        {
            perror("Writing Block Failed!\n");
            return -1;
        }
        freeBlockInBuffer((unsigned char *)blkR, &buf);
    }

    for (i = 0; i < 32; i++) {
        blkS = (S *)getNewBlockInBuffer(&buf);
        for (j = 0; j < 7; j++) {
            *(blkS+j) = gen_S();
        }

        nextBlockAddr = (unsigned int *)(blkR + j);
        if(i < 31) {
            *nextBlockAddr = sDiskBase + (i+1)*BLOCK_SIZE;
            *(nextBlockAddr+1) = 0;
        } else {
            *nextBlockAddr = 0;
            *(nextBlockAddr+1) = 0;
        }
        if (writeBlockToDisk((unsigned char *)blkS, sDiskBase + i*BLOCK_SIZE, &buf) != 0)
        {
            perror("Writing Block Failed!\n");
            return -1;
        }
        freeBlockInBuffer((unsigned char *)blkS, &buf);
    }

    while(1) {
        printf("------------------\n");
        printf("请选择操作:\n");
        printf("  1. 关系选择\n");
        printf("  2. 关系投影\n");
        printf("  3. NLJ\n");
        printf("   其他输入直接退出\n");
        printf("------------------\n");
        scanf("%c", &selection);

        if (selection == '1') {
        } else if (selection == '2') {
        } else if (selection == '3') {
        }

        if ((blkR = (R *)readBlockFromDisk(rDiskBase, &buf)) == NULL) {
            perror("Reading Block Failed!\n");
            return -1;
        }
        if ((blkS = (S *)readBlockFromDisk(sDiskBase, &buf)) == NULL) {
            perror("Reading Block Failed!\n");
            return -1;
        }
    }

    return 0;
}

