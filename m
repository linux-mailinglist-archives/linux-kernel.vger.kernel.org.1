Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126D2D0131
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 07:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgLFGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 01:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgLFGgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 01:36:21 -0500
From:   "Andrew G. Morgan" <morgan@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     "Andrew G. Morgan" <morgan@kernel.org>
Subject: [PATCH] Debug config option for including cpu thread id in fault and signal info
Date:   Sat,  5 Dec 2020 22:35:05 -0800
Message-Id: <20201206063505.531798-1-morgan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option defaults to off.

I found this useful doing some fault isolation on an out of warranty
PC. I found one CPU core was consistently segfaulting and, together
with isolcpus=<n>,... I was able to breathe some life back into that
machine.

Since the si_errno value is generally hard-coded as zero for most signals,
userspace generally ignores it. Indeed, where I have tried it, the
userspace programs appear to be remarkably tolerant of this re-purposing
of the si_errno value.

Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
---
 init/Kconfig    | 16 ++++++++++++++++
 kernel/signal.c | 21 ++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 02d13ae27abb..74f1202c449a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -634,6 +634,22 @@ config PSI_DEFAULT_DISABLED
 
 endmenu # "CPU/Task time and stats accounting"
 
+config SIG_ERRNO_HAS_THREAD_INFO
+	bool "Debug thread source for faults and interrupts"
+	default n
+	help
+	  Select this to reveal to userspace, via siginfo_t.si_errno,
+	  the HW thread number associated with a fault or signal
+	  source. This feature has a number of HW debugging and
+	  performance applications. For example, if a core <n> seems
+	  to be unstable, isolcpus=<n> at boot can help avoid using
+	  it.
+
+	  The legacy and default value for this is mostly 0 for faults
+	  and signals, see 'man sigaction' for details. To distinguish
+	  thread 0 from this legacy, when the si_errno value holds a
+	  valid thread number, its uppermost bit is also set to 1.
+
 config CPU_ISOLATION
 	bool "CPU isolation"
 	depends on SMP || COMPILE_TEST
diff --git a/kernel/signal.c b/kernel/signal.c
index ef8f2a28d37c..523b93ec89f9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/user.h>
 #include <linux/sched/debug.h>
@@ -1617,13 +1618,19 @@ send_sig(int sig, struct task_struct *p, int priv)
 }
 EXPORT_SYMBOL(send_sig);
 
+#ifdef CONFIG_SIG_ERRNO_HAS_THREAD_INFO
+#define ZERO_OR_THREAD_INDEX ((1<<(8*sizeof(int)-1))|task_cpu(current))
+#else
+#define ZERO_OR_THREAD_INDEX 0
+#endif
+
 void force_sig(int sig)
 {
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code = SI_KERNEL;
 	info.si_pid = 0;
 	info.si_uid = 0;
@@ -1659,7 +1666,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code  = code;
 	info.si_addr  = addr;
 #ifdef __ARCH_SI_TRAPNO
@@ -1691,7 +1698,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 
 	clear_siginfo(&info);
 	info.si_signo = sig;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code  = code;
 	info.si_addr  = addr;
 #ifdef __ARCH_SI_TRAPNO
@@ -1712,7 +1719,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
 	info.si_signo = SIGBUS;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
@@ -1726,7 +1733,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 	WARN_ON((code != BUS_MCEERR_AO) && (code != BUS_MCEERR_AR));
 	clear_siginfo(&info);
 	info.si_signo = SIGBUS;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
@@ -1740,7 +1747,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 
 	clear_siginfo(&info);
 	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code  = SEGV_BNDERR;
 	info.si_addr  = addr;
 	info.si_lower = lower;
@@ -1755,7 +1762,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 
 	clear_siginfo(&info);
 	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
+	info.si_errno = ZERO_OR_THREAD_INDEX;
 	info.si_code  = SEGV_PKUERR;
 	info.si_addr  = addr;
 	info.si_pkey  = pkey;
-- 
2.26.2

