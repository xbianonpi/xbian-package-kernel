#ifndef _ASM_SIGNAL_H
#define _ASM_SIGNAL_H

#include <linux/types.h>

/* Here we must cater to libcs that poke about in kernel headers.  */

#define NSIG		32
typedef unsigned long sigset_t;


#define SA_RESTORER	0x04000000 /* to get struct sigaction correct */

#include <asm-generic/signal.h>

/* Here we must cater to libcs that poke about in kernel headers.  */

struct sigaction {
	union {
	  __sighandler_t _sa_handler;
	  void (*_sa_sigaction)(int, struct siginfo *, void *);
	} _u;
	sigset_t sa_mask;
	unsigned long sa_flags;
	void (*sa_restorer)(void);
};

#define sa_handler	_u._sa_handler
#define sa_sigaction	_u._sa_sigaction


#endif /* _ASM_SIGNAL_H */
