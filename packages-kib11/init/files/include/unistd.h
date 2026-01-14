#ifndef UNISTD_H_
#define UNISTD_H_
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

#ifndef S_ISDIR
#define S_ISDIR(m) (((m) & S_IFMT) == S_IFDIR)
#endif

#ifndef S_ISREG
#define S_ISREG(m) (((m) & S_IFMT) == S_IFREG)
#endif

#ifndef S_ISCHR
#define S_ISCHR(m) (((m) & S_IFMT) == S_IFCHR)
#endif

#ifndef S_ISBLK
#define S_ISBLK(m) (((m) & S_IFMT) == S_IFBLK)
#endif

#ifndef S_ISFIFO
#define S_ISFIFO(m) (((m) & S_IFMT) == S_IFIFO)
#endif

typedef long ssize_t;
typedef unsigned int mode_t;

#define getcwd _getcwd
#define read _read
#define write _write
#define close _close
#define open _open
#define dup _dup
#define lseek _lseek
#define pipe _pipe
#define dup2 _dup2
#define access _access
#define chdir _chdir
#define mkdir _mkdir
#define rmdir _rmdir
#define unlink _unlink
#define isatty _isatty

#ifndef F_OK
#define F_OK 0
#endif
#ifndef R_OK
#define R_OK 4
#endif
#ifndef W_OK
#define W_OK 2
#endif
#ifndef X_OK
#define X_OK R_OK
#endif

#ifndef STDIN_FILENO
#define STDIN_FILENO 0
#endif
#ifndef STDOUT_FILENO
#define STDOUT_FILENO 1
#endif
#ifndef STDERR_FILENO
#define STDERR_FILENO 2
#endif

#define getpid _getpid
#define getppid _getppid

unsigned int sleep(unsigned int seconds) {
	Sleep(seconds * 1000);
	return 0;
}

#define ftruncate _chsize

#endif // UNISTD_H_
