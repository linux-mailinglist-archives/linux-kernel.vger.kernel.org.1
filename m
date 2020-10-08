Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2F4287801
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgJHPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 11:49:27 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgJHPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:49:21 -0400
Received: from localhost.localdomain ([192.30.34.233]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MStT6-1jwLIa42la-00ULFd; Thu, 08 Oct 2020 17:48:43 +0200
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
Subject: [RFC 13/13] m68k: mac: convert to generic clockevent
Date:   Thu,  8 Oct 2020 17:46:51 +0200
Message-Id: <20201008154651.1901126-14-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201008154651.1901126-1-arnd@arndb.de>
References: <20201008154651.1901126-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t2TT0Gg6iZNzNSgl+OLD57/ppw5gg1Qso/eeRLVLEYaTBf/jIqQ
 Hjytsid5qWOgO94sXb2HqufDu6sYujxasZU8I0d6fpbSQ3aPXdulhuhjy1hT49RzBos4jzD
 TAn0VTtO47u4tnZhkeNMXUv9noQBvjvT6/jveq0eVE28BolhK15dXE6GaGQHpS+2wQbV7+C
 u0hUaI+Xe6zAY/NJfNthg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gXB8YuDxJok=:EX4k3kZ8QtbIajiEgQTjiv
 SxHIuk7BFtV13qQjcBtlTsbXwtVoVK8kQhARoOlwilggxhieawtrezJt3Nn/X5O7tByqjdCC0
 BF62tpUUIYAbDtBIVIyZL2hUzvGMBZNsEbCoqkY9JNhrpx9qZIHES7A8RwQ3xHrexkILfIFta
 ySe2T7/BEMRY7zaRt35YvBZwbB2RYMnEHD4/epdU+npcF0vqxHlZ8EGd349xDSIQkFZLZ5/Qd
 A6jnQYe7kQEHk2S9vzlaQOLax2NzPVWqx2qJ8khlWwesz67wbkkbpL0Dia4r2XK7k5JK1j+1D
 OMulG+KxbdmVVTvwvWNoHtad5bJVLSuGm2XUP6X+H61R+j+K8DXxGPjyevNrwIRaX6RLhZxQP
 zqis6uJwcdAddHd2+B9sXPL6z4eBoA1GmBGjW/SJD50AJACvQ4E0e/0i2tHiNHS0rnm3bJLBJ
 lwrq4bHMoSrC7PqyJ7+CBr3egpqFuksOiesZ1mQdOw3OPSAD6kA3Yr0hajcJyhVUXPycwhCVN
 C++u17zvMBTUP/mYPIpUdEBDhmSi38cn4WzhKDeC3hciNlHjXobBSdiixilXs3+Dw4XeCYSVz
 7Jy4BI50XcOxXCsnDEB4OPfSY3lqmAlyfxuSOW71Bbyl2aq4pE3hKYNiEQgx7M9GbLDsZCOhK
 /hwCC8rZXxH5x7+rCA0y7WcXnU+HjxGdER3IrB1Y5dZA3PXErgwUwwS2FAj8rlOKAMDs2zlVj
 BCQFJHvQcyP0SVgL+KsIAIoC2cONpmrqvhYyJ8KXY4ZKZCPOXJYlz2xx0MLLHvLC31pYlmJdM
 gh3zpYEZMSfwruQm5IBEZRtnKPMy9488EKTQyfQYASbr3lI25bzfMveHN011XHRSJ3ZPMfJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the infrastructure allows kernels to have both legacy timer
ticks and clockevent drivers in the same image, start by moving one
platform to generic clockevents.

As qemu only supports the q800 platform among the classic m68k, use
that as an example.

I also tried adding oneshot mode, which was successful but broke
the clocksource. It's probably not hard to make it work properly,
but this is where I've stopped.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have never tried implementing a clockevent or clocksource
driver in the past, so this is really just an experiment and
I expect I got something wrong.


 arch/m68k/Kconfig.machine |  2 +-
 arch/m68k/mac/via.c       | 44 ++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 8a4e8bd8aade..cccabdad618e 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -30,7 +30,7 @@ config MAC
 	depends on MMU
 	select MMU_MOTOROLA if MMU
 	select HAVE_ARCH_NVRAM_OPS
-	select LEGACY_TIMER_TICK
+	select GENERIC_CLOCKEVENTS
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 8ad734e3c934..dd4c13c318b6 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -602,27 +603,54 @@ static u32 clk_total, clk_offset;
 
 static irqreturn_t via_timer_handler(int irq, void *dev_id)
 {
+	struct clock_event_device *evt = dev_id;
+
 	clk_total += VIA_TIMER_CYCLES;
 	clk_offset = 0;
-	legacy_timer_tick(1);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
 
-void __init via_init_clock(void)
+static int via_set_periodic(struct clock_event_device *evt)
 {
-	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, IRQF_TIMER, "timer",
-			NULL)) {
-		pr_err("Couldn't register %s interrupt\n", "timer");
-		return;
-	}
-
 	via1[vT1LL] = VIA_TC_LOW;
 	via1[vT1LH] = VIA_TC_HIGH;
 	via1[vT1CL] = VIA_TC_LOW;
 	via1[vT1CH] = VIA_TC_HIGH;
 	via1[vACR] |= 0x40;
 
+	return 0;
+}
+
+static int via_set_shutdown(struct clock_event_device *evt)
+{
+	via1[vACR] &= ~0x40;
+
+	return 0;
+}
+
+static struct clock_event_device via_clk_event = {
+	.name	= "via1",
+	.rating = 250,
+	.irq	= IRQ_MAC_TIMER_1,
+	.owner	= THIS_MODULE,
+
+	.features		= CLOCK_EVT_FEAT_PERIODIC,
+	.set_state_shutdown	= via_set_shutdown,
+	.set_state_periodic	= via_set_periodic,
+};
+
+void __init via_init_clock(void)
+{
+	clockevents_config_and_register(&via_clk_event, VIA_CLOCK_FREQ, 1, 0xffff);
+
+	if (request_irq(IRQ_MAC_TIMER_1, via_timer_handler, IRQF_TIMER, "timer",
+			&via_clk_event)) {
+		pr_err("Couldn't register %s interrupt\n", "timer");
+		return;
+	}
+
 	clocksource_register_hz(&mac_clk, VIA_CLOCK_FREQ);
 }
 
-- 
2.27.0

