Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64962DEDFC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgLSJ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 04:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgLSJ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 04:26:13 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix timer cleanup regression
Date:   Sat, 19 Dec 2020 10:24:42 +0100
Message-Id: <20201219092516.1364230-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A cleanup patch from my legacy timer series broke ia64 and led
to RCU stall errors and a fast system clock:

[  909.360108] INFO: task systemd-sysv-ge:200 blocked for more than 127 seconds.
[  909.360108]       Not tainted 5.10.0+ #130
[  909.360108] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  909.360108] task:systemd-sysv-ge state:D stack:    0 pid:  200 ppid:   189 flags:0x00000000
[  909.364108]
[  909.364108] Call Trace:
[  909.364423]  [<a00000010109b210>] __schedule+0x890/0x21e0
[  909.364423]                                 sp=e0000100487d7b70 bsp=e0000100487d1748
[  909.368423]  [<a00000010109cc00>] schedule+0xa0/0x240
[  909.368423]                                 sp=e0000100487d7b90 bsp=e0000100487d16e0
[  909.368558]  [<a00000010109ce70>] io_schedule+0x70/0xa0
[  909.368558]                                 sp=e0000100487d7b90 bsp=e0000100487d16c0
[  909.372290]  [<a00000010109e1c0>] bit_wait_io+0x20/0xe0
[  909.372290]                                 sp=e0000100487d7b90 bsp=e0000100487d1698
[  909.374168] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  909.376290]  [<a00000010109d860>] __wait_on_bit+0xc0/0x1c0
[  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1648
[  909.374168] rcu:     3-....: (2 ticks this GP) idle=19e/1/0x4000000000000002 softirq=1581/1581 fqs=2
[  909.374168]  (detected by 0, t=5661 jiffies, g=1089, q=3)
[  909.376290]  [<a00000010109da80>] out_of_line_wait_on_bit+0x120/0x140
[  909.376290]                                 sp=e0000100487d7b90 bsp=e0000100487d1610
[  909.374168] Task dump for CPU 3:
[  909.374168] task:khungtaskd      state:R  running task

Revert most of my patch to make this work again, including the extra
update_process_times()/profile_tick() and the local_irq_enable() in the
loop that I expected not to be needed here.

I have not found out exactly what goes wrong, and would suggest that
someone with hardware access tries to convert this code into a singleshot
clockevent driver, which should give better behavior in all cases.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Fixes: 2b49ddcef297 ("ia64: convert to legacy_timer_tick")
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/time.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 9431edb08508..e3d9c8088d56 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -161,29 +161,34 @@ void vtime_account_idle(struct task_struct *tsk)
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id)
 {
-	unsigned long cur_itm, new_itm, ticks;
+	unsigned long new_itm;
 
 	if (cpu_is_offline(smp_processor_id())) {
 		return IRQ_HANDLED;
 	}
 
 	new_itm = local_cpu_data->itm_next;
-	cur_itm = ia64_get_itc();
 
-	if (!time_after(cur_itm, new_itm)) {
+	if (!time_after(ia64_get_itc(), new_itm))
 		printk(KERN_ERR "Oops: timer tick before it's due (itc=%lx,itm=%lx)\n",
-		       cur_itm, new_itm);
-		ticks = 1;
-	} else {
-		ticks = DIV_ROUND_UP(cur_itm - new_itm,
-				     local_cpu_data->itm_delta);
-		new_itm += ticks * local_cpu_data->itm_delta;
-	}
+		       ia64_get_itc(), new_itm);
+
+	while (1) {
+		new_itm += local_cpu_data->itm_delta;
+
+		legacy_timer_tick(smp_processor_id() == time_keeper_id);
 
-	if (smp_processor_id() != time_keeper_id)
-		ticks = 0;
+		local_cpu_data->itm_next = new_itm;
 
-	legacy_timer_tick(ticks);
+		if (time_after(new_itm, ia64_get_itc()))
+			break;
+
+		/*
+		 * Allow IPIs to interrupt the timer loop.
+		 */
+		local_irq_enable();
+		local_irq_disable();
+	}
 
 	do {
 		/*
-- 
2.29.2

