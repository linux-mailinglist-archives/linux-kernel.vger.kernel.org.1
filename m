Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E605300148
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbhAVLOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:14:55 -0500
Received: from foss.arm.com ([217.140.110.172]:41750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbhAVLHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:07:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0026D11D4;
        Fri, 22 Jan 2021 03:06:33 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545123F719;
        Fri, 22 Jan 2021 03:06:31 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:06:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2] lockdep: report broken irq restoration
Message-ID: <20210122110625.GA29868@C02TD0UTHF1T.local>
References: <20210111153707.10071-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111153707.10071-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Any thoughts on this? I'd like to get this in soon if we could as it'll
help to flush out any remaining issues that are liable to get in the way
of planned rework for arm64 and x86.

Thomas, are you happy to pick this?

Thanks,
Mark.

On Mon, Jan 11, 2021 at 03:37:07PM +0000, Mark Rutland wrote:
> We generally expect local_irq_save() and local_irq_restore() to be
> paired and sanely nested, and so local_irq_restore() expects to be
> called with irqs disabled. Thus, within local_irq_restore() we only
> trace irq flag changes when unmasking irqs.
> 
> This means that a sequence such as:
> 
> | local_irq_disable();
> | local_irq_save(flags);
> | local_irq_enable();
> | local_irq_restore(flags);
> 
> ... is liable to break things, as the local_irq_restore() would mask
> irqs without tracing this change. Similar problems may exist for
> architectures whose arch_irq_restore() function depends on being called
> with irqs disabled.
> 
> We don't consider such sequences to be a good idea, so let's define
> those as forbidden, and add tooling to detect such broken cases.
> 
> This patch adds debug code to WARN() when raw_local_irq_restore() is
> called with irqs enabled. As raw_local_irq_restore() is expected to pair
> with raw_local_irq_save(), it should never be called with irqs enabled.
> 
> To avoid the possibility of circular header dependencies between
> irqflags.h and bug.h, the warning is handled in a separate C file.
> 
> The new code is all conditional on a new CONFIG_DEBUG_IRQFLAGS symbol
> which is independent of CONFIG_TRACE_IRQFLAGS. As noted above such cases
> will confuse lockdep, so CONFIG_DEBUG_LOCKDEP now selects
> CONFIG_DEBUG_IRQFLAGS.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irqflags.h       | 12 ++++++++++++
>  kernel/locking/Makefile        |  1 +
>  kernel/locking/irqflag-debug.c | 11 +++++++++++
>  lib/Kconfig.debug              |  8 ++++++++
>  4 files changed, 32 insertions(+)
>  create mode 100644 kernel/locking/irqflag-debug.c
> 
> Since v1 [1]:
> * Remove per-instance bool in favour of a single WARN_ONCE()
> * Move check into raw_local_irq_restore()
> * Update Kconfig text and cover
> 
> [1] https://lore.kernel.org/r/20201209183337.1912-1-mark.rutland@arm.com
> 
> Mark.
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 8de0e1373de7..600c10da321a 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -149,6 +149,17 @@ do {						\
>  # define start_critical_timings() do { } while (0)
>  #endif
>  
> +#ifdef CONFIG_DEBUG_IRQFLAGS
> +extern void warn_bogus_irq_restore(void);
> +#define raw_check_bogus_irq_restore()			\
> +	do {						\
> +		if (unlikely(!arch_irqs_disabled()))	\
> +			warn_bogus_irq_restore();	\
> +	} while (0)
> +#else
> +#define raw_check_bogus_irq_restore() do { } while (0)
> +#endif
> +
>  /*
>   * Wrap the arch provided IRQ routines to provide appropriate checks.
>   */
> @@ -162,6 +173,7 @@ do {						\
>  #define raw_local_irq_restore(flags)			\
>  	do {						\
>  		typecheck(unsigned long, flags);	\
> +		raw_check_bogus_irq_restore();		\
>  		arch_local_irq_restore(flags);		\
>  	} while (0)
>  #define raw_local_save_flags(flags)			\
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 6d11cfb9b41f..8838f1d7c4a2 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -15,6 +15,7 @@ CFLAGS_REMOVE_mutex-debug.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_rtmutex-debug.o = $(CC_FLAGS_FTRACE)
>  endif
>  
> +obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
>  obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
>  obj-$(CONFIG_LOCKDEP) += lockdep.o
>  ifeq ($(CONFIG_PROC_FS),y)
> diff --git a/kernel/locking/irqflag-debug.c b/kernel/locking/irqflag-debug.c
> new file mode 100644
> index 000000000000..9603d207a4ca
> --- /dev/null
> +++ b/kernel/locking/irqflag-debug.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bug.h>
> +#include <linux/export.h>
> +#include <linux/irqflags.h>
> +
> +void warn_bogus_irq_restore(void)
> +{
> +	WARN_ONCE(1, "raw_local_irq_restore() called with IRQs enabled\n");
> +}
> +EXPORT_SYMBOL(warn_bogus_irq_restore);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7937265ef879..5ea0c1773b0a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1335,6 +1335,7 @@ config LOCKDEP_SMALL
>  config DEBUG_LOCKDEP
>  	bool "Lock dependency engine debugging"
>  	depends on DEBUG_KERNEL && LOCKDEP
> +	select DEBUG_IRQFLAGS
>  	help
>  	  If you say Y here, the lock dependency engine will do
>  	  additional runtime checks to debug itself, at the price
> @@ -1423,6 +1424,13 @@ config TRACE_IRQFLAGS_NMI
>  	depends on TRACE_IRQFLAGS
>  	depends on TRACE_IRQFLAGS_NMI_SUPPORT
>  
> +config DEBUG_IRQFLAGS
> +	bool "Debug IRQ flag manipulation"
> +	help
> +	  Enables checks for potentially unsafe enabling or disabling of
> +	  interrupts, such as calling raw_local_irq_restore() when interrupts
> +	  are enabled.
> +
>  config STACKTRACE
>  	bool "Stack backtrace support"
>  	depends on STACKTRACE_SUPPORT
> -- 
> 2.11.0
> 
