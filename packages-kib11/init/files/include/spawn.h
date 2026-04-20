#ifndef SPAWN_H_
#define SPAWN_H_

#include <windows.h>
#include <process.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <tchar.h>

#define pid_t int

int posix_spawn(pid_t *pid, const char *path, void *data1, void *data2, char *argv[], char *envp[]) {
    // Most of this is copied from https://learn.microsoft.com/en-us/windows/win32/procthread/creating-processes.
    // Why does the Windows API need so much boilerplate?
    
    STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );


    // Start the child process. 
    if( !CreateProcess( NULL,   // No module name (use command line)
    path,        // Command line
    NULL,           // Process handle not inheritable
    NULL,           // Thread handle not inheritable
    FALSE,          // Set handle inheritance to FALSE
    0,              // No creation flags
    NULL,           // Use parent's environment block
    NULL,           // Use parent's starting directory 
    &si,            // Pointer to STARTUPINFO structure
    &pi )           // Pointer to PROCESS_INFORMATION structure
    ) 
    {
        printf( "CreateProcess failed (%d).\n", GetLastError() );
        return;
    }

    // Wait until child process exits.
    WaitForSingleObject( pi.hProcess, INFINITE );

    // Close process and thread handles. 
    CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
}

#define posix_spawnp posix_spawn

#endif // SPAWN_H_
