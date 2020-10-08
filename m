Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FBF2877DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgJHPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgJHPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:14 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbjBo-1kw2bm0QD0-00dFFd; Thu, 08 Oct 2020 17:47:28 +0200
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
Subject: [PATCH 02/13] ia64: convert to legacy_timer_tick
Date:   Thu,  8 Oct 2020 17:46:40 +0200
Message-Id: <20201008154651.1901126-3-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ePraAn9sYfjjmN+Pfy1LK/TlC3kbuYMGC10htaNZtEoL4EElh6V
 uUfQ2M8RrzwilxlpRECo4aworXpv0mPq14YV7xgWgDbr3CkCTdz8ck/laM6m2cSFVWk8wr+
 OdiIDGttczrWtoFrBfLrn6aGhfOgPSiDPwJDDepEQn7bbNFk5FuGhTcqhm0p6r9IWAxCHqN
 K+0illtvK/O63i5klIqSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cyBT1lbAb9E=:codLXYZPwTd7MCDcZiI75B
 P8juIUxynuMFPV6+uX9zpIuubWLpskzTn1R3hmKbzbkdm92glxZXZd8v74/ZHXgMLldY+vqkg
 XBvH/SUxBSL/EHjcLoaxAsBd9xZ4Fs4f9Fr5fPVErU9CemrnjXxTegDtfYsNdh0o7M3JsXvS1
 N8LYnzF+qpmUK/qyXcfXujk4jPShJf3iIy/gHNyjRGOqt/aggkM8YYDmj/8WUSOJNCBP5t4xC
 hwd2PAe/AflX0qWGcHJ/nJWS8F2js8H72FSyM5ENpmSAxQaQZeCyFSkA8OqBkbwUIlzdyjSUW
 sUeS0DuWpDJu+YTNsbaKyz2bB3Wb4zmQhkYEgPiEEGG7N5n71Vw0tGKs6A0ptGGOosOo4f4py
 DAKkYvhv4mQ2JVIU36iiXbMqYpFRZRPGsquOn7AqI+tLbku6+gHW4+gSedB06euHb8dUma0We
 bnl9vcs1ITAxJ5qpcOJ1Fnblgpfaw5XSx3sAWE4pwycsFoypo7oWuBISD5mfA8Do34aGjsSGG
 uq2AgHJH9dx7QI7uIqPtYYZO9eyT50QfrntVjEhxSBOkasx3lMSNYhOWWbb6p3y+A2KjEkQJt
 AbX4eUGLJN976MbgzAUgC1rF1wqRImvaIsKDGKKsJu6N56T7r8AVXjRfcXeBH/RXMurpyIAn5
 8bG3zyAgLijtK2CKVPGGDsBKyreAHi7JZ+d5ea81DaAfdvoVD31DuE94XjkTIy/VkotqXj4Q4
 iKGRPp1zwgliRU99icuQGNQWDfn3HbrMdyJB0w5srO6ANnhspDtlb0J9CmJ0iNVdibJ58AV56
 TO2Pnqz13Y3jOpNam49OSAkfTyRggSKFN+XI+q01x1ycQ7B39ZLSN5mZwDmCuPW8/809ahb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 is the only architecture that calls xtime_update() in a loop,
once for each jiffie that has passed since the last event.

Before commit 3171a0305d62 ("[PATCH] simplify update_times (avoid
jiffies/jiffies_64 aliasing problem)") in 2006, it could not actually do
this any differently, but now it seems simpler to just pass the number
of jiffies that passed in the meantime.

While this loses the ability process interrupts in the middle of
the timer tick by calling local_irq_enable(), doing so is fairly
peculiar anyway and it seems better to just do what everyone
else does here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/Kconfig       |  1 +
 arch/ia64/kernel/time.c | 36 +++++++++++++-----------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 39b25a5a591b..db8c2a365b70 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -46,6 +46,7 @@ config IA64
 	select ARCH_THREAD_STACK_ALLOCATOR
 	select ARCH_CLOCKSOURCE_DATA
 	select GENERIC_TIME_VSYSCALL
+	select LEGACY_TIMER_TICK
 	select SWIOTLB
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf..9431edb08508 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -161,39 +161,29 @@ void vtime_account_idle(struct task_struct *tsk)
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id)
 {
-	unsigned long new_itm;
+	unsigned long cur_itm, new_itm, ticks;
 
 	if (cpu_is_offline(smp_processor_id())) {
 		return IRQ_HANDLED;
 	}
 
 	new_itm = local_cpu_data->itm_next;
+	cur_itm = ia64_get_itc();
 
-	if (!time_after(ia64_get_itc(), new_itm))
+	if (!time_after(cur_itm, new_itm)) {
 		printk(KERN_ERR "Oops: timer tick before it's due (itc=%lx,itm=%lx)\n",
-		       ia64_get_itc(), new_itm);
-
-	profile_tick(CPU_PROFILING);
-
-	while (1) {
-		update_process_times(user_mode(get_irq_regs()));
-
-		new_itm += local_cpu_data->itm_delta;
-
-		if (smp_processor_id() == time_keeper_id)
-			xtime_update(1);
-
-		local_cpu_data->itm_next = new_itm;
+		       cur_itm, new_itm);
+		ticks = 1;
+	} else {
+		ticks = DIV_ROUND_UP(cur_itm - new_itm,
+				     local_cpu_data->itm_delta);
+		new_itm += ticks * local_cpu_data->itm_delta;
+	}
 
-		if (time_after(new_itm, ia64_get_itc()))
-			break;
+	if (smp_processor_id() != time_keeper_id)
+		ticks = 0;
 
-		/*
-		 * Allow IPIs to interrupt the timer loop.
-		 */
-		local_irq_enable();
-		local_irq_disable();
-	}
+	legacy_timer_tick(ticks);
 
 	do {
 		/*
-- 
2.27.0

