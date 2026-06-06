#ifndef STAT_H_
#define STAT_H_

#include <fcntl.h>
#include <io.h>
#include <process.h>
#include <direct.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stddef.h>
#include <stdint.h>
#include <windows.h>
#include <unistd.h>
#include <time.h>

static inline int mkdir(const char *path, ...) {
	int result = _mkdir(path);
	return result;
}

#define _stat stat

struct stat {
	int      st_dev;      /* ID of device containing file */
	int      st_ino;      /* Inode number */
	int     st_mode;     /* File type and mode */
	int    st_nlink;    /* Number of hard links */
	int      st_uid;      /* User ID of owner */
	int      st_gid;      /* Group ID of owner */
	int      st_rdev;     /* Device ID (if special file) */
	int      st_size;     /* Total size, in bytes */
	int  st_blksize;  /* Block size for filesystem I/O */
	int   st_blocks;   /* Number of 512 B blocks allocated */

	/* Since POSIX.1-2008, this structure supports nanosecond
	   precision for the following timestamp fields.
	   For the details before POSIX.1-2008, see VERSIONS. */

	struct timespec  st_atim;  /* Time of last access */
	struct timespec  st_mtim;  /* Time of last modification */
	struct timespec  st_ctim;  /* Time of last status change */

#define st_atime  st_atim.tv_sec  /* Backward compatibility */
#define st_mtime  st_mtim.tv_sec
#define st_ctime  st_ctim.tv_sec
};

#endif
