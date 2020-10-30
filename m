Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB502A0999
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgJ3PU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgJ3PUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:20:00 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6395722249;
        Fri, 30 Oct 2020 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604071145;
        bh=PhzarcZdxvr8JzCPKjAwfHGDJNezhF1oA5Gxqya2WxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5ed3u+GT93CiIJpo4CV6B2Kf2eTdhI6CogSdoTb8qOL4XKTcGxynAdZovmqEp9YU
         ywATfDwGaG7cWlJO557E8AUR7xCttz8fxCfIDapJLwr4YK5B0I6YYzXEcFz1PYgNBV
         7enPMF3AaKBrq+4c4M96Obarw9GsEHORFB3LRBrc=
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
Subject: [PATCH v2 10/15] m68k: sun3/sun3c: use legacy_timer_tick
Date:   Fri, 30 Oct 2020 16:17:53 +0100
Message-Id: <20201030151758.1241164-11-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030151758.1241164-1-arnd@kernel.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These two are different from all other machines:

* sun3 does not call timer_routine() but open-codes it
  except for the profile_tick() call that appears to
  be unintentionally missing.

* sun3x has a commented-out timer irq handler but no
  functional timer tick I could find.

Change both to calling the new legacy_timer_tick here,
which includes the call to profile_tick() but does not
fix sun3x as that is still commented out.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/Kconfig.machine | 2 ++
 arch/m68k/sun3/sun3ints.c | 3 +--
 arch/m68k/sun3x/time.c    | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 17e8c3a292d7..e3c835440d9a 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -99,6 +99,7 @@ config HP300
 config SUN3X
 	bool "Sun3x support"
 	depends on MMU
+	select LEGACY_TIMER_TICK
 	select MMU_MOTOROLA if MMU
 	select M68030
 	help
@@ -126,6 +127,7 @@ config SUN3
 	depends on MMU
 	depends on !MMU_MOTOROLA
 	select MMU_SUN3 if MMU
+	select LEGACY_TIMER_TICK
 	select NO_DMA
 	select M68020
 	help
diff --git a/arch/m68k/sun3/sun3ints.c b/arch/m68k/sun3/sun3ints.c
index a5824abb4a39..41ae422119d3 100644
--- a/arch/m68k/sun3/sun3ints.c
+++ b/arch/m68k/sun3/sun3ints.c
@@ -73,8 +73,7 @@ static irqreturn_t sun3_int5(int irq, void *dev_id)
 #ifdef CONFIG_SUN3
 	intersil_clear();
 #endif
-	xtime_update(1);
-	update_process_times(user_mode(get_irq_regs()));
+	legacy_timer_tick(1);
 	cnt = kstat_irqs_cpu(irq, 0);
 	if (!(cnt % 20))
 		sun3_leds(led_pattern[cnt % 160 / 20]);
diff --git a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
index 9163294b0fb6..f6e25fdc008c 100644
--- a/arch/m68k/sun3x/time.c
+++ b/arch/m68k/sun3x/time.c
@@ -77,14 +77,13 @@ int sun3x_hwclk(int set, struct rtc_time *t)
 #if 0
 static irqreturn_t sun3x_timer_tick(int irq, void *dev_id)
 {
-	irq_handler_t timer_routine = dev_id;
 	unsigned long flags;
 
 	local_irq_save(flags);
 	/* Clear the pending interrupt - pulse the enable line low */
 	disable_irq(5);
 	enable_irq(5);
-	timer_routine(0, NULL);
+	legacy_timer_tick(1);
 	local_irq_restore(flags);
 
 	return IRQ_HANDLED;
-- 
2.27.0

