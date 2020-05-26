Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA811D48CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 10:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEOIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 04:50:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgEOIuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:50:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF189AC77;
        Fri, 15 May 2020 08:50:25 +0000 (UTC)
Date:   Fri, 15 May 2020 10:50:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk/kdb: Redirect printk messages into kdb in any context
Message-ID: <20200515085021.GS17734@linux-b0ei>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb is able to stop kernel even in NMI context where printk() is redirected
to the printk_safe() lockless variant. Move the check and redirect to kdb
even in this case.

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Sending as proper patch for review.
Adding Sergey into CC and John into CC.

kernel/printk/printk.c      | 14 +-------------
 kernel/printk/printk_safe.c |  7 +++++++
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a9b6156270b..63a1aa377cd9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -35,7 +35,6 @@
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
 #include <linux/crash_core.h>
-#include <linux/kdb.h>
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
 #include <linux/syslog.h>
@@ -2036,18 +2035,7 @@ EXPORT_SYMBOL(vprintk);
 
 int vprintk_default(const char *fmt, va_list args)
 {
-	int r;
-
-#ifdef CONFIG_KGDB_KDB
-	/* Allow to pass printk() to kdb but avoid a recursion. */
-	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0)) {
-		r = vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
-		return r;
-	}
-#endif
-	r = vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 }
 EXPORT_SYMBOL_GPL(vprintk_default);
 
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index d9a659a686f3..7ccb821d0bfe 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -6,6 +6,7 @@
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
 #include <linux/debug_locks.h>
+#include <linux/kdb.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
 #include <linux/irq_work.h>
@@ -359,6 +360,12 @@ void __printk_safe_exit(void)
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
+#ifdef CONFIG_KGDB_KDB
+	/* Allow to pass printk() to kdb but avoid a recursion. */
+	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
+		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
+#endif
+
 	/*
 	 * Try to use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
-- 
2.26.1

