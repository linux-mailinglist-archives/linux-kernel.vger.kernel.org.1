Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B84287800
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgJHPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:49:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39441 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJHPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:49:12 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvJjz-1ki52S1Qcj-00rKvC; Thu, 08 Oct 2020 17:48:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/13] timekeeping: remove xtime_update
Date:   Thu,  8 Oct 2020 17:46:49 +0200
Message-Id: <20201008154651.1901126-12-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6hJbbfGGg12T/dGQyGr13rPvlOPGP87+2hmxJ9JNtjqfzkSruqQ
 3sYoq+6M4I1LdwOLC7sKDE250RVhmpc78c3BQspDMhaS4LJfzDMyzLJhjXg53If0X3/FuMD
 sMH6WNikT5+qcswQ8b0y0w9Ftcd6KVENO2wgrWSHB5GL0Ri2N8aipMhqIAV4NolUsn8QFKp
 qZUlasYHU6tqY2pWw3rMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9MQKeVk4qE=:KUXoCc01BNDOKLCr4zxTW0
 r9FjgYvk6nCJBvKvVeu3kX8PMKtF1c1ocI+bml1u/BQ3WdVX4OXlVEa1ftkhLyTuvJhEAKiWo
 D72w9b/8UANH+rdzWpYGsq3U8vf+N0t7P0VGu/dZ0n2MrUC5/twmMgRhM+Mg32PE3CxV6q6p3
 GJbXjMfOeSp0dUrOS6/IGM7nhMAnLk3ZympP0nJNCUB5V40aHgM7lNRmU/peR9OOMbuNsRZE3
 8k9bI/Y3FohU/V+ekt5hwd9k8r23KuHS3zE6tiKLMejLdCeU/BCGHaglcFb6oEAXkwFexHhtB
 W2Ah1wovG81JBennNyt6H0eKSQA8V2VC4RU6d3k80eu1wys7s4PDc9qgzs8SmRo9n6jsGwDpd
 6Z0C5wms8bG4Dbc5by6AaRiIktuCekQNkXISuUKRNlDj+dDwpzqxSwvgnSHO01mRZ4+huruMh
 sGCc9t5fEEMVlLYFg73Qy6fN2LQTRdffi5/M0t7f2S+P03rO4fSpRHGeWzQycTVYemL9KYs+X
 Q7BjMshOUKt5xXsIuV8i9XcbcOhbCvcCa7oc5ZGJBESXvJsfBos6dS1euPGx+cKUvFj+kzKZq
 XGaetMXcVQMmDGovlLV6OtGFHfcarO9wIlNI4JMtOlQX0szPbwk3Z5vtjBGR30Ntqu3Q2zgpD
 Emf0DwZ0bYxA0hG9PZQeoLJjvf62j87AU7aMrCfZrEUU6VaABEUbN1tdbX3h0ki1qKHlCHlf2
 qt+Q5YpcLfbNQDwLDhs7PNHgdMH5FPBcDfiwZOOovom4b4PC5JA7/6MPo5Wzg5xNGcvjopQcZ
 IlJlFdntWyVftMLdVr7PSMNbprRwP9oXdX02a4+/gpuPTfiunwiPDS8HgA3vmA5+v6wpUH7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users of xtime_update aside from legacy_timer_tick(),
so fold it into that function and remove the declaration.

update_process_times() is now only called inside of the kernel/time/
code, so the declaration can be moved there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h |  4 +---
 kernel/time/tick-legacy.c   | 22 ++++++++++++++++++++--
 kernel/time/timekeeping.c   | 16 ----------------
 kernel/time/timekeeping.h   |  1 +
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3670cb1670ff..a8bef0ffcbdd 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -9,9 +9,7 @@
 void timekeeping_init(void);
 extern int timekeeping_suspended;
 
-/* Architecture timer tick functions: */
-extern void update_process_times(int user);
-extern void xtime_update(unsigned long ticks);
+/* Architecture timer tick functions */
 extern void legacy_timer_tick(unsigned long ticks);
 
 /*
diff --git a/kernel/time/tick-legacy.c b/kernel/time/tick-legacy.c
index 73c5a0af4743..af225b32f5b3 100644
--- a/kernel/time/tick-legacy.c
+++ b/kernel/time/tick-legacy.c
@@ -10,10 +10,28 @@
 
 #include "tick-internal.h"
 
+/**
+ * legacy_timer_tick() - advances the timekeeping infrastructure
+ * @ticks:	number of ticks, that have elapsed since the last call.
+ *
+ * This is used by platforms that have not been converted to
+ * generic clockevents.
+ *
+ * If 'ticks' is zero, the CPU is not handling timekeeping, so
+ * only perform process accounting and profiling.
+ *
+ * Must be called with interrupts disabled.
+ */
 void legacy_timer_tick(unsigned long ticks)
 {
-	if (ticks)
-		xtime_update(ticks);
+	if (ticks) {
+		raw_spin_lock(&jiffies_lock);
+		write_seqcount_begin(&jiffies_seq);
+		do_timer(ticks);
+		write_seqcount_end(&jiffies_seq);
+		raw_spin_unlock(&jiffies_lock);
+		update_wall_time();
+	}
 	update_process_times(user_mode(get_irq_regs()));
 	profile_tick(CPU_PROFILING);
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6858a31364b6..2c7814411f83 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2461,19 +2461,3 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
-
-/**
- * xtime_update() - advances the timekeeping infrastructure
- * @ticks:	number of ticks, that have elapsed since the last call.
- *
- * Must be called with interrupts disabled.
- */
-void xtime_update(unsigned long ticks)
-{
-	raw_spin_lock(&jiffies_lock);
-	write_seqcount_begin(&jiffies_seq);
-	do_timer(ticks);
-	write_seqcount_end(&jiffies_seq);
-	raw_spin_unlock(&jiffies_lock);
-	update_wall_time();
-}
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 099737f6f10c..d94b69c5b869 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -22,6 +22,7 @@ static inline int sched_clock_suspend(void) { return 0; }
 static inline void sched_clock_resume(void) { }
 #endif
 
+extern void update_process_times(int user);
 extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
 
-- 
2.27.0

