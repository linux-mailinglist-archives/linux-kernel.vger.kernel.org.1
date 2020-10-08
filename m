Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D602877F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbgJHPsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgJHPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:49 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MFbmS-1k9SJ504kA-00H3b3; Thu, 08 Oct 2020 17:48:09 +0200
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
Subject: [PATCH 08/13] m68k: m68328: use legacy_timer_tick()
Date:   Thu,  8 Oct 2020 17:46:46 +0200
Message-Id: <20201008154651.1901126-9-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X94e4tE6h1ucE2ptsUxdCsFjY5Vt4Yxb8o2F6d+WCVsxW3/pMXg
 FSX762vrq4q7eZ/50hBxTz/TSg4JHk9WT8w2l5djQmOGWFTvkaMwMOKxbJHu0yBszQ/wLF9
 w8OAHadLWVgTzZ4+T9le/sPTI6CdGiJMJZGRacnqSQDG8Mfh/Bo4RRtSxrQju/Gu1WgZrdO
 P81KGjziyKRQaHc8+bi7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZX3P9KuXIw=:RlCKXSHeShn4FJEVlMGuL8
 K/aJCs3QddlZYJRHnyZ4t/Pa4oGfXCF79wf/KHA5fssa/SOnPhNw/rV69J0NefDyw1Z7XajrW
 Gigo1IAyBHWzwyH0ceCSFrMn4BiKZRVwrGGXsJEHP3YEoaNAX07MaYmBw9g+75ufMsowTrjR/
 4vfLnmXbv1+r4Za1/PrIPvrg71rPL7kh2PmNaXMGdj/WUhG+2+ykWCxoiRcfcY9jCmo9IOoGh
 qIxTfvFcKzwjRKpQCgLWxG+KYophSkeylusJML1y6ccJWUG+Qcrd5kLtfUFUStchrd4RVqATJ
 supGqhInRtECv2NX6R0CKNQboZ27f1b/7zbaC2LQtbnpvX2IIFd+guKZCwqEGtLXQlLXyLDZW
 496wwMZRPCYihJkKon12c76/PXonZ7xcf6e1a0H/jnsTKW9UmFu93RdC13LVbXE01e17IVwFE
 K5r+mdqsknPcEFbHQd41irWcrVax4ScHJ7MOmDjPVowkodd5vNxspEbru5eh/E01uAy3z0BoB
 Fr17rxcpGpuFh1SipceLToKFWGdZ6nOFDkTi5As0RcSGGU5fGXPFrFSB8SRs3SnSjaxhuba/8
 w5tQ3uNjA+FSjURhyDsPNUx2IF+w1wz+IZP0ifMgPUupPo+JPY4/uQmCw6NbAnJVg4KvieFJA
 n+yFNexWC3vi9gDo+TSHLqfpIY7ZbHOsXNRF/P4t63VYvfbIicSYwNQ6xnGYxkuZ+uomTZT70
 hswbhza1vTpRnTNuy5u3NCSP+++jigRvTBIrTQsUB+cOnW+P34CBqAADz4orO9lnRndyibVqj
 P3A5NDBTaS6Qpj7orts+Y7ASc081u53+K3gPaHeltGUn2wTyyZtgUkb8LXQM+4JqM5/oHjV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of machines share the m68328 timer code that
is based on calling timer_interrupt(). Change these
to the new and slightly more generic legacy_timer_tick()
helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/68000/timers.c  | 5 ++---
 arch/m68k/Kconfig.machine | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
index e8dfdd2556a5..3aa006f8e7ea 100644
--- a/arch/m68k/68000/timers.c
+++ b/arch/m68k/68000/timers.c
@@ -52,7 +52,6 @@
 #endif
 
 static u32 m68328_tick_cnt;
-static irq_handler_t timer_interrupt;
 
 /***************************************************************************/
 
@@ -62,7 +61,8 @@ static irqreturn_t hw_tick(int irq, void *dummy)
 	TSTAT &= 0;
 
 	m68328_tick_cnt += TICKS_PER_JIFFY;
-	return timer_interrupt(irq, dummy);
+	legacy_timer_tick(1);
+	return IRQ_HANDLED;
 }
 
 /***************************************************************************/
@@ -113,7 +113,6 @@ void hw_timer_init(irq_handler_t handler)
 	/* Enable timer 1 */
 	TCTL |= TCTL_TEN;
 	clocksource_register_hz(&m68328_clk, TICKS_PER_JIFFY*HZ);
-	timer_interrupt = handler;
 }
 
 /***************************************************************************/
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index e3c835440d9a..0ff9338b958e 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -146,6 +146,7 @@ config PILOT
 config PILOT3
 	bool "Pilot 1000/5000, PalmPilot Personal/Pro, or PalmIII support"
 	depends on M68328
+	select LEGACY_TIMER_TICK
 	select PILOT
 	help
 	  Support for the Palm Pilot 1000/5000, Personal/Pro and PalmIII.
@@ -159,18 +160,21 @@ config XCOPILOT_BUGS
 config UCSIMM
 	bool "uCsimm module support"
 	depends on M68EZ328
+	select LEGACY_TIMER_TICK
 	help
 	  Support for the Arcturus Networks uCsimm module.
 
 config UCDIMM
 	bool "uDsimm module support"
 	depends on M68VZ328
+	select LEGACY_TIMER_TICK
 	help
 	  Support for the Arcturus Networks uDsimm module.
 
 config DRAGEN2
 	bool "DragenEngine II board support"
 	depends on M68VZ328
+	select LEGACY_TIMER_TICK
 	help
 	  Support for the DragenEngine II board.
 
-- 
2.27.0

