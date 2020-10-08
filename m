Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E22877F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbgJHPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:48:52 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgJHPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:48:50 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mc0Aj-1kvldN13hX-00dWMm; Thu, 08 Oct 2020 17:48:03 +0200
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
Subject: [PATCH 07/13] m68k: sun3/sun3c: use legacy_timer_tick
Date:   Thu,  8 Oct 2020 17:46:45 +0200
Message-Id: <20201008154651.1901126-8-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zzQepl59kGHqC31NpC7bG+PeDhhMCTHQVd0gy+gcmjQuJwPro/e
 YgST2M/5bg8pOnYtalrizCt/CQyfRU+vMCZDSUytu+vPazaG4fAxasAdlunS51IYkSBYlio
 iPqKfp3Ni+6XHGef7N1RuGA1HbD8Bj6TL8ALg1RiJsRZLOv9XJUGmO2imGEXPXrvBfzClTK
 ZAePO58Y6+u0ShYOmkmbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VCTA03n0EEU=:F2qbphEYNVKx6MJTqdbPS9
 8XM2b9J+zhO6UDLal5j3YrCnsMUxDdJxYBaNUcsRTQ50xeOEYAta4l2IPNxQSpYjQW5t/ydFc
 oLCOg7bQJ/MrIFK1/PKD1yW5HMMSFGHmKNFVaV+61PV4O3WwHJoWAhOnOmtRXOoM7pjW/qyAY
 y6A08V3bvjAnGOWn+dhu8i4PTeG+zHOIZbn0uOKj3A08KrinOovfDrJq0SKSzH7uZXsgeh8iq
 ToLrCTD60CE6Rjv+5MIFFRjFydwUurD4CLFnhCCb0ti/Hfhz8GmACo+PJjg0iGr/9dFjCEBoJ
 q7MgBIx3cFt5CA+uCEarAjCXnWh0qdMQJcF3VZUy1iSQqJSEYPqhcAvfcQ3N4DegjK73H+g+n
 3XrHPgIW3FBIEUGmqZTQHgkqA8Y/zSX+59SaE2SIC65pOHaPoYCQcB1QdZ+4xX735HeZFfJ85
 zdikSNwG+1vfTMCev89+QsrYDGYep1hUlU1EZ44dWzZLWWbyDzk62Kn0QnKZiFABMlF+uc+sI
 U0ZKZFcYeHfzL87AFsCQlyNNWqRRv+/sPRhvgYVmFinY+pUz7tmkRJeoPngeAH6cAlUIvnXUE
 r5huH7yKmGaqxZ2vGUqHHOcYugSn+y0aHJE4hcA4FLUegviVCy9Q1h5FOsWdsVWfwntp5GzG5
 HcE3seAhPVXL7OB4N/KU2Y8epU4W0XNvUUWV6AJ0vfOuwwdhymaOXjphbvzY+PrxaMsk30ept
 9t/01z/QE2X9pNLvqNr5kgaqWiAq8HhGu6Z8s02Pr5CYEVUnrm2os6W2MnDulbkL46Y65IQAW
 aGK4w26/nvMdyCrpo6U45G4k+/M+lhSqScEFjggjoU9EF5AiAeRqMeFBXBF3mF6ryjud+PD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two are different from all other machines:

* sun3 does not call timer_routine() but open-codes it
  except for the profile_tick() call that appears to
  be unintentionally missing.

* sun3x has a commented-out timer irq handler but no
  functional timer tick I could find.

Change both to calling the new legacy_timer_tick here,
which includes the call to profile_tick() but does not
fix sun3x as that is still commented out.

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

