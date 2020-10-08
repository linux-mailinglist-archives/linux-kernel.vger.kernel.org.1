Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5A2877E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbgJHPs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgJHPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:22 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQdMG-1k2x0a3lRe-00NkbV; Thu, 08 Oct 2020 17:47:35 +0200
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
Subject: [PATCH 03/13] ARM: rpc: use legacy_timer_tick
Date:   Thu,  8 Oct 2020 17:46:41 +0200
Message-Id: <20201008154651.1901126-4-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AV/xQQR2jt9Rwk0ymjAs+h06lgep6VgQtpKXSCm3RsvPedqWUvi
 k4xxlR1Egxcic8tT5i13A/WWoGB0lOB3XDe3RLEMa5aSAJ198tXUY5jfimFkr/t+H8PeSiO
 ou+MyWyazink8mfnqoLPk4rmHIQhJJM8u6Z5luNIbJyW7sL8WLXmM7pDT7b710FQyzvF1pN
 NYN6qpDk6KkYtg+eJTyYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HJYHx377UCA=:x/7rjJt+7xnjvb99y4WTbl
 cy+IsvGh3OG7yWjqodDRveTEuOWpIO3rbNU+jmFFmK/nohkqNWSVLuHFOOENtAxMhoMDjoNMC
 LQSmtU7RW5FF2lTBKlhkOk81b7fJPfIQnlELDI1jxBFvAsSwwiq9ib7p+7jvwFytw3dMwM1ve
 mJ4TMN44fIiPSxSM5RLxF6Wuc97rNJVa8fP3Dsm37YT6w+9xcQPCLVaAEx09tCCqFZBIeklsv
 UtMeQdswWU5fX0EGDZoPZgTTO+Coe+Iuowo1hbJEkY2Vrp3a+QtX7Xpw8s8pkMzyweyGzxdrP
 jIh4F6imG5gupoxZuP/mjiOxpsFGhP9UEmTpmxCvbnIB2sR4/fznuL0tlRku2KIBVWUZcb1yt
 fY3VkGQoGi6+hZ+4mFC3Y4OMQ8qSw8CgbNZwexkb5sDBxBZuc4sciWmo0ZMkxYOm06CfySarx
 JFUUwNLVoQHbZVydSdQX+BdwdK1Xh9rvnmtxQ1CTF+C7SMAoj440oBlhoAkZNbYG2G+v/qcTc
 08wZdcP5uwlOyrOPOTOvS7nRXZCL0No1XSk4gQ6C+d5QsVJDECW9vqCNQdAbtj2l7pbtcTlhQ
 Zfw7MK94SfxGmGJNvmFb9a0lxL6YEshI5wwfBbobr/Q3E/w5n2UUwzj25x1BLRFebonP6KBRK
 ELzh6zwYfL7jT6d5mL/fDVIBrqbJ7oja+bzAIWNyUJkmKCkZf4ZC+p5IcrE5UCOubLc/z/Kuj
 LqYbQnUv6Lgspo76cwb7OIKKflco8Sk3Fzsrs6BSCmW3Y3Bc18QKuON2YgbdHaJsho8wpaFHM
 5dzeyP6tLppPFy+cEmdJmFeVQpJz8JO/CANIprUirlscJmMf1FeFBdBmNEcQ8HXK9Cj44ym
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rpc is the only user of the timer_tick() function now, and can
just call the newly added generic version instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                 |  1 +
 arch/arm/include/asm/mach/time.h |  2 --
 arch/arm/kernel/time.c           | 14 --------------
 arch/arm/mach-rpc/time.c         |  2 +-
 4 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..13af8d7a6c17 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -467,6 +467,7 @@ config ARCH_RPC
 	select HAVE_IDE
 	select HAVE_PATA_PLATFORM
 	select ISA_DMA_API
+	select LEGACY_TIMER_TICK
 	select NEED_MACH_IO_H
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT_MAP
diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index d75d39280db7..5f522916ec99 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -7,8 +7,6 @@
 #ifndef __ASM_ARM_MACH_TIME_H
 #define __ASM_ARM_MACH_TIME_H
 
-extern void timer_tick(void);
-
 typedef void (*clock_access_fn)(struct timespec64 *);
 extern int register_persistent_clock(clock_access_fn read_persistent);
 
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 09b149b09c43..b3836c94dc74 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -60,20 +60,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#ifndef CONFIG_GENERIC_CLOCKEVENTS
-/*
- * Kernel system timer support.
- */
-void timer_tick(void)
-{
-	profile_tick(CPU_PROFILING);
-	xtime_update(1);
-#ifndef CONFIG_SMP
-	update_process_times(user_mode(get_irq_regs()));
-#endif
-}
-#endif
-
 static void dummy_clock_access(struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index da85cac761ba..9f8edcfe9357 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -81,7 +81,7 @@ static irqreturn_t
 ioc_timer_interrupt(int irq, void *dev_id)
 {
 	ioc_time += RPC_LATCH;
-	timer_tick();
+	legacy_timer_tick(1);
 	return IRQ_HANDLED;
 }
 
-- 
2.27.0

