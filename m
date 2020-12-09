Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994782D4918
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbgLISea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:34:30 -0500
Received: from foss.arm.com ([217.140.110.172]:38652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgLISe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:34:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BD81FB;
        Wed,  9 Dec 2020 10:33:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0E423F68F;
        Wed,  9 Dec 2020 10:33:42 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] lockdep: report broken irq restoration
Date:   Wed,  9 Dec 2020 18:33:37 +0000
Message-Id: <20201209183337.1912-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We generally expect local_irq_save() and local_irq_restore() to be
paired and sanely nested, and so local_irq_restore() expects to be
called with irqs disabled. Thus, within local_irq_restore() we only
trace irq flag changes when unmasking irqs.

This means that a seuence such as:

| local_irq_disable();
| local_irq_save(flags);
| local_irq_enable();
| local_irq_restore(flags);

... is liable to break things, as the local_irq_restore() would mask
IRQs without tracing this change.

We don't consider such sequences to be a good idea, so let's define
those as forbidden, and add tooling to detect such broken cases.

This patch adds debug code to WARN() when local_irq_restore() is called
with irqs enabled. As local_irq_restore() is expected to pair with
local_irq_save(), it should never be called with interrupts enabled.

To avoid the possibility of circular header dependencies beteen
irqflags.h and bug.h, the warning is handled in a separate C file.

The new code is all conditional on a new CONFIG_DEBUG_IRQFLAGS symbol
which is independent of CONFIG_TRACE_IRQFLAGS. As noted above such cases
will confuse lockdep, so CONFIG_DEBUG_LOCKDEP now selects
CONFIG_DEBUG_IRQFLAGS.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqflags.h       | 18 +++++++++++++++++-
 kernel/locking/Makefile        |  1 +
 kernel/locking/irqflag-debug.c | 12 ++++++++++++
 lib/Kconfig.debug              |  7 +++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 kernel/locking/irqflag-debug.c

Note: as things stand this'll blow up at boot-time on x86 within the io-apic
timer_irq_works() boot-time test. I've proposed a fix for that:

https://lore.kernel.org/lkml/20201209181514.GA14235@C02TD0UTHF1T.local/

... which was sufficient for booting under QEMU without splats. I'm giving this
a soak under Syzkaller on arm64 as that booted cleanly to begin with.

Mark.

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3ed4e8771b64..bca3c6fa8270 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -220,10 +220,26 @@ do {						\
 
 #else /* !CONFIG_TRACE_IRQFLAGS */
 
+#ifdef CONFIG_DEBUG_IRQFLAGS
+extern void warn_bogus_irq_restore(bool *warned);
+#define check_bogus_irq_restore()				\
+	do {							\
+		static bool __section(".data.once") __warned;	\
+		if (unlikely(!raw_irqs_disabled()))		\
+			warn_bogus_irq_restore(&__warned);	\
+	} while (0)
+#else
+#define check_bogus_irq_restore() do { } while (0)
+#endif
+
 #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
 #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
 #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
-#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
+#define local_irq_restore(flags)		\
+	do {					\
+		check_bogus_irq_restore();	\
+		raw_local_irq_restore(flags);	\
+	} while (0)
 #define safe_halt()		do { raw_safe_halt(); } while (0)
 
 #endif /* CONFIG_TRACE_IRQFLAGS */
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 6d11cfb9b41f..8838f1d7c4a2 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -15,6 +15,7 @@ CFLAGS_REMOVE_mutex-debug.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_rtmutex-debug.o = $(CC_FLAGS_FTRACE)
 endif
 
+obj-$(CONFIG_DEBUG_IRQFLAGS) += irqflag-debug.o
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_LOCKDEP) += lockdep.o
 ifeq ($(CONFIG_PROC_FS),y)
diff --git a/kernel/locking/irqflag-debug.c b/kernel/locking/irqflag-debug.c
new file mode 100644
index 000000000000..3024c6837ac2
--- /dev/null
+++ b/kernel/locking/irqflag-debug.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bug.h>
+
+void warn_bogus_irq_restore(bool *warned)
+{
+	if (*warned)
+		return;
+
+	*warned = true;
+	WARN(1, "local_irq_restore() called with IRQs enabled\n");
+}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39ed527..f7895d57bb08 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1312,6 +1312,7 @@ config LOCKDEP_SMALL
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
+	select DEBUG_IRQFLAGS
 	help
 	  If you say Y here, the lock dependency engine will do
 	  additional runtime checks to debug itself, at the price
@@ -1400,6 +1401,12 @@ config TRACE_IRQFLAGS_NMI
 	depends on TRACE_IRQFLAGS
 	depends on TRACE_IRQFLAGS_NMI_SUPPORT
 
+config DEBUG_IRQFLAGS
+	bool "Interrupt mask debugging"
+	help
+	  Enables checks for potentially unsafe enabling or disabling of
+	  interrupts.
+
 config STACKTRACE
 	bool "Stack backtrace support"
 	depends on STACKTRACE_SUPPORT
-- 
2.11.0

