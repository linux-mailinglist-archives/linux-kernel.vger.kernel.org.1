Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E52877DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgJHPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgJHPsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:15 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQMdz-1k4KSW1S3l-00MNpC; Thu, 08 Oct 2020 17:47:22 +0200
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
Subject: [PATCH 01/13] timekeeping: add CONFIG_LEGACY_TIMER_TICK
Date:   Thu,  8 Oct 2020 17:46:39 +0200
Message-Id: <20201008154651.1901126-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lJJKtGZAxWt7DMFVnzZRB47PnCLatINXoORTSIFhtBK1TMTdNiv
 RG4yLsnkyOAV7i7CY4P6/yTTsoYlGUtq5FolW0zFQmapsMzTrePJNwmGfm6BWP+Zj/wddj3
 L1sjseIS105PzF6aN9WPsUH3h0CWoHEvfIlgpVpv9Loi24x65wMHlFaPhAQ/Zd5HCND4YC8
 a5Apn6ItpnEokOcusQ+YQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LRXNx4Y7rGM=:W7aq/8a9yjrM8EkUU5AZjb
 KRhqGA4PFyX2G6oCIIIvLpEOsxxfnokV1+U4lVGw+713pi22Z2jAYx2+OLR3eo4/G8+4vgK3p
 pX2TbMknPaniCvgONqCrrNhqSqsm7b4l3qnYaXNCRKbqUOty/aF753t5ZwdhlByx5YN14cPfQ
 QwFuNJRQRPQVIqhJS3YEXx6RVGw6fT+KxGpyZdnfjjmD16ZMQx3Mb+rN/nTQNugTsbrwc3eFW
 pGWl/GE0s1czW1DB4UqH6MJy5sgdQBmJU36SJx6gzyXQVNN7sDHpOMCuuGsAbpkXCbzIPPVM1
 sqn1+jNvH7zxTQ3puVsYymfmUFP4QCs0LXHwH2qML7YU7sJLMMx8jOv5SkoR985WFCY8VZ37b
 VMIkdIP0uMWMQxhJKHI/nc3f6WdynC7AHHnrUuoX1FjeGj+U2u0ajNtUFIJtQLIDuSMg0IXma
 KYyj9fO3pmII6+ghqSiR7HejGK3Jr/GPJYuEL9ikQibsqRmEBmYxgDGmJzZdiIRPgkU8E0exT
 C7t+0L8ll3T2CBZDBaFlbImApYvroGjmFe0p/Kuhq8bowvKZdls/mB2aN3Eu6VVFHPvo/zPhN
 qp1WHrOO9otDZxX3Xt1CcrhDCsVNVDcg9jOE3Kpp9IgLSLNXmRCDCxldZD4FU0HOsibcmeUm7
 9RIqwNBNoNAfE5/aurdG2zdES2SbuCh0cLP0LojJnWxHQ48vMaUQknug6iwTayNUe7q+kVxfY
 bBetwKQnt/NYaDZvViPfyq3HOJl8WcN0mmpp9rztNyaPUH/tlh0ohxjLIQt0NJZvycMnBTsoa
 xGiKuBJaEO4MO7ukG8X4jYD+RlsFPm1cbW2v3nNqzfV1ixvBzsHSWtW1ratVBDFK3kLJGAi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All platforms that currently do not use generic clockevents roughly call
the same set of functions in their timer interrupts: xtime_update(),
update_process_times() and profile_tick(), sometimes in a different
sequence.

Add a helper function that performs all three of them, to make the
callers more uniform and simplify the interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/timekeeping.h |  1 +
 kernel/time/Kconfig         |  7 +++++++
 kernel/time/Makefile        |  1 +
 kernel/time/tick-legacy.c   | 19 +++++++++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 kernel/time/tick-legacy.c

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7f7e4a3f4394..3670cb1670ff 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -12,6 +12,7 @@ extern int timekeeping_suspended;
 /* Architecture timer tick functions: */
 extern void update_process_times(int user);
 extern void xtime_update(unsigned long ticks);
+extern void legacy_timer_tick(unsigned long ticks);
 
 /*
  * Get and set timeofday
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a09b1d61df6a..f2b0cfeade47 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -61,6 +61,13 @@ config POSIX_CPU_TIMERS_TASK_WORK
 	bool
 	default y if POSIX_TIMERS && HAVE_POSIX_CPU_TIMERS_TASK_WORK
 
+config LEGACY_TIMER_TICK
+	bool
+	help
+	  The legacy timer tick helper is used by platforms that
+	  lack support for the generic clockevent framework.
+	  New platforms should use generic clockevents instead.
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index c8f00168afe8..1fb1c1ef6a19 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -16,6 +16,7 @@ ifeq ($(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST),y)
 endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
+obj-$(CONFIG_LEGACY_TIMER_TICK)			+= tick-legacy.o
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
diff --git a/kernel/time/tick-legacy.c b/kernel/time/tick-legacy.c
new file mode 100644
index 000000000000..73c5a0af4743
--- /dev/null
+++ b/kernel/time/tick-legacy.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Timer tick function for architectures that lack generic clockevents,
+ * consolidated here from m68k/ia64/parisc/arm.
+ */
+
+#include <linux/irq.h>
+#include <linux/profile.h>
+#include <linux/timekeeper_internal.h>
+
+#include "tick-internal.h"
+
+void legacy_timer_tick(unsigned long ticks)
+{
+	if (ticks)
+		xtime_update(ticks);
+	update_process_times(user_mode(get_irq_regs()));
+	profile_tick(CPU_PROFILING);
+}
-- 
2.27.0

