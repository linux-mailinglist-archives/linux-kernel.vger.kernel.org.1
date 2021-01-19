Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2022A2FB88D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbhASNGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:06:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17491 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393603AbhASNAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611061246; x=1642597246;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=sk1rMyQfSku9eJoVG8ckn+sXbfP9b95FJk80FI5Fcis=;
  b=REzZye40FhWufgtgAEjygZ/rDC6w11uwyhVi0+7FVxhesW2R/p5uDGBi
   k5V60HTkWEFuFUKV3fSO0WtX9QTT8MSteoDOXTJ4+ZJKf1Myr4jxNajh9
   2PfmoTwy7ssss+QJPAhdrKhl3fgjQKD3+M5ZmsLsTf/KQQnP1HMjSkdK2
   rLTvvCe3Am1Ubw+si67JawGS8P33u//D/L3prCXGzN9fwoOceDrORidmo
   aKd7Joq1kEQpLez8tC1oesSZJCCoua78nG9bBPQqQQDpDfoy7K0Sxx06k
   aTwSBCgaKY4pV/tFo82f4zJYF+nGlZgLEXBZqJX39UHk/FidaRI0Cfx6c
   g==;
IronPort-SDR: TE6T3MbXWFrTDKDch6BGsUNSFfdzTamPv2Tk50JAwLVcbzQhnALBaU9/Mf94e/di4x7xQGpUcH
 T8b02FvzFTcr68cjqIkPUxG7RwnNEeq/kZOX5Hyjpz1BGQhd2WCbIq71zNSv8HxQ501ysnsKpR
 zY+LwyFhjZOfLqZLGO9/iNLIloMAZz4/atRY3GkAWUwtXSJsnN2rfsbQYrrrurQV6kvUK5ZvFy
 UTJnSCaRrjXA7NW9/hmsqoQTEzef0zOYfQI9AaEE/ApnGiDHVRKxeh7DMs2JULTd1kbnou7ArF
 sfM=
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="111596710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jan 2021 05:59:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 19 Jan 2021 05:59:29 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 19 Jan 2021 05:59:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH] clocksource/drivers/timer-microchip-pit64b: add clocksource suspend/resume
Date:   Tue, 19 Jan 2021 14:59:25 +0200
Message-ID: <1611061165-30180-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for clocksource timer.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 86 +++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 59e11ca8ee73..ab623b25a47b 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -71,10 +71,24 @@ struct mchp_pit64b_clkevt {
 	struct clock_event_device	clkevt;
 };
 
-#define to_mchp_pit64b_timer(x) \
+#define clkevt_to_mchp_pit64b_timer(x) \
 	((struct mchp_pit64b_timer *)container_of(x,\
 		struct mchp_pit64b_clkevt, clkevt))
 
+/**
+ * mchp_pit64b_clksrc - PIT64B clocksource data structure
+ * @timer: PIT64B timer
+ * @clksrc: clocksource
+ */
+struct mchp_pit64b_clksrc {
+	struct mchp_pit64b_timer	timer;
+	struct clocksource		clksrc;
+};
+
+#define clksrc_to_mchp_pit64b_timer(x) \
+	((struct mchp_pit64b_timer *)container_of(x,\
+		struct mchp_pit64b_clksrc, clksrc))
+
 /* Base address for clocksource timer. */
 static void __iomem *mchp_pit64b_cs_base;
 /* Default cycles for clockevent timer. */
@@ -116,6 +130,36 @@ static inline void mchp_pit64b_reset(struct mchp_pit64b_timer *timer,
 	writel_relaxed(MCHP_PIT64B_CR_START, timer->base + MCHP_PIT64B_CR);
 }
 
+static void mchp_pit64b_suspend(struct mchp_pit64b_timer *timer)
+{
+	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_disable_unprepare(timer->gclk);
+	clk_disable_unprepare(timer->pclk);
+}
+
+static void mchp_pit64b_resume(struct mchp_pit64b_timer *timer)
+{
+	clk_prepare_enable(timer->pclk);
+	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
+		clk_prepare_enable(timer->gclk);
+}
+
+static void mchp_pit64b_clksrc_suspend(struct clocksource *cs)
+{
+	struct mchp_pit64b_timer *timer = clksrc_to_mchp_pit64b_timer(cs);
+
+	mchp_pit64b_suspend(timer);
+}
+
+static void mchp_pit64b_clksrc_resume(struct clocksource *cs)
+{
+	struct mchp_pit64b_timer *timer = clksrc_to_mchp_pit64b_timer(cs);
+
+	mchp_pit64b_resume(timer);
+	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
+}
+
 static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
@@ -128,7 +172,7 @@ static u64 mchp_pit64b_sched_read_clk(void)
 
 static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
 
@@ -137,7 +181,7 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event_device *cedev)
 
 static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
@@ -148,7 +192,7 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock_event_device *cedev)
 static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
 					     struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
 	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
@@ -158,21 +202,16 @@ static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
 
 static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
-	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
-		clk_disable_unprepare(timer->gclk);
-	clk_disable_unprepare(timer->pclk);
+	mchp_pit64b_suspend(timer);
 }
 
 static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
 {
-	struct mchp_pit64b_timer *timer = to_mchp_pit64b_timer(cedev);
+	struct mchp_pit64b_timer *timer = clkevt_to_mchp_pit64b_timer(cedev);
 
-	clk_prepare_enable(timer->pclk);
-	if (timer->mode & MCHP_PIT64B_MR_SGCLK)
-		clk_prepare_enable(timer->gclk);
+	mchp_pit64b_resume(timer);
 }
 
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -296,20 +335,37 @@ static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
 static int __init mchp_pit64b_init_clksrc(struct mchp_pit64b_timer *timer,
 					  u32 clk_rate)
 {
+	struct mchp_pit64b_clksrc *cs;
 	int ret;
 
+	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
 	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
 
 	mchp_pit64b_cs_base = timer->base;
 
-	ret = clocksource_mmio_init(timer->base, MCHP_PIT64B_NAME, clk_rate,
-				    210, 64, mchp_pit64b_clksrc_read);
+	cs->timer.base = timer->base;
+	cs->timer.pclk = timer->pclk;
+	cs->timer.gclk = timer->gclk;
+	cs->timer.mode = timer->mode;
+	cs->clksrc.name = MCHP_PIT64B_NAME;
+	cs->clksrc.mask = CLOCKSOURCE_MASK(64);
+	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	cs->clksrc.rating = 210;
+	cs->clksrc.read = mchp_pit64b_clksrc_read;
+	cs->clksrc.suspend = mchp_pit64b_clksrc_suspend;
+	cs->clksrc.resume = mchp_pit64b_clksrc_resume;
+
+	ret = clocksource_register_hz(&cs->clksrc, clk_rate);
 	if (ret) {
 		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
 
 		/* Stop timer. */
 		writel_relaxed(MCHP_PIT64B_CR_SWRST,
 			       timer->base + MCHP_PIT64B_CR);
+		kfree(cs);
 
 		return ret;
 	}
-- 
2.7.4

