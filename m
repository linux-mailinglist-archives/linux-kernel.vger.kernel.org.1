Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2A2A0974
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgJ3PUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgJ3PUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:20:00 -0400
Received: from localhost.localdomain (HSI-KBW-46-223-126-90.hsi.kabel-badenwuerttemberg.de [46.223.126.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8CD2151B;
        Fri, 30 Oct 2020 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604071131;
        bh=PU/541LNe7KQVoj0GelP71V9M6lqpXqIzsKggfodUE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFLXIAKBFWVd9ecYM21HfZkJplkhfM3bZQ0R7PkQmzardEopUkKhAHjnTqwP+pTiP
         2ttCQBI7+h4XcDTtbVlBwD5898pA49vyxKPJujloUB4o6Gickc+yrGhBahg3+OgUsI
         pEYA6HGniIewW3Cg1KawLRzwLEB06wZJHC4s1qoA=
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 07/15] parisc: use legacy_timer_tick
Date:   Fri, 30 Oct 2020 16:17:50 +0100
Message-Id: <20201030151758.1241164-8-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201030151758.1241164-1-arnd@kernel.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd590
("parisc: Switch to generic sched_clock implementation"), but does not
appear to actually be using it, and instead calls the low-level
timekeeping functions directly.

Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
the newly added legacy_timer_tick() helper.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/features/time/clockevents/arch-support.txt | 2 +-
 arch/parisc/Kconfig                                      | 2 +-
 arch/parisc/kernel/time.c                                | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 8287b6aa522e..61a5c9d68c15 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -21,7 +21,7 @@
     |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: |  ok  |
+    |      parisc: | TODO |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b234e8154cbd..78b17621ee4a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -52,7 +52,7 @@ config PARISC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select GENERIC_SCHED_CLOCK
 	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
-	select GENERIC_CLOCKEVENTS
+	select LEGACY_TIMER_TICK
 	select CPU_NO_EFFICIENT_FFS
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index 13d94f0f94a0..08e4d480abe1 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -70,8 +70,6 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void *dev_id)
 	/* gcc can optimize for "read-only" case with a local clocktick */
 	unsigned long cpt = clocktick;
 
-	profile_tick(CPU_PROFILING);
-
 	/* Initialize next_tick to the old expected tick time. */
 	next_tick = cpuinfo->it_value;
 
@@ -86,10 +84,9 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void *dev_id)
 	cpuinfo->it_value = next_tick;
 
 	/* Go do system house keeping. */
-	if (cpu == 0)
-		xtime_update(ticks_elapsed);
-
-	update_process_times(user_mode(get_irq_regs()));
+	if (cpu != 0)
+		ticks_elapsed = 0;
+	legacy_timer_tick(ticks_elapsed);
 
 	/* Skip clockticks on purpose if we know we would miss those.
 	 * The new CR16 must be "later" than current CR16 otherwise
-- 
2.27.0

