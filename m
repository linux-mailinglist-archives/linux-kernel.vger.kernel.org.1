Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC222877EE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbgJHPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJHPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:45 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKszj-1k5RzS1wE9-00LIxa; Thu, 08 Oct 2020 17:47:56 +0200
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
Subject: [PATCH 06/13] m68k: split heartbeat out of timer function
Date:   Thu,  8 Oct 2020 17:46:44 +0200
Message-Id: <20201008154651.1901126-7-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9dogH0lDmXqhgYFQOL+Lk++oX4XbAfHtinaTN1FAILEIwJoSYcs
 pje8LKNSkxCKC5N1sfRTrZt8nMFibpgxf4gKtYgeqJhRsr/OynkyP4UPBYjvOIKNqXCDCC+
 Y0eQu9eKxYSjwdOyRVU/Q5f9w6wdQwp46ymRa2lFz8XVhRomdRno5TH4QSSzp/T1utLIFJ5
 nWi+bDjRgN6b2fPTyH1Tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZhxtDxgXMc=:JIQdvfkU6OFN7EDBUpldhF
 7V0CvcuadwYYx4Fxt2DRivlaxinpNO4PE0TWApAsyUYWaGYrKt53c5d3l7hyOo+9HM9+UIcp3
 9tXl7Ufj/C/qTgOHutXvpdiaEIJhslMHhJns6dY3lyV5uWuUAN8VN1Mjf5JNq0qitYgujTJU5
 lL81eqhTEvsypDHLZvCHtwgrnt7kKtyqC3VO2DrIoBm23a/b64jP6LETV9p9Kdse7MKoK69qD
 cKar03XFgTVA32zQLHOk9ir4k5O7cZU4mdTqXymI9kmXX+5XzTbheUxuZSli32DNNOXN283Sh
 0fG3BnuIjJBELM6vWFKsC2acdiAgzcc09FOKd8C5UEORdC43CCxdUfMsJf4mqumGu/a/Hdy6h
 eqHI66EEWGITc/lwHnzxdvLu3nJLH9mLFEsjL//sCcQaCTjKeSHWwrJOvebjn65Dgtlz1V72k
 0uGssMoBRpeKa/88XZqaNuhLgtmWY8gwrnNf6ol2JhpF1QVe2PuOHotuKkQ6o9ZcIHD1wm71g
 wXnnVTXTPI+VraEWagxYwdVdXwg+zvUyhu0gBjyGijHRMl4BGw9A07ON41D6WXc/+FGsQHZdv
 tMwoGiNEynykFTX9Xqm75GjJl3UI+kF3QsfI0YBNYpECdvsKcU0AUPpn7SRhWft++iSsXC8um
 x4ONqnM7Y+EzUzstNc7Zikx3L+j94Hu7ARXFob+RNlvFqwK5mQRdJIDB3ggggpG0vkIg39D7X
 USSsOqT6O6YOcNwwyY9J/vU/zhHNndNf6JUkN69e8ngFcFTSXHt6Dlf2VoJDrhV6re7oMl/Fp
 n5a7+A+wRl7LPU4l9mxRyxOkBjOaxd3vBpJouZEpPokQLqrOadk7ZWpafHk+1eRQyhAw3ZB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The heartbeat functionality is mostly separate from the
actual timer interrupt handling, and it is only used on
five platforms.

Split it out into a separate function and call that directly
from the timer irq on those platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/amiga/config.c        | 1 +
 arch/m68k/apollo/config.c       | 1 +
 arch/m68k/atari/time.c          | 2 ++
 arch/m68k/hp300/time.c          | 1 +
 arch/m68k/include/asm/machdep.h | 7 +++++++
 arch/m68k/kernel/time.c         | 7 +++++--
 arch/m68k/q40/q40ints.c         | 2 ++
 7 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index bee9f240f35d..29f92333119e 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -480,6 +480,7 @@ static irqreturn_t ciab_timer_handler(int irq, void *dev_id)
 	clk_total += jiffy_ticks;
 	clk_offset = 0;
 	timer_routine(0, NULL);
+	timer_heartbeat();
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 762da5d7a415..30915f1a8760 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -173,6 +173,7 @@ irqreturn_t dn_timer_int(int irq, void *dev_id)
 	volatile unsigned char x;
 
 	timer_handler(irq, dev_id);
+	timer_heartbeat();
 
 	x = *(volatile unsigned char *)(apollo_timer + 3);
 	x = *(volatile unsigned char *)(apollo_timer + 5);
diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index ce923a523695..ce4a5961ca93 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 
 #include <asm/atariints.h>
+#include <asm/machdep.h>
 
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
@@ -49,6 +50,7 @@ static irqreturn_t mfp_timer_c_handler(int irq, void *dev_id)
 	} while (last_timer_count == 1);
 	clk_total += INT_TICKS;
 	timer_routine(0, NULL);
+	timer_heartbeat();
 	local_irq_restore(flags);
 
 	return IRQ_HANDLED;
diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index bfee13e1d0fe..e3cd938de0f9 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -65,6 +65,7 @@ static irqreturn_t hp300_tick(int irq, void *dev_id)
 	clk_total += INTVAL;
 	clk_offset = 0;
 	timer_routine(0, NULL);
+	timer_heartbeat();
 	local_irq_restore(flags);
 
 	/* Turn off the network and SCSI leds */
diff --git a/arch/m68k/include/asm/machdep.h b/arch/m68k/include/asm/machdep.h
index 49bd3266b4b1..e62a39d01ae4 100644
--- a/arch/m68k/include/asm/machdep.h
+++ b/arch/m68k/include/asm/machdep.h
@@ -35,6 +35,13 @@ extern void (*mach_beep) (unsigned int, unsigned int);
 /* Hardware clock functions */
 extern void hw_timer_init(irq_handler_t handler);
 extern unsigned long hw_timer_offset(void);
+#ifdef CONFIG_HEARTBEAT
+extern void timer_heartbeat(void);
+#else
+static inline void timer_heartbeat(void)
+{
+}
+#endif
 
 extern void config_BSP(char *command, int len);
 
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index c2697a4d4ddd..c05cec21b05f 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -45,8 +45,12 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 	xtime_update(1);
 	update_process_times(user_mode(get_irq_regs()));
 	profile_tick(CPU_PROFILING);
+	return IRQ_HANDLED;
+}
 
 #ifdef CONFIG_HEARTBEAT
+void timer_heartbeat(void)
+{
 	/* use power LED as a heartbeat instead -- much more useful
 	   for debugging -- based on the version for PReP by Cort */
 	/* acts like an actual heart beat -- ie thump-thump-pause... */
@@ -68,9 +72,8 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 		dist = period / 4;
 	    }
 	}
-#endif /* CONFIG_HEARTBEAT */
-	return IRQ_HANDLED;
 }
+#endif /* CONFIG_HEARTBEAT */
 
 #ifdef CONFIG_M68KCLASSIC
 #if !IS_BUILTIN(CONFIG_RTC_DRV_GENERIC)
diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 1c696906c159..b01b545a2db0 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
+#include <asm/machdep.h>
 #include <asm/ptrace.h>
 #include <asm/traps.h>
 
@@ -144,6 +145,7 @@ static irqreturn_t q40_timer_int(int irq, void *dev_id)
 
 		local_irq_save(flags);
 		timer_routine(0, NULL);
+		timer_heartbeat();
 		local_irq_restore(flags);
 	}
 	return IRQ_HANDLED;
-- 
2.27.0

