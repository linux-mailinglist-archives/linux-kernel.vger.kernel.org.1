Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B278929EBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJ2M1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:27:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6931 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgJ2M1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:27:39 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMPpg3wmWz70Xj;
        Thu, 29 Oct 2020 20:27:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 20:27:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/4] clocksource/drivers/sp804: Make some symbol static
Date:   Thu, 29 Oct 2020 20:33:14 +0800
Message-ID: <20201029123317.90286-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clocksource/timer-sp804.c:38:31: warning: symbol 'arm_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:47:31: warning: symbol 'hisi_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:120:12: warning: symbol 'sp804_clocksource_and_sched_clock_init' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:219:12: warning: symbol 'sp804_clockevents_init' was not declared. Should it be static?

And move __initdata after the variables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 6e8ad4a4ea3c..43d31bf09a18 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -34,8 +34,7 @@
 #define HISI_TIMER_BGLOAD	0x20
 #define HISI_TIMER_BGLOAD_H	0x24
 
-
-struct sp804_timer __initdata arm_sp804_timer = {
+static struct sp804_timer arm_sp804_timer __initdata = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
 	.ctrl		= TIMER_CTRL,
@@ -44,7 +43,7 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
-struct sp804_timer __initdata hisi_sp804_timer = {
+static struct sp804_timer hisi_sp804_timer __initdata = {
 	.load		= HISI_TIMER_LOAD,
 	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
@@ -117,7 +116,7 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
 
-int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
+static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						  const char *name,
 						  struct clk *clk,
 						  int use_sched_clock)
@@ -216,7 +215,7 @@ static struct clock_event_device sp804_clockevent = {
 	.rating			= 300,
 };
 
-int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+static int __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 				  struct clk *clk, const char *name)
 {
 	struct clock_event_device *evt = &sp804_clockevent;
-- 
2.26.2

