Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E317B267A17
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 13:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgILLqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 07:46:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgILLqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:46:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0CC02E65B348CF35A2AC;
        Sat, 12 Sep 2020 19:46:02 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 12 Sep 2020 19:45:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v2 7/9] clocksource: sp804: add support for Hisilicon sp804 timer
Date:   Sat, 12 Sep 2020 19:45:34 +0800
Message-ID: <20200912114536.2910-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200912114536.2910-1-thunder.leizhen@huawei.com>
References: <20200912114536.2910-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
it to 64-bit. That means, the registers: TimerXload, TimerXValue and
TimerXBGLoad are 64bits, all other registers are the same as those in the
SP804. The driver code can be completely reused except that the register
offset is different.

Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/clocksource/timer-sp.h    | 12 ++++++++++++
 drivers/clocksource/timer-sp804.c | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 1ab75cbed0e0..6ca8d82e8544 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -31,6 +31,18 @@
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
 
+
+#define HISI_TIMER_1_BASE	0x00
+#define HISI_TIMER_2_BASE	0x40
+#define HISI_TIMER_LOAD		0x00
+#define HISI_TIMER_VALUE	0x08
+#define HISI_TIMER_CTRL		0x10
+#define HISI_TIMER_INTCLR	0x14
+#define HISI_TIMER_RIS		0x18
+#define HISI_TIMER_MIS		0x1c
+#define HISI_TIMER_BGLOAD	0x20
+
+
 struct sp804_timer {
 	int load;
 	int value;
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 5f4f979a8ef2..3049f558c49b 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -29,6 +29,15 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
+struct sp804_timer __initdata hisi_sp804_timer = {
+	.load		= HISI_TIMER_LOAD,
+	.value		= HISI_TIMER_VALUE,
+	.ctrl		= HISI_TIMER_CTRL,
+	.intclr		= HISI_TIMER_INTCLR,
+	.timer_base	= {HISI_TIMER_1_BASE, HISI_TIMER_2_BASE},
+	.width		= 64,
+};
+
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
 
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
@@ -315,6 +324,12 @@ static int __init arm_sp804_of_init(struct device_node *np)
 }
 TIMER_OF_DECLARE(sp804, "arm,sp804", arm_sp804_of_init);
 
+static int __init hisi_sp804_of_init(struct device_node *np)
+{
+	return sp804_of_init(np, &hisi_sp804_timer);
+}
+TIMER_OF_DECLARE(hisi_sp804, "hisilicon,sp804", hisi_sp804_of_init);
+
 static int __init integrator_cp_of_init(struct device_node *np)
 {
 	static int init_count = 0;
-- 
2.26.0.106.g9fadedd


