#ifndef SPAWN_H_
#define SPAWN_H_

#include <windows.h>
#include <process.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <stddef.h>

#ifndef _PID_T_DEFINED
typedef int pid_t;
#define _PID_T_DEFINED
#endif

static int posix_spawn_windows_error(DWORD error)
{
    switch (error) {
    case ERROR_FILE_NOT_FOUND:
    case ERROR_PATH_NOT_FOUND:
    case ERROR_BAD_PATHNAME:
        return ENOENT;
    case ERROR_ACCESS_DENIED:
        return EACCES;
    case ERROR_NOT_ENOUGH_MEMORY:
    case ERROR_OUTOFMEMORY:
        return ENOMEM;
    default:
        return EINVAL;
    }
}

static size_t posix_spawn_quoted_arg_size(const char *arg)
{
    const char *p;
    size_t size = 2;

    for (p = arg; *p; ++p) {
        if (*p == '"' || *p == '\\') {
            ++size;
        }
        ++size;
    }

    return size;
}

static char *posix_spawn_quote_arg(char *dest, const char *arg)
{
    *dest++ = '"';
    while (*arg) {
        if (*arg == '"' || *arg == '\\') {
            *dest++ = '\\';
        }
        *dest++ = *arg++;
    }
    *dest++ = '"';
    return dest;
}

static char *posix_spawn_build_command_line(const char *path, char *const argv[])
{
    char *command_line;
    char *out;
    size_t size = 1;
    int argc = 0;
    int i;

    if (argv != NULL && argv[0] != NULL) {
        while (argv[argc] != NULL) {
            size += posix_spawn_quoted_arg_size(argv[argc]) + 1;
            ++argc;
        }
    } else {
        size += posix_spawn_quoted_arg_size(path);
    }

    command_line = (char *)malloc(size);
    if (command_line == NULL) {
        return NULL;
    }

    out = command_line;
    if (argc > 0) {
        for (i = 0; i < argc; ++i) {
            if (i > 0) {
                *out++ = ' ';
            }
            out = posix_spawn_quote_arg(out, argv[i]);
        }
    } else {
        out = posix_spawn_quote_arg(out, path);
    }
    *out = '\0';

    return command_line;
}

static char *posix_spawn_build_environment(char *const envp[])
{
    char *environment;
    char *out;
    size_t size = 1;
    int i;

    if (envp == NULL) {
        return NULL;
    }

    for (i = 0; envp[i] != NULL; ++i) {
        size += strlen(envp[i]) + 1;
    }

    environment = (char *)malloc(size);
    if (environment == NULL) {
        return NULL;
    }

    out = environment;
    for (i = 0; envp[i] != NULL; ++i) {
        size_t len = strlen(envp[i]);
        memcpy(out, envp[i], len);
        out += len;
        *out++ = '\0';
    }
    *out = '\0';

    return environment;
}

static int posix_spawn(pid_t *pid, const char *path, void *file_actions, void *attrp, char *const argv[], char *const envp[])
{
    STARTUPINFOA si;
    PROCESS_INFORMATION pi;
    char *command_line;
    char *environment;
    BOOL created;
    DWORD error;

    (void)file_actions;
    (void)attrp;

    if (path == NULL) {
        return EINVAL;
    }

    command_line = posix_spawn_build_command_line(path, argv);
    if (command_line == NULL) {
        return ENOMEM;
    }

    environment = posix_spawn_build_environment(envp);
    if (envp != NULL && environment == NULL) {
        free(command_line);
        return ENOMEM;
    }

    ZeroMemory(&si, sizeof(si));
    si.cb = sizeof(si);
    ZeroMemory(&pi, sizeof(pi));

    created = CreateProcessA(
        path,
        command_line,
        NULL,
        NULL,
        FALSE,
        0,
        environment,
        NULL,
        &si,
        &pi);

    error = GetLastError();
    free(command_line);
    free(environment);

    if (!created) {
        return posix_spawn_windows_error(error);
    }

    if (pid != NULL) {
        *pid = (pid_t)pi.dwProcessId;
    }

    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return 0;
}

#define posix_spawnp posix_spawn

#endif // SPAWN_H_
