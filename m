Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE32A09C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgJ3P1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgJ3P1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:27:10 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428DA22243;
        Fri, 30 Oct 2020 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604071117;
        bh=tl4gqglTgRfuyFB/3HlKwXAdiYKP+Knbyg2nIPTrjfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMVyyoFBNv/IaQlogPnv06ORVbW06T2gsRtjtVIGIZoUJaMuCYQDSLMzcD6bQRXfj
         jZIWQ7YtTDvsJxfveHhaAvbvWQLkzyxEH4k0tVE0FrBON1/ofkJ3xYBusmV1tRegMQ
         ETja3alfiWS69OfshaX7Q9nM0n3UwZeTyroeNR84=
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 04/15] timekeeping: add CONFIG_LEGACY_TIMER_TICK
Date:   Fri, 30 Oct 2020 16:17:47 +0100
Message-Id: <20201030151758.1241164-5-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030151758.1241164-1-arnd@kernel.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All platforms that currently do not use generic clockevents roughly call
the same set of functions in their timer interrupts: xtime_update(),
update_process_times() and profile_tick(), sometimes in a different
sequence.

Add a helper function that performs all three of them, to make the
callers more uniform and simplify the interface.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
index 51d298ccbe05..c6867f29d279 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -57,6 +57,13 @@ config POSIX_CPU_TIMERS_TASK_WORK
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

