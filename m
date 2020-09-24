Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D5276CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgIXJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgIXJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:06:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287A6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so2729330wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xg1oHl9LOhmlXEuxLDnZNfzuIsg/Lc3JKhh6ihrZ3Wk=;
        b=TLqJGuzKrrM2ibwSkkDI0ejtAX0jEbaIuuNVOTY0tnzcocTz/+1mL8S1VetSF1H/n6
         4e/b1hL2iWaGE4EVFM4ABE3RvC9qjCQ6Cik5JOFSnTVYAwvsYnU3QfQmL9yZUb+z5wwG
         Wbgbe4xHuqYXoLDmKSpmnPaR5kmzOOeJaH/rPtiyt4IlJDgAWuVl46/u9zPYt8uHbxvz
         oCQSJCM5Fg9Ejk8hfeXjbqcHSFB/GPdbo8anr7A3BJ3npSaJN3X329NT+9BLJc3XA6Ab
         RyILhLmg4Hz5RwV5MCDwob4Rn7C4mqKyVAx+3f06Vt3/Jy3jilTBj1miYRbjeSEx90lj
         e93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xg1oHl9LOhmlXEuxLDnZNfzuIsg/Lc3JKhh6ihrZ3Wk=;
        b=px9Ni00aC1kYsWj01vSo37Hs1J6+wOTxOo8aPNS/B5F7AtlwxUrQ0ZSWqMGD25/KC6
         fEeAAG0U59WUU2HA6ejr/lEfJJwwOo3kOSY9etrISGdgiTA9mZ9VYErRnHj+/StrjjVg
         SmT6cNAtBXC/jpPckAN20wltzC5kPUlgSwJsO/j9T6dXkFQgGIP+RepYcYxUBUl3xJAU
         CxBeV/sLQWwzrYe+4B/kzan3UrDcZWMX0c+KBksessci2Rg9qGIBqKDcUi0/hx08h6/y
         4dYP2ew/Z2Fjs4KyX40oihotMLDhlxdp2Rje+AZCpyddcxuMJKFriGAEBY1VKFJ6z6Lm
         RmEw==
X-Gm-Message-State: AOAM531h7JEbFQpaa+hfGg9/SycsqN27HozMmvhXpuZZD1oGd+wDnzjx
        yJUgF5NPITaPhcXUK3qKu1+NRw==
X-Google-Smtp-Source: ABdhPJy7huENXLsvMYeGhs2tR5gIfxhdLcpgS15991BUNuTiwSAwMT8dEfqtu2NgxP+s9CBFM1fc0A==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr3596226wmh.103.1600938370691;
        Thu, 24 Sep 2020 02:06:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:06:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 10/10] clocksource/drivers/sp804: Enable Hisilicon sp804 timer 64bit mode
Date:   Thu, 24 Sep 2020 11:05:34 +0200
Message-Id: <20200924090534.2004630-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
 <20200924090534.2004630-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

A 100MHZ 32-bit timer will be wrapped up less than 43s. Although the
kernel maintains a software high 32-bit count in the tick IRQ. But it's
not applicable to the user mode APPs.

Note: The kernel still uses the lower 32 bits of the timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200918132237.3552-9-thunder.leizhen@huawei.com
---
 drivers/clocksource/timer-sp.h    |  6 ++++++
 drivers/clocksource/timer-sp804.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 1ab75cbed0e0..811f840be0e5 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -33,12 +33,15 @@
 
 struct sp804_timer {
 	int load;
+	int load_h;
 	int value;
+	int value_h;
 	int ctrl;
 	int intclr;
 	int ris;
 	int mis;
 	int bgload;
+	int bgload_h;
 	int timer_base[NR_TIMERS];
 	int width;
 };
@@ -46,12 +49,15 @@ struct sp804_timer {
 struct sp804_clkevt {
 	void __iomem *base;
 	void __iomem *load;
+	void __iomem *load_h;
 	void __iomem *value;
+	void __iomem *value_h;
 	void __iomem *ctrl;
 	void __iomem *intclr;
 	void __iomem *ris;
 	void __iomem *mis;
 	void __iomem *bgload;
+	void __iomem *bgload_h;
 	unsigned long reload;
 	int width;
 };
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index f0783d19522f..6e8ad4a4ea3c 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -24,12 +24,15 @@
 #define HISI_TIMER_1_BASE	0x00
 #define HISI_TIMER_2_BASE	0x40
 #define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_LOAD_H	0x04
 #define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_VALUE_H	0x0c
 #define HISI_TIMER_CTRL		0x10
 #define HISI_TIMER_INTCLR	0x14
 #define HISI_TIMER_RIS		0x18
 #define HISI_TIMER_MIS		0x1c
 #define HISI_TIMER_BGLOAD	0x20
+#define HISI_TIMER_BGLOAD_H	0x24
 
 
 struct sp804_timer __initdata arm_sp804_timer = {
@@ -43,7 +46,9 @@ struct sp804_timer __initdata arm_sp804_timer = {
 
 struct sp804_timer __initdata hisi_sp804_timer = {
 	.load		= HISI_TIMER_LOAD,
+	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
+	.value_h	= HISI_TIMER_VALUE_H,
 	.ctrl		= HISI_TIMER_CTRL,
 	.intclr		= HISI_TIMER_INTCLR,
 	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
@@ -129,6 +134,10 @@ int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 	writel(0, clkevt->ctrl);
 	writel(0xffffffff, clkevt->load);
 	writel(0xffffffff, clkevt->value);
+	if (clkevt->width == 64) {
+		writel(0xffffffff, clkevt->load_h);
+		writel(0xffffffff, clkevt->value_h);
+	}
 	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
 		clkevt->ctrl);
 
@@ -245,7 +254,9 @@ static void __init sp804_clkevt_init(struct sp804_timer *timer, void __iomem *ba
 		clkevt = &sp804_clkevt[i];
 		clkevt->base	= timer_base;
 		clkevt->load	= timer_base + timer->load;
+		clkevt->load_h	= timer_base + timer->load_h;
 		clkevt->value	= timer_base + timer->value;
+		clkevt->value_h	= timer_base + timer->value_h;
 		clkevt->ctrl	= timer_base + timer->ctrl;
 		clkevt->intclr	= timer_base + timer->intclr;
 		clkevt->width	= timer->width;
-- 
2.25.1

