#ifndef SPAWN_H_
#define SPAWN_H_

#include <windows.h>
#include <process.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>

#define POSIX_SPAWN_RESETIDS 0x01
#define POSIX_SPAWN_SETPGROUP 0x02
#define POSIX_SPAWN_SETSIGDEF 0x04
#define POSIX_SPAWN_SETSIGMASK 0x08
#define POSIX_SPAWN_SETSCHEDPARAM 0x10
#define POSIX_SPAWN_SETSCHEDULER 0x20
#define POSIX_SPAWN_USEVFORK 0x40

typedef struct {
	int flags;
	pid_t pgroup;
	int *sched_policy;
	int *sched_param;
} posix_spawnattr_t;

typedef struct {
	int action;
	int fd;
	int newfd;
} posix_spawn_file_action_t;

typedef struct {
	posix_spawn_file_action_t *actions;
	int count;
	int capacity;
} posix_spawn_file_actions_t;

#define POSIX_SPAWN_OPEN 0
#define POSIX_SPAWN_DUP2 1
#define POSIX_SPAWN_CLOSE 2

typedef int pid_t;

 int posix_spawnattr_init(posix_spawnattr_t *attr) {
	if (!attr) return EINVAL;
	attr->flags = 0;
	attr->pgroup = 0;
	attr->sched_policy = NULL;
	attr->sched_param = NULL;
	return 0;
}

 int posix_spawnattr_destroy(posix_spawnattr_t *attr) {
	if (!attr) return EINVAL;
	if (attr->sched_policy) free(attr->sched_policy);
	if (attr->sched_param) free(attr->sched_param);
	return 0;
}

 int posix_spawn_file_actions_init(posix_spawn_file_actions_t *acts) {
	if (!acts) return EINVAL;
	acts->actions = NULL;
	acts->count = 0;
	acts->capacity = 0;
	return 0;
}

 int posix_spawn_file_actions_destroy(posix_spawn_file_actions_t *acts) {
	if (!acts) return EINVAL;
	if (acts->actions) free(acts->actions);
	acts->count = 0;
	acts->capacity = 0;
	return 0;
}

 int posix_spawn_file_actions_addopen(
		posix_spawn_file_actions_t *acts, int fd, const char *path,
		int flags, mode_t mode) {
	if (!acts || !path) return EINVAL;

	if (acts->count >= acts->capacity) {
		int new_cap = acts->capacity ? acts->capacity * 2 : 4;
		posix_spawn_file_action_t *new_acts = realloc(acts->actions,
				new_cap * sizeof(posix_spawn_file_action_t));
		if (!new_acts) return ENOMEM;
		acts->actions = new_acts;
		acts->capacity = new_cap;
	}

	acts->actions[acts->count].action = POSIX_SPAWN_OPEN;
	acts->actions[acts->count].fd = fd;
	acts->actions[acts->count].newfd = _open(path, flags, mode);
	if (acts->actions[acts->count].newfd < 0) return errno;

	acts->count++;
	return 0;
}

 int posix_spawn_file_actions_adddup2(
		posix_spawn_file_actions_t *acts, int fd, int newfd) {
	if (!acts || fd < 0 || newfd < 0) return EINVAL;

	if (acts->count >= acts->capacity) {
		int new_cap = acts->capacity ? acts->capacity * 2 : 4;
		posix_spawn_file_action_t *new_acts = realloc(acts->actions,
				new_cap * sizeof(posix_spawn_file_action_t));
		if (!new_acts) return ENOMEM;
		acts->actions = new_acts;
		acts->capacity = new_cap;
	}

	acts->actions[acts->count].action = POSIX_SPAWN_DUP2;
	acts->actions[acts->count].fd = fd;
	acts->actions[acts->count].newfd = newfd;
	acts->count++;

	return 0;
}

 int posix_spawn_file_actions_addclose(
		posix_spawn_file_actions_t *acts, int fd) {
	if (!acts || fd < 0) return EINVAL;

	if (acts->count >= acts->capacity) {
		int new_cap = acts->capacity ? acts->capacity * 2 : 4;
		posix_spawn_file_action_t *new_acts = realloc(acts->actions,
				new_cap * sizeof(posix_spawn_file_action_t));
		if (!new_acts) return ENOMEM;
		acts->actions = new_acts;
		acts->capacity = new_cap;
	}

	acts->actions[acts->count].action = POSIX_SPAWN_CLOSE;
	acts->actions[acts->count].fd = fd;
	acts->count++;

	return 0;
}

 int posix_spawn(
		pid_t *pid, const char *path,
		const posix_spawn_file_actions_t *acts,
		const posix_spawnattr_t *attr,
		char * const argv[], char * const envp[]) {

	if (!pid || !path || !argv) return EINVAL;

	size_t cmdline_len = 1;
	for (int i = 0; argv[i]; i++) {
		cmdline_len += strlen(argv[i]) + 3;
	}

	char *cmdline = malloc(cmdline_len);
	if (!cmdline) return ENOMEM;

	cmdline[0] = '\0';
	for (int i = 0; argv[i]; i++) {
		if (i > 0) strcat(cmdline, " ");
		strcat(cmdline, "\"");
		strcat(cmdline, argv[i]);
		strcat(cmdline, "\"");
	}

	STARTUPINFOA si = {0};
	PROCESS_INFORMATION pi = {0};
	si.cb = sizeof(si);
	si.dwFlags = STARTF_USESTDHANDLES;
	si.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
	si.hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE);
	si.hStdError = GetStdHandle(STD_ERROR_HANDLE);

	if (acts && acts->count > 0) {
		for (int i = 0; i < acts->count; i++) {
			const posix_spawn_file_action_t *act = &acts->actions[i];
			switch (act->action) {
				case POSIX_SPAWN_DUP2:
					if (act->fd == STDIN_FILENO)
						si.hStdInput = (HANDLE)_get_osfhandle(act->newfd);
					else if (act->fd == STDOUT_FILENO)
						si.hStdOutput = (HANDLE)_get_osfhandle(act->newfd);
					else if (act->fd == STDERR_FILENO)
						si.hStdError = (HANDLE)_get_osfhandle(act->newfd);
					break;
				case POSIX_SPAWN_CLOSE:
					if (act->fd == STDIN_FILENO)
						si.hStdInput = NULL;
					else if (act->fd == STDOUT_FILENO)
						si.hStdOutput = NULL;
					else if (act->fd == STDERR_FILENO)
						si.hStdError = NULL;
					break;
				case POSIX_SPAWN_OPEN:
					break;
			}
		}
	}

	BOOL success = CreateProcessA(
			path,
			cmdline,
			NULL,
			NULL,
			TRUE,
			0,
			envp,
			NULL,
			&si,
			&pi);

	free(cmdline);

	if (!success) {
		return GetLastError();
	}

	*pid = (pid_t)pi.dwProcessId;
	CloseHandle(pi.hThread);
	CloseHandle(pi.hProcess);

	return 0;
}

#endif // SPAWN_H_
