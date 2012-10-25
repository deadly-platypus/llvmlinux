/*
 * Variable alignment macros used to break up a larger chunk of memory into
 * smaller variables. Meant to be used to replace the use of Variable Length
 * Arrays In Structures (VLAIS)
 *
 * Author: Behan Webster <behanw@conversincode.com>
 */

#ifndef _VALIGN_H_
#define _VALIGN_H_

/* Truncate an address or size to a particular memory alignment */
#define truncalign(num,padwidth) ((long)(num) & ~((padwidth)-1))

/* Pad out an address or size to a particular memory alignment */
#define padalign(num,padwidth) truncalign((long)(num) + ((padwidth)-1), padwidth)

/* Calculate the size that a variable will take as a part of a larger piece of
 * memory.  Takes into account alignment of the variable type, and the
 * alignement of the variable to be used after that.
 *
 * Example: size_t l = paddedsize(2, 2, short, int);
 *
 * The example above would give you a padded size of 6 bytes: 2x 16-bit shorts,
 * starting 2 bytes into the buffer followed by 2 bytes of padding so that the
 * next type (a 32-bit int) would be 32-bit aligned.
 */
#define paddedsize(offset,n,type,nexttype) (padalign((offset) + (n) * sizeof(type), __alignof__(nexttype)) - (offset))

/* Calculate the start address of a variable based on the offset from an
 * address, aligned based on the type of the variable specified.
 *
 * Example: char *buffer = kmalloc(size, GFP_KERNEL);
 *          long *var = paddedstart(buffer, 12, long);
 *
 * The example above on a 64-bit machine would return the equivalent of
 * &buffer[16] since a long needs to be 8 byte aligned.
 */
#define paddedstart(ptr,offset,type) (type *)padalign((long)ptr+(offset),__alignof__(type))

#endif
