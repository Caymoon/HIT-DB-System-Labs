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
    newS.C = rand() % 41 + 20;
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
    unsigned int r1Base = 3456;
    unsigned int r2Base = 100000;
    unsigned int r3Base = 800000;

    unsigned int * nextBlockPtr;
    unsigned int nextBlockAddr;
    unsigned char * blk;
    char selection;
    int temp;
    int block_usage = 0;

    srand((unsigned int)(time(0)));

    /* Initialize the buffer */
    if (!initBuffer((BLOCK_SIZE+1)*8, BLOCK_SIZE, &buf))
    {
        perror("Buffer Initialization Failed!\n");
        return -1;
    }

    for (i = 0; i < 16; i++) {
        blkR = (R *)getNewBlockInBuffer(&buf);
        for (j = 0; j < 7; j++) {
            *(blkR+j) = gen_R();
        }

        nextBlockPtr = (unsigned int *)(blkR + j);
        if(i < 15) {
            *nextBlockPtr = rDiskBase + (i+1)*BLOCK_SIZE;
            *(nextBlockPtr+1) = 0;
        } else {
            *nextBlockPtr = 0;
            *(nextBlockPtr+1) = 0;
        }
        if (writeBlockToDisk((unsigned char *)blkR, rDiskBase + i*BLOCK_SIZE, &buf) != 0)
        {
            perror("Writing Block Failed!\n");
            return -1;
        }
    }

    for (i = 0; i < 32; i++) {
        blkS = (S *)getNewBlockInBuffer(&buf);
        for (j = 0; j < 7; j++) {
            *(blkS+j) = gen_S();
        }

        nextBlockPtr = (unsigned int *)(blkS + j);
        if(i < 31) {
            *nextBlockPtr = sDiskBase + (i+1)*BLOCK_SIZE;
            *(nextBlockPtr+1) = 0;
        } else {
            *nextBlockPtr = 0;
            *(nextBlockPtr+1) = 0;
        }
        if (writeBlockToDisk((unsigned char *)blkS, sDiskBase + i*BLOCK_SIZE, &buf) != 0)
        {
            perror("Writing Block Failed!\n");
            return -1;
        }
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
            /*关系选择算法 选出R.A=40或S.C=60的元组*/
            blk = getNewBlockInBuffer(&buf);
            block_usage = 0;
            for(i = 0; i < 16; i++) {
                if ((blkR = (R *)readBlockFromDisk(rDiskBase + i*BLOCK_SIZE, &buf)) == NULL) {
                    perror("Reading Block Failed!\n");
                    return -1;
                }
                for (j = 0; j < 7; j++) {
                    temp = blkR[j].A;
                    if (temp == 40) {
                        printf("%d\t%d\n", blkR[j].A, blkR[j].B);
                        if(block_usage == BLOCK_SIZE-8) {
                            *(unsigned int *)(blk+block_usage) = r1Base + BLOCK_SIZE;
                            *(unsigned int *)(blk+block_usage+sizeof(int)) = 0;
                            if (writeBlockToDisk(blk, r1Base, &buf) != 0)
                            {
                                perror("Writing Block Failed!\n");
                                return -1;
                            }
                            r1Base += BLOCK_SIZE;
                            blk = getNewBlockInBuffer(&buf);
                            block_usage = 0;
                        }
                        *(R *)(blk+block_usage) = blkR[j];
                        block_usage += sizeof(R);
                    }
                }
                freeBlockInBuffer((unsigned char * )blkR, &buf);
            }
            for (i = 0; i < 32; i++) {
                if ((blkS = (S *)readBlockFromDisk(sDiskBase + i*BLOCK_SIZE, &buf)) == NULL) {
                    perror("Reading Block Failed!\n");
                    return -1;
                }
                for (j = 0; j < 7; j++) {
                    temp = blkS[j].C;
                    if (temp == 60) {
                        printf("%d\t%d\n", blkS[j].C, blkS[j].D);
                        if(block_usage == BLOCK_SIZE-8) {
                            *(unsigned int *)(blk+block_usage) = r1Base + BLOCK_SIZE;
                            *(unsigned int *)(blk+block_usage+sizeof(int)) = 0;
                            if (writeBlockToDisk(blk, r1Base, &buf) != 0)
                            {
                                perror("Writing Block Failed!\n");
                                return -1;
                            }
                            r1Base += BLOCK_SIZE;
                            blk = getNewBlockInBuffer(&buf);
                            block_usage = 0;
                        }
                        *(S *)(blk+block_usage) = blkS[j];
                        block_usage += sizeof(S);
                    }
                }
                freeBlockInBuffer((unsigned char * )blkS, &buf);
            }
            // 剩余部分写入文件
            while(block_usage < BLOCK_SIZE-4) {
                *(unsigned int *)(blk+block_usage) = 0;
                block_usage += sizeof(int);
            }
            if (writeBlockToDisk(blk, r1Base, &buf) != 0)
            {
                perror("Writing Block Failed!\n");
                return -1;
            }
            r1Base = 3456;
        } else if (selection == '2') {
            /*关系投影算法, 对关系R上的A属性进行投影*/
            for(i = 0; i < 16; i++) {
                if ((blkR = (R *)readBlockFromDisk(rDiskBase, &buf)) == NULL) {
                    perror("Reading Block Failed!\n");
                    return -1;
                }
                for (j = 0; j < 7; j++) {
                }
                temp = blkR[i].B;
            }
            r2Base = 100000;
        } else if (selection == '3') {
            /*NLJ 算法， R.A 连接 S.C */
            r3Base = 800000;
        } else {
            break;
        }

        if ((blkS = (S *)readBlockFromDisk(sDiskBase, &buf)) == NULL) {
            perror("Reading Block Failed!\n");
            return -1;
        }
    }

    printf("Buffer Size %zu\n", buf.bufSize);
    printf("Block Size %zu\n", buf.blkSize);
    printf("Blocks Number %zu\n", buf.numAllBlk);
    printf("Blocks Free %zu\n", buf.numFreeBlk);

    freeBuffer(&buf);

    return 0;
}

