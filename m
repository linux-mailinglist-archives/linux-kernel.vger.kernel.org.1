Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFD2A24D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKBGiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:38:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:38:22 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CPjsm0dsYzhfSg;
        Mon,  2 Nov 2020 14:38:20 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 14:38:12 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <koct9i@gmail.com>, <xuqiang36@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] kernel/watchdog_hld.c: Complete the flush of the hard deadlock log messages to the serial port
Date:   Mon, 2 Nov 2020 06:38:03 +0000
Message-ID: <20201102063803.17438-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when hardlockup_all_cpu_backtrace is on, and there are
a large number of cores in the system, it takes
a long time to output the hard deadlock logs of all cores
to the serial port. When the console_flush_on_panic function
in panic is executed, console_locked is still held.
As a result, garbled characters are displayed in the serial port log.

To solve this problem, wait for a maximum of 10s for the serial port
to be released before entering the panic mode.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 kernel/watchdog_hld.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index a546bc54f6ff..d3410b9fd3c3 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -13,8 +13,10 @@
 #define pr_fmt(fmt) "NMI watchdog: " fmt
 
 #include <linux/nmi.h>
+#include <linux/delay.h>
 #include <linux/atomic.h>
 #include <linux/module.h>
+#include <linux/console.h>
 #include <linux/sched/debug.h>
 
 #include <asm/irq_regs.h>
@@ -129,6 +131,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	 * then this is a good indication the cpu is stuck
 	 */
 	if (is_hardlockup()) {
+		int i;
 		int this_cpu = smp_processor_id();
 
 		/* only print hardlockups once */
@@ -151,9 +154,15 @@ static void watchdog_overflow_callback(struct perf_event *event,
 		if (sysctl_hardlockup_all_cpu_backtrace &&
 				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
 			trigger_allbutself_cpu_backtrace();
-
-		if (hardlockup_panic)
+		if (hardlockup_panic) {
+			/* Wait for all CPUs to complete wake_up_klogd_work_func */
+			for (i = 0; i < 10 * 1000; i++) {
+				if (console_trylock())
+					break;
+				mdelay(1);
+			}
 			nmi_panic(regs, "Hard LOCKUP");
+		}
 		atomic_inc(&hardlockup_detected);
 
 		__this_cpu_write(hard_watchdog_warn, true);
-- 
2.25.0

