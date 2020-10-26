Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796792986DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770413AbgJZGbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:31:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770405AbgJZGbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:31:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKQ312ZNgz15MLn;
        Mon, 26 Oct 2020 14:31:25 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 26 Oct 2020 14:31:10 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux@armlinux.org.uk>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <vincent.whitchurch@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jpoimboe@redhat.com>,
        <bigeasy@linutronix.de>, <will.deacon@arm.com>
CC:     <wangle6@huawei.com>, <nixiaoming@huawei.com>
Subject: [PATCH] arm:traps:Don't dump the memory in non-system reset scenarios
Date:   Mon, 26 Oct 2020 14:31:06 +0800
Message-ID: <20201026063106.20744-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not dump the memory in non-system reset scenarios to prevent virtual
 address information leakage.

This patch follows x86 and arm64's lead and removes the "Exception stack:"
dump from kernel backtraces:
	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
	 PC/LR values in backtraces")
	commit 0ee1dd9f5e7eae ("x86/dumpstack: Remove raw stack dump")

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 arch/arm/kernel/traps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 911bbf164875..34e268378972 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -60,13 +60,9 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
-static void dump_mem(const char *, const char *, unsigned long, unsigned long);
-
 void dump_backtrace_entry(unsigned long where, unsigned long from,
 			  unsigned long frame, const char *loglvl)
 {
-	unsigned long end = frame + 4 + sizeof(struct pt_regs);
-
 #ifdef CONFIG_KALLSYMS
 	printk("%s (%ps) from (%pS)\n",
 		loglvl, (void *)where, (void *)from);
@@ -74,9 +70,6 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
 		loglvl, where, from);
 #endif
-
-	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
-		dump_mem(loglvl, "Exception stack", frame + 4, end);
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -125,6 +118,12 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
 	mm_segment_t fs;
 	int i;
 
+	/*
+	 * To prevent virtual address information leakage, memory
+	 * information cannot be printed in non-reset scenarios.
+	 */
+	if (panic_on_oops == 0)
+		return;
 	/*
 	 * We need to switch to kernel mode so that we can use __get_user
 	 * to safely read from kernel space.  Note that we now dump the
-- 
2.27.0

