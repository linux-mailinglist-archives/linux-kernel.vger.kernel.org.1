Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416D28F222
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgJOMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:33:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:35379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgJOMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:33:08 -0400
Received: from localhost.localdomain ([46.223.126.90]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEVBa-1keeLH47Pm-00G4Qh; Thu, 15 Oct 2020 14:33:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] m68k: m68328: move platform code to separate files
Date:   Thu, 15 Oct 2020 14:32:36 +0200
Message-Id: <20201015123258.2644027-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+hCjmhiwcsp/p6uQ+E4gHI/rQ8hpOz8jKeBYRIAFSh+YpTKSbwZ
 zfnD9rfVFWZ1rXIISqAg/BnY9pibIdyMfutMS79jTO/eRJ50Gd3iPFjPLr5m6WX2ezNCBaj
 lmDHe1j+EjFzFqb+FZIhrgl7a1al2s+g3PxtQO8OdTfmpreCY7En1FghGfWy7qSSCC3Eekn
 yB6AEJQDrxbrTfx/TOQXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TGXDN9mpaz0=:qWG53txrue9c2zM8hj2VzE
 BUoEagwYBrpILwramLCrrGDGvHafGReh7vx1R8VUV+LjwFmfkkWX73k9doQA6KCDcqGBbZbs/
 0JMdWcpomyB9Ki1Qfth0hPlUrWBZAzOdFLfPnPQKg+dg+c8QE8aVcTpYpZP7P9Y+x4dia5bLI
 2Rt0ydicOrt2Ybr5juWZMpczKVnW7JLpGki7EtGaIWmumHByPEdTbcQ5I3MPvkNp8U2Q8pty7
 WBGzhhDx1yxgRJ6GhbzfukI/ZqzyOV8gZewieD7aY8KHtOznw0urF8DXZF0I4dg0rTDbp1fS/
 x6JdaefG2+2Ql6lHj8z/K/SLuG33lTo54g78A4EjHZNX0FnSpurHpkpm+Ue6k4PgchVHpHF5N
 AQ9Q2+QO5M1jyy+/cVs1kyBhZUTFt94MNuSJoPCrDG8MhMJLY8+d/lGHfuxxQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dragen2 and ucsimm/ucdimm files require a bit of
custom code compared to the other dragonball platforms,
move them into separate files as a preparation for a
build fix.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Just a small cleanup after I ran into some issue during build
testing my timer patches, the second patch contains the
actual bugfix but relies on this preparation patch.
---
 arch/m68k/68000/Makefile   |   4 ++
 arch/m68k/68000/dragen2.c  | 100 +++++++++++++++++++++++++++
 arch/m68k/68000/m68328.c   |   3 +-
 arch/m68k/68000/m68328.h   |   5 ++
 arch/m68k/68000/m68EZ328.c |  23 +------
 arch/m68k/68000/m68VZ328.c | 136 ++-----------------------------------
 arch/m68k/68000/ucsimm.c   |  38 +++++++++++
 7 files changed, 158 insertions(+), 151 deletions(-)
 create mode 100644 arch/m68k/68000/dragen2.c
 create mode 100644 arch/m68k/68000/m68328.h
 create mode 100644 arch/m68k/68000/ucsimm.c

diff --git a/arch/m68k/68000/Makefile b/arch/m68k/68000/Makefile
index 4f7d4b45a46f..ce0b26d6580d 100644
--- a/arch/m68k/68000/Makefile
+++ b/arch/m68k/68000/Makefile
@@ -16,4 +16,8 @@ obj-$(CONFIG_M68EZ328)	+= m68EZ328.o
 obj-$(CONFIG_M68VZ328)	+= m68VZ328.o
 obj-$(CONFIG_ROM)	+= romvec.o
 
+obj-$(CONFIG_DRAGEN2)	+= dragen2.o
+obj-$(CONFIG_UCSIMM)	+= ucsimm.o
+obj-$(CONFIG_UCDIMM)	+= ucsimm.o
+
 extra-y 		:= head.o
diff --git a/arch/m68k/68000/dragen2.c b/arch/m68k/68000/dragen2.c
new file mode 100644
index 000000000000..584893c57c37
--- /dev/null
+++ b/arch/m68k/68000/dragen2.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1993 Hamish Macdonald
+ *  Copyright (C) 1999 D. Jeff Dionne
+ *  Copyright (C) 2001 Georges Menie, Ken Desmet
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <asm/machdep.h>
+#include <asm/MC68VZ328.h>
+
+/***************************************************************************/
+/*                        Init Drangon Engine hardware                     */
+/***************************************************************************/
+
+static void dragen2_reset(void)
+{
+	local_irq_disable();
+
+#ifdef CONFIG_INIT_LCD
+	PBDATA |= 0x20;				/* disable CCFL light */
+	PKDATA |= 0x4;				/* disable LCD controller */
+	LCKCON = 0;
+#endif
+
+	__asm__ __volatile__(
+		"reset\n\t"
+		"moveal #0x04000000, %a0\n\t"
+		"moveal 0(%a0), %sp\n\t"
+		"moveal 4(%a0), %a0\n\t"
+		"jmp (%a0)"
+	);
+}
+
+void __init init_dragen2(char *command, int size)
+{
+	mach_reset = dragen2_reset;
+
+#ifdef CONFIG_DIRECT_IO_ACCESS
+	SCR = 0x10;					/* allow user access to internal registers */
+#endif
+
+	/* CSGB Init */
+	CSGBB = 0x4000;
+	CSB = 0x1a1;
+
+	/* CS8900 init */
+	/* PK3: hardware sleep function pin, active low */
+	PKSEL |= PK(3);				/* select pin as I/O */
+	PKDIR |= PK(3);				/* select pin as output */
+	PKDATA |= PK(3);			/* set pin high */
+
+	/* PF5: hardware reset function pin, active high */
+	PFSEL |= PF(5);				/* select pin as I/O */
+	PFDIR |= PF(5);				/* select pin as output */
+	PFDATA &= ~PF(5);			/* set pin low */
+
+	/* cs8900 hardware reset */
+	PFDATA |= PF(5);
+	{ int i; for (i = 0; i < 32000; ++i); }
+	PFDATA &= ~PF(5);
+
+	/* INT1 enable (cs8900 IRQ) */
+	PDPOL &= ~PD(1);			/* active high signal */
+	PDIQEG &= ~PD(1);
+	PDIRQEN |= PD(1);			/* IRQ enabled */
+
+#ifdef CONFIG_INIT_LCD
+	/* initialize LCD controller */
+	LSSA = (long) screen_bits;
+	LVPW = 0x14;
+	LXMAX = 0x140;
+	LYMAX = 0xef;
+	LRRA = 0;
+	LPXCD = 3;
+	LPICF = 0x08;
+	LPOLCF = 0;
+	LCKCON = 0x80;
+	PCPDEN = 0xff;
+	PCSEL = 0;
+
+	/* Enable LCD controller */
+	PKDIR |= 0x4;
+	PKSEL |= 0x4;
+	PKDATA &= ~0x4;
+
+	/* Enable CCFL backlighting circuit */
+	PBDIR |= 0x20;
+	PBSEL |= 0x20;
+	PBDATA &= ~0x20;
+
+	/* contrast control register */
+	PFDIR |= 0x1;
+	PFSEL &= ~0x1;
+	PWMR = 0x037F;
+#endif
+}
diff --git a/arch/m68k/68000/m68328.c b/arch/m68k/68000/m68328.c
index 419751b15ec8..6a5cfc977150 100644
--- a/arch/m68k/68000/m68328.c
+++ b/arch/m68k/68000/m68328.c
@@ -25,9 +25,10 @@
 #include "bootlogo.h"
 #endif
 
+#include "m68328.h"
+
 /***************************************************************************/
 
-int m68328_hwclk(int set, struct rtc_time *t);
 
 /***************************************************************************/
 
diff --git a/arch/m68k/68000/m68328.h b/arch/m68k/68000/m68328.h
new file mode 100644
index 000000000000..f6047c3168d4
--- /dev/null
+++ b/arch/m68k/68000/m68328.h
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+void init_dragen2(char *command, int size);
+void init_ucsimm(char *command, int size);
+struct rtc_time;
+int m68328_hwclk(int set, struct rtc_time *t);
diff --git a/arch/m68k/68000/m68EZ328.c b/arch/m68k/68000/m68EZ328.c
index 05f137dc257e..65bd112285ef 100644
--- a/arch/m68k/68000/m68EZ328.c
+++ b/arch/m68k/68000/m68EZ328.c
@@ -24,9 +24,7 @@
 #include <asm/bootstd.h>
 #endif
 
-/***************************************************************************/
-
-int m68328_hwclk(int set, struct rtc_time *t);
+#include "m68328.h"
 
 /***************************************************************************/
 
@@ -44,29 +42,12 @@ void m68ez328_reset(void)
 
 /***************************************************************************/
 
-unsigned char *cs8900a_hwaddr;
-static int errno;
-
-#ifdef CONFIG_UCSIMM
-_bsc0(char *, getserialnum)
-_bsc1(unsigned char *, gethwaddr, int, a)
-_bsc1(char *, getbenv, char *, a)
-#endif
-
 void __init config_BSP(char *command, int len)
 {
-  unsigned char *p;
-
   pr_info("68EZ328 DragonBallEZ support (C) 1999 Rt-Control, Inc\n");
 
 #ifdef CONFIG_UCSIMM
-  pr_info("uCsimm serial string [%s]\n", getserialnum());
-  p = cs8900a_hwaddr = gethwaddr(0);
-  pr_info("uCsimm hwaddr %pM\n", p);
-
-  p = getbenv("APPEND");
-  if (p) strcpy(p,command);
-  else command[0] = 0;
+  init_ucsimm(command, len);
 #endif
 
   mach_sched_init = hw_timer_init;
diff --git a/arch/m68k/68000/m68VZ328.c b/arch/m68k/68000/m68VZ328.c
index ada87b23afdc..025da5552f1c 100644
--- a/arch/m68k/68000/m68VZ328.c
+++ b/arch/m68k/68000/m68VZ328.c
@@ -32,101 +32,9 @@
 #include "bootlogo-vz.h"
 #endif
 
-/***************************************************************************/
-
-int m68328_hwclk(int set, struct rtc_time *t);
-
-/***************************************************************************/
-/*                        Init Drangon Engine hardware                     */
-/***************************************************************************/
-#if defined(CONFIG_DRAGEN2)
-
-static void m68vz328_reset(void)
-{
-	local_irq_disable();
-
-#ifdef CONFIG_INIT_LCD
-	PBDATA |= 0x20;				/* disable CCFL light */
-	PKDATA |= 0x4;				/* disable LCD controller */
-	LCKCON = 0;
-#endif
-
-	__asm__ __volatile__(
-		"reset\n\t"
-		"moveal #0x04000000, %a0\n\t"
-		"moveal 0(%a0), %sp\n\t"
-		"moveal 4(%a0), %a0\n\t"
-		"jmp (%a0)"
-	);
-}
-
-static void __init init_hardware(char *command, int size)
-{
-#ifdef CONFIG_DIRECT_IO_ACCESS
-	SCR = 0x10;					/* allow user access to internal registers */
-#endif
-
-	/* CSGB Init */
-	CSGBB = 0x4000;
-	CSB = 0x1a1;
-
-	/* CS8900 init */
-	/* PK3: hardware sleep function pin, active low */
-	PKSEL |= PK(3);				/* select pin as I/O */
-	PKDIR |= PK(3);				/* select pin as output */
-	PKDATA |= PK(3);			/* set pin high */
-
-	/* PF5: hardware reset function pin, active high */
-	PFSEL |= PF(5);				/* select pin as I/O */
-	PFDIR |= PF(5);				/* select pin as output */
-	PFDATA &= ~PF(5);			/* set pin low */
-
-	/* cs8900 hardware reset */
-	PFDATA |= PF(5);
-	{ int i; for (i = 0; i < 32000; ++i); }
-	PFDATA &= ~PF(5);
-
-	/* INT1 enable (cs8900 IRQ) */
-	PDPOL &= ~PD(1);			/* active high signal */
-	PDIQEG &= ~PD(1);
-	PDIRQEN |= PD(1);			/* IRQ enabled */
-
-#ifdef CONFIG_INIT_LCD
-	/* initialize LCD controller */
-	LSSA = (long) screen_bits;
-	LVPW = 0x14;
-	LXMAX = 0x140;
-	LYMAX = 0xef;
-	LRRA = 0;
-	LPXCD = 3;
-	LPICF = 0x08;
-	LPOLCF = 0;
-	LCKCON = 0x80;
-	PCPDEN = 0xff;
-	PCSEL = 0;
-
-	/* Enable LCD controller */
-	PKDIR |= 0x4;
-	PKSEL |= 0x4;
-	PKDATA &= ~0x4;
-
-	/* Enable CCFL backlighting circuit */
-	PBDIR |= 0x20;
-	PBSEL |= 0x20;
-	PBDATA &= ~0x20;
-
-	/* contrast control register */
-	PFDIR |= 0x1;
-	PFSEL &= ~0x1;
-	PWMR = 0x037F;
-#endif
-}
+#include "m68328.h"
 
 /***************************************************************************/
-/*                      Init RT-Control uCdimm hardware                    */
-/***************************************************************************/
-#elif defined(CONFIG_UCDIMM)
-
 static void m68vz328_reset(void)
 {
 	local_irq_disable();
@@ -139,51 +47,21 @@ static void m68vz328_reset(void)
 	);
 }
 
-unsigned char *cs8900a_hwaddr;
-static int errno;
-
-_bsc0(char *, getserialnum)
-_bsc1(unsigned char *, gethwaddr, int, a)
-_bsc1(char *, getbenv, char *, a)
-
-static void __init init_hardware(char *command, int size)
-{
-	char *p;
-
-	pr_info("uCdimm serial string [%s]\n", getserialnum());
-	p = cs8900a_hwaddr = gethwaddr(0);
-	pr_info("uCdimm hwaddr %pM\n", p);
-	p = getbenv("APPEND");
-	if (p)
-		strcpy(p, command);
-	else
-		command[0] = 0;
-}
-
-/***************************************************************************/
-#else
-
-static void m68vz328_reset(void)
-{
-}
-
-static void __init init_hardware(char *command, int size)
-{
-}
-
-/***************************************************************************/
-#endif
 /***************************************************************************/
 
 void __init config_BSP(char *command, int size)
 {
 	pr_info("68VZ328 DragonBallVZ support (c) 2001 Lineo, Inc.\n");
 
-	init_hardware(command, size);
-
 	mach_sched_init = hw_timer_init;
 	mach_hwclk = m68328_hwclk;
 	mach_reset = m68vz328_reset;
+
+#ifdef CONFIG_UCDIMM
+	init_ucsimm(command, len);
+#elif defined(CONFIG_DRAGEN2)
+	init_dragen2(command, len);
+#endif
 }
 
 /***************************************************************************/
diff --git a/arch/m68k/68000/ucsimm.c b/arch/m68k/68000/ucsimm.c
new file mode 100644
index 000000000000..7c6cbf643712
--- /dev/null
+++ b/arch/m68k/68000/ucsimm.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1993 Hamish Macdonald
+ *  Copyright (C) 1999 D. Jeff Dionne
+ *  Copyright (C) 2001 Georges Menie, Ken Desmet
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <asm/bootstd.h>
+#include <asm/machdep.h>
+#include <asm/MC68VZ328.h>
+
+
+#include "m68328.h"
+
+unsigned char *cs8900a_hwaddr;
+static int errno;
+
+_bsc0(char *, getserialnum)
+_bsc1(unsigned char *, gethwaddr, int, a)
+_bsc1(char *, getbenv, char *, a)
+
+void __init init_ucsimm(char *command, int size)
+{
+	char *p;
+
+	pr_info("uCsimm/uCdimm serial string [%s]\n", getserialnum());
+	p = cs8900a_hwaddr = gethwaddr(0);
+	pr_info("uCsimm/uCdimm hwaddr %pM\n", p);
+	p = getbenv("APPEND");
+	if (p)
+		strcpy(p, command);
+	else
+		command[0] = 0;
+}
-- 
2.27.0

