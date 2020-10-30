Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556BC2A07D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgJ3O1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgJ3O1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:27:08 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7140D2076E;
        Fri, 30 Oct 2020 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604068026;
        bh=G9yO8KvyctM+R9M1LCODEAywiUmejWiWgAx+5JLM+lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2altvea6sfYCZIIXXKY2O9kwJ605MAZfHcyXlOchg+NtsqcP0AUAVFbllBV3qw+2
         R68ecHwm+QOblscWAUGUGtgEEi9Z3bEfMX4wU+pa19+3RcWTUJ2k2m8g2e/g8B4163
         kWlGD1DhqftPyc/TH5jAMP7m7dP5m9AGI7vWllZc=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] m68k: m68328: remove duplicate code
Date:   Fri, 30 Oct 2020 15:26:24 +0100
Message-Id: <20201030142642.855683-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030142642.855683-1-arnd@kernel.org>
References: <20201030142642.855683-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building a kernel with multiple dragonball based boards
enabled needlessly causes a link failure because of duplicate
config_BSP() functions between the CPU versions.

Avoid that merging the three almost identical files into one,
and hiding the CPU configuration behind the board config.
The pr_info() lines are consolidated in one place.

It is still not possible to run a kernel configured for
more than one board, but at least configurations that can
be selected can also be built now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/68000/Makefile    |  5 +--
 arch/m68k/68000/m68328.c    | 31 ++++++++++-------
 arch/m68k/68000/m68EZ328.c  | 58 --------------------------------
 arch/m68k/68000/m68VZ328.c  | 67 -------------------------------------
 arch/m68k/Kconfig.cpu       |  8 ++---
 arch/m68k/Kconfig.machine   | 16 +++++----
 arch/m68k/kernel/setup_no.c |  9 +++++
 7 files changed, 43 insertions(+), 151 deletions(-)
 delete mode 100644 arch/m68k/68000/m68EZ328.c
 delete mode 100644 arch/m68k/68000/m68VZ328.c

diff --git a/arch/m68k/68000/Makefile b/arch/m68k/68000/Makefile
index ce0b26d6580d..674541fdf5b8 100644
--- a/arch/m68k/68000/Makefile
+++ b/arch/m68k/68000/Makefile
@@ -10,10 +10,7 @@
 
 # 68328, 68EZ328, 68VZ328
 
-obj-y			+= entry.o ints.o timers.o
-obj-$(CONFIG_M68328)	+= m68328.o
-obj-$(CONFIG_M68EZ328)	+= m68EZ328.o
-obj-$(CONFIG_M68VZ328)	+= m68VZ328.o
+obj-y			+= entry.o ints.o timers.o m68328.o
 obj-$(CONFIG_ROM)	+= romvec.o
 
 obj-$(CONFIG_DRAGEN2)	+= dragen2.o
diff --git a/arch/m68k/68000/m68328.c b/arch/m68k/68000/m68328.c
index 6a5cfc977150..eab08da058c6 100644
--- a/arch/m68k/68000/m68328.c
+++ b/arch/m68k/68000/m68328.c
@@ -1,10 +1,11 @@
 /***************************************************************************/
 
 /*
- *  m68328.c - 68328 specific config
+ *  m68328.c - 68328/68EZ328/68VZ328 specific config
  *
  *  Copyright (C) 1993 Hamish Macdonald
  *  Copyright (C) 1999 D. Jeff Dionne
+ *  Copyright (C) 2001 Georges Menie, Ken Desmet
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive
@@ -20,8 +21,10 @@
 #include <linux/kernel.h>
 #include <linux/rtc.h>
 #include <asm/machdep.h>
-#include <asm/MC68328.h>
-#if defined(CONFIG_PILOT) || defined(CONFIG_INIT_LCD)
+
+#if defined(CONFIG_INIT_LCD) && defined(CONFIG_M68VZ328)
+#include "bootlogo-vz.h"
+#elif defined(CONFIG_PILOT) || defined(CONFIG_INIT_LCD)
 #include "bootlogo.h"
 #endif
 
@@ -29,10 +32,7 @@
 
 /***************************************************************************/
 
-
-/***************************************************************************/
-
-void m68328_reset (void)
+static void m68328_reset(void)
 {
   local_irq_disable();
   asm volatile ("moveal #0x10c00000, %a0;\n\t"
@@ -46,12 +46,19 @@ void m68328_reset (void)
 
 void __init config_BSP(char *command, int len)
 {
-  pr_info("68328 support D. Jeff Dionne <jeff@uclinux.org>\n");
-  pr_info("68328 support Kenneth Albanowski <kjahds@kjshds.com>\n");
-  pr_info("68328/Pilot support Bernhard Kuhn <kuhn@lpr.e-technik.tu-muenchen.de>\n");
+	mach_sched_init = hw_timer_init;
+	mach_hwclk = m68328_hwclk;
+	mach_reset = m68328_reset;
 
-  mach_hwclk = m68328_hwclk;
-  mach_reset = m68328_reset;
+#if   defined(CONFIG_PILOT) && defined(CONFIG_M68328)
+	mach_sched_init = NULL;
+#elif defined(CONFIG_UCSIMM)
+	init_ucsimm(command, len);
+#elif defined(CONFIG_UCDIMM)
+	init_ucsimm(command, len);
+#elif defined(CONFIG_DRAGEN2)
+	init_dragen2(command, len);
+#endif
 }
 
 /***************************************************************************/
diff --git a/arch/m68k/68000/m68EZ328.c b/arch/m68k/68000/m68EZ328.c
deleted file mode 100644
index 65bd112285ef..000000000000
--- a/arch/m68k/68000/m68EZ328.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/***************************************************************************/
-
-/*
- *  m68EZ328.c - 68EZ328 specific config
- *
- *  Copyright (C) 1993 Hamish Macdonald
- *  Copyright (C) 1999 D. Jeff Dionne
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-/***************************************************************************/
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/rtc.h>
-#include <linux/pgtable.h>
-#include <asm/machdep.h>
-#include <asm/MC68EZ328.h>
-#ifdef CONFIG_UCSIMM
-#include <asm/bootstd.h>
-#endif
-
-#include "m68328.h"
-
-/***************************************************************************/
-
-void m68ez328_reset(void)
-{
-  local_irq_disable();
-  asm volatile (
-    "moveal #0x10c00000, %a0;\n"
-    "moveb #0, 0xFFFFF300;\n"
-    "moveal 0(%a0), %sp;\n"
-    "moveal 4(%a0), %a0;\n"
-    "jmp (%a0);\n"
-    );
-}
-
-/***************************************************************************/
-
-void __init config_BSP(char *command, int len)
-{
-  pr_info("68EZ328 DragonBallEZ support (C) 1999 Rt-Control, Inc\n");
-
-#ifdef CONFIG_UCSIMM
-  init_ucsimm(command, len);
-#endif
-
-  mach_sched_init = hw_timer_init;
-  mach_hwclk = m68328_hwclk;
-  mach_reset = m68ez328_reset;
-}
-
-/***************************************************************************/
diff --git a/arch/m68k/68000/m68VZ328.c b/arch/m68k/68000/m68VZ328.c
deleted file mode 100644
index 025da5552f1c..000000000000
--- a/arch/m68k/68000/m68VZ328.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/***************************************************************************/
-
-/*
- *  m68VZ328.c - 68VZ328 specific config
- *
- *  Copyright (C) 1993 Hamish Macdonald
- *  Copyright (C) 1999 D. Jeff Dionne
- *  Copyright (C) 2001 Georges Menie, Ken Desmet
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-/***************************************************************************/
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/kd.h>
-#include <linux/netdevice.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/rtc.h>
-#include <linux/pgtable.h>
-
-#include <asm/machdep.h>
-#include <asm/MC68VZ328.h>
-#include <asm/bootstd.h>
-
-#ifdef CONFIG_INIT_LCD
-#include "bootlogo-vz.h"
-#endif
-
-#include "m68328.h"
-
-/***************************************************************************/
-static void m68vz328_reset(void)
-{
-	local_irq_disable();
-	asm volatile (
-		"moveal #0x10c00000, %a0;\n\t"
-		"moveb #0, 0xFFFFF300;\n\t"
-		"moveal 0(%a0), %sp;\n\t"
-		"moveal 4(%a0), %a0;\n\t"
-		"jmp (%a0);\n"
-	);
-}
-
-/***************************************************************************/
-
-void __init config_BSP(char *command, int size)
-{
-	pr_info("68VZ328 DragonBallVZ support (c) 2001 Lineo, Inc.\n");
-
-	mach_sched_init = hw_timer_init;
-	mach_hwclk = m68328_hwclk;
-	mach_reset = m68vz328_reset;
-
-#ifdef CONFIG_UCDIMM
-	init_ucsimm(command, len);
-#elif defined(CONFIG_DRAGEN2)
-	init_dragen2(command, len);
-#endif
-}
-
-/***************************************************************************/
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 694c4fca9f5d..a65ce7618232 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -35,7 +35,7 @@ endchoice
 if M68KCLASSIC
 
 config M68000
-	bool "MC68000"
+	bool
 	depends on !MMU
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_MULDIV64
@@ -102,21 +102,21 @@ config M68060
 	  processor, say Y. Otherwise, say N.
 
 config M68328
-	bool "MC68328"
+	bool
 	depends on !MMU
 	select M68000
 	help
 	  Motorola 68328 processor support.
 
 config M68EZ328
-	bool "MC68EZ328"
+	bool
 	depends on !MMU
 	select M68000
 	help
 	  Motorola 68EX328 processor support.
 
 config M68VZ328
-	bool "MC68VZ328"
+	bool
 	depends on !MMU
 	select M68000
 	help
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 17e8c3a292d7..1851c66e8667 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -136,14 +136,13 @@ config SUN3
 
 	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
 
-endif # M68KCLASSIC
-
 config PILOT
 	bool
 
 config PILOT3
 	bool "Pilot 1000/5000, PalmPilot Personal/Pro, or PalmIII support"
-	depends on M68328
+	depends on !MMU
+	select M68328
 	select PILOT
 	help
 	  Support for the Palm Pilot 1000/5000, Personal/Pro and PalmIII.
@@ -156,19 +155,22 @@ config XCOPILOT_BUGS
 
 config UCSIMM
 	bool "uCsimm module support"
-	depends on M68EZ328
+	depends on !MMU
+	select M68EZ328
 	help
 	  Support for the Arcturus Networks uCsimm module.
 
 config UCDIMM
 	bool "uDsimm module support"
-	depends on M68VZ328
+	depends on !MMU
+	select M68VZ328
 	help
 	  Support for the Arcturus Networks uDsimm module.
 
 config DRAGEN2
 	bool "DragenEngine II board support"
-	depends on M68VZ328
+	depends on !MMU
+	select M68VZ328
 	help
 	  Support for the DragenEngine II board.
 
@@ -191,6 +193,8 @@ config MEMORY_RESERVE
 	help
 	  Reserve certain memory regions on 68x328 based boards.
 
+endif # M68KCLASSIC
+
 config ARN5206
 	bool "Arnewsh 5206 board support"
 	depends on M5206
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index f66f4b1d062e..58dbe10ccf56 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -106,8 +106,16 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_UCDIMM
 	pr_info("uCdimm by Lineo, Inc. <www.lineo.com>\n");
 #endif
+#ifdef CONFIG_M68328
+	pr_info("68328 support D. Jeff Dionne <jeff@uclinux.org>\n");
+	pr_info("68328 support Kenneth Albanowski <kjahds@kjshds.com>\n");
+#endif
+#ifdef CONFIG_M68EZ328
+	pr_info("68EZ328 DragonBallEZ support (C) 1999 Rt-Control, Inc\n");
+#endif
 #ifdef CONFIG_M68VZ328
 	pr_info("M68VZ328 support by Evan Stawnyczy <e@lineo.ca>\n");
+	pr_info("68VZ328 DragonBallVZ support (c) 2001 Lineo, Inc.\n");
 #endif
 #ifdef CONFIG_COLDFIRE
 	pr_info("COLDFIRE port done by Greg Ungerer, gerg@snapgear.com\n");
@@ -121,6 +129,7 @@ void __init setup_arch(char **cmdline_p)
 	pr_info("Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne\n");
 
 #if defined( CONFIG_PILOT ) && defined( CONFIG_M68328 )
+	pr_info("68328/Pilot support Bernhard Kuhn <kuhn@lpr.e-technik.tu-muenchen.de>\n");
 	pr_info("TRG SuperPilot FLASH card support <info@trgnet.com>\n");
 #endif
 #if defined( CONFIG_PILOT ) && defined( CONFIG_M68EZ328 )
-- 
2.27.0

