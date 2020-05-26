Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1111CC1E3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEINtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 09:49:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4385 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbgEINtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:49:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1D5195B74FBBEA43C7F2;
        Sat,  9 May 2020 21:49:09 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 21:49:08 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <daniel.thompson@linaro.org>, <jason.wessel@windriver.com>,
        <dianders@chromium.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
        <mhiramat@kernel.org>, <davem@davemloft.net>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
Subject: [PATCH 1/4] arm64: kgdb: Fix single-step exception handling oops
Date:   Sun, 10 May 2020 05:41:56 +0800
Message-ID: <20200509214159.19680-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200509214159.19680-1-liwei391@huawei.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After entering kdb due to breakpoint, when we execute 'ss' or 'go' (will
delay installing breakpoints, do single-step first), it won't work
correctly, and it will enter kdb due to oops.

It's because the reason gotten in kdb_stub() is not as expected, and it
seems that the ex_vector for single-step should be 0, like what arch
powerpc/sh/parisc has implemented.

Before the patch:
Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff8000101486cc (printk)
    is enabled   addr at ffff8000101486cc, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fa878040, pid 266) on processor 3 due to Breakpoint @ 0xffff8000101486cc
[3]kdb> ss

Entering kdb (current=0xffff0000fa878040, pid 266) on processor 3 Oops: (null)
due to oops @ 0xffff800010082ab8
CPU: 3 PID: 266 Comm: sh Not tainted 5.7.0-rc4-13839-gf0e5ad491718 #6
Hardware name: linux,dummy-virt (DT)
pstate: 00000085 (nzcv daIf -PAN -UAO)
pc : el1_irq+0x78/0x180
lr : __handle_sysrq+0x80/0x190
sp : ffff800015003bf0
x29: ffff800015003d20 x28: ffff0000fa878040
x27: 0000000000000000 x26: ffff80001126b1f0
x25: ffff800011b6a0d8 x24: 0000000000000000
x23: 0000000080200005 x22: ffff8000101486cc
x21: ffff800015003d30 x20: 0000ffffffffffff
x19: ffff8000119f2000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000 x14: 0000000000000000
x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000
x9 : 0000000000000000 x8 : ffff800015003e50
x7 : 0000000000000002 x6 : 00000000380b9990
x5 : ffff8000106e99e8 x4 : ffff0000fadd83c0
x3 : 0000ffffffffffff x2 : ffff800011b6a0d8
x1 : ffff800011b6a000 x0 : ffff80001130c9d8
Call trace:
 el1_irq+0x78/0x180
 printk+0x0/0x84
 write_sysrq_trigger+0xb0/0x118
 proc_reg_write+0xb4/0xe0
 __vfs_write+0x18/0x40
 vfs_write+0xb0/0x1b8
 ksys_write+0x64/0xf0
 __arm64_sys_write+0x14/0x20
 el0_svc_common.constprop.2+0xb0/0x168
 do_el0_svc+0x20/0x98
 el0_sync_handler+0xec/0x1a8
 el0_sync+0x140/0x180

[3]kdb>

After the patch:
Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
[0]kdb> bp printk
Instruction(i) BP #0 at 0xffff8000101486cc (printk)
    is enabled   addr at ffff8000101486cc, hardtype=0 installed=0

[0]kdb> g

/ # echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to Breakpoint @ 0xffff8000101486cc
[0]kdb> g

Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to Breakpoint @ 0xffff8000101486cc
[0]kdb> ss

Entering kdb (current=0xffff0000fa852bc0, pid 268) on processor 0 due to SS trap @ 0xffff800010082ab8
[0]kdb>

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..1a157ca33262 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -252,7 +252,7 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 	if (!kgdb_single_step)
 		return DBG_HOOK_ERROR;
 
-	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 	return DBG_HOOK_HANDLED;
 }
 NOKPROBE_SYMBOL(kgdb_step_brk_fn);
-- 
2.17.1

