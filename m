Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE02A098E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgJ3PUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgJ3PUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:20:01 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1728B2224A;
        Fri, 30 Oct 2020 15:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604071150;
        bh=GMWfpBFvyWmdpvD5W/p2JKxKxss2ykxW3nbwOHA5BIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xDT3Y783NYX+tG7pWdWca/zrFnSprsM6qfu8QZFMPZoEuPGBW2xHqdzEh8CAx4NeA
         jvnONs0HFU6mJY6HBbiuXPalLPmGM9or7mYFQ3m10Zc+sH3dKkSi/LF/0fRyn0SElE
         5MLwWycQfi0CbL1vKogBaWCzLmpov/ll3Sq9P8Hc=
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
Subject: [PATCH v2 11/15] m68k: m68328: use legacy_timer_tick()
Date:   Fri, 30 Oct 2020 16:17:54 +0100
Message-Id: <20201030151758.1241164-12-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030151758.1241164-1-arnd@kernel.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A couple of machines share the m68328 timer code that
is based on calling timer_interrupt(). Change these
to the new and slightly more generic legacy_timer_tick()
helper.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/68000/timers.c | 5 ++---
 arch/m68k/Kconfig.cpu    | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

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
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 322a35ef14c6..648054d4f860 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -104,6 +104,7 @@ config M68060
 config M68328
 	bool "MC68328"
 	depends on !MMU
+	select LEGACY_TIMER_TICK
 	select M68000
 	help
 	  Motorola 68328 processor support.
@@ -111,6 +112,7 @@ config M68328
 config M68EZ328
 	bool "MC68EZ328"
 	depends on !MMU
+	select LEGACY_TIMER_TICK
 	select M68000
 	help
 	  Motorola 68EX328 processor support.
@@ -118,6 +120,7 @@ config M68EZ328
 config M68VZ328
 	bool "MC68VZ328"
 	depends on !MMU
+	select LEGACY_TIMER_TICK
 	select M68000
 	help
 	  Motorola 68VZ328 processor support.
-- 
2.27.0

