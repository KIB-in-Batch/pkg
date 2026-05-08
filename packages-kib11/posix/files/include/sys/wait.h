#ifndef SYS_WAIT_H_
#define SYS_WAIT_H_

#include <errno.h>
#include <windows.h>

#ifndef _PID_T_DEFINED
typedef int pid_t;
#define _PID_T_DEFINED
#endif

#ifndef WNOHANG
#define WNOHANG 1
#endif

#ifndef WUNTRACED
#define WUNTRACED 2
#endif

#ifndef WCONTINUED
#define WCONTINUED 8
#endif

#define WIFEXITED(status) ((((status) & 0x7f) == 0) ? 1 : 0)
#define WEXITSTATUS(status) (((status) >> 8) & 0xff)
#define WIFSIGNALED(status) ((((status) & 0x7f) != 0 && (((status) & 0x7f) != 0x7f)) ? 1 : 0)
#define WTERMSIG(status) ((status) & 0x7f)
#define WIFSTOPPED(status) ((((status) & 0xff) == 0x7f) ? 1 : 0)
#define WSTOPSIG(status) (((status) >> 8) & 0xff)
#define WIFCONTINUED(status) ((status) == 0xffff)

static int wait_status_from_exit_code(DWORD exit_code)
{
    return ((int)(exit_code & 0xff)) << 8;
}

static pid_t waitpid(pid_t pid, int *status, int options)
{
    HANDLE process;
    DWORD timeout;
    DWORD wait_result;
    DWORD exit_code;

    if (pid <= 0) {
        errno = ECHILD;
        return (pid_t)-1;
    }

    if ((options & ~(WNOHANG)) != 0) {
        errno = EINVAL;
        return (pid_t)-1;
    }

    process = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION, FALSE, (DWORD)pid);
    if (process == NULL) {
        process = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_LIMITED_INFORMATION, FALSE, (DWORD)pid);
    }
    if (process == NULL) {
        errno = ECHILD;
        return (pid_t)-1;
    }

    timeout = (options & WNOHANG) ? 0 : INFINITE;
    wait_result = WaitForSingleObject(process, timeout);
    if (wait_result == WAIT_TIMEOUT) {
        CloseHandle(process);
        return (pid_t)0;
    }
    if (wait_result != WAIT_OBJECT_0) {
        CloseHandle(process);
        errno = EINVAL;
        return (pid_t)-1;
    }

    if (status != NULL) {
        if (!GetExitCodeProcess(process, &exit_code)) {
            CloseHandle(process);
            errno = EINVAL;
            return (pid_t)-1;
        }
        *status = wait_status_from_exit_code(exit_code);
    }

    CloseHandle(process);
    return pid;
}

static pid_t wait(int *status)
{
    (void)status;
    errno = ECHILD;
    return (pid_t)-1;
}

#endif /* SYS_WAIT_H_ */
