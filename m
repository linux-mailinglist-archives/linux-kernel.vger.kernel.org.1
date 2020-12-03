Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D122CD289
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgLCJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:28:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53901 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgLCJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:28:39 -0500
X-UUID: 81173dd499dc4e29867ce372c50c8a4f-20201203
X-UUID: 81173dd499dc4e29867ce372c50c8a4f-20201203
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1759663941; Thu, 03 Dec 2020 17:27:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Dec 2020 17:27:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Dec 2020 17:27:54 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <akpm@linux-foundation.org>, <peterx@redhat.com>,
        <rppt@kernel.org>, <walken@google.com>, <marc.zyngier@arm.com>,
        <linux@armlinux.org.uk>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        YJ Chiang <yj.chiang@mediatek.com>
Subject: [PATCH] ARM: mm: harden branch predictor before opening interrupts during fault
Date:   Thu, 3 Dec 2020 17:27:38 +0800
Message-ID: <20201203092738.11866-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was send by "Sebastian Andrzej Siewior <bigeasy@linutronix.de>"
in [1] and rebase in v5.10-rc6.

The original commit message:

> On non-LPAE systems a write to 0xbffffff0 (modules area) from userland
> results in:
> | BUG: using smp_processor_id() in preemptible [00000000] code: mem-tc/521
> | caller is __do_user_fault.constprop.2+0x4c/0x74
> | CPU: 1 PID: 521 Comm: mem-tc Not tainted 5.1.0-rc1 #4
> | [<c04614e4>] (debug_smp_processor_id) from [<c0116378>] (__do_user_fault.constprop.2+0x4c/0x74)
> | [<c0116378>] (__do_user_fault.constprop.2) from [<c011668c>] (do_page_fault+0x278/0x37c)
> | [<c011668c>] (do_page_fault) from [<c0116904>] (do_DataAbort+0x3c/0xa8)
> | [<c0116904>] (do_DataAbort) from [<c0101e1c>] (__dabt_usr+0x3c/0x40)
>
> Move harden_branch_predictor() from __do_user_fault() to its both
> callers (do_bad_area() and do_page_fault()). The invocation in
> do_page_fault() is added before interrupst are enabled. The invocation
> in do_bad_area() is added just before __do_user_fault() is invoked.

The BUG still exists in v5.10-rc, and the previous disscussion was [2].
This issue can be easily reproduced in ARM with CONFIG_DEBUG_PREEMPT and
CONFIG_HARDEN_BRANCH_PREDICTOR by the following userspace program:

  int *p = 0xffff3ff4;
  *p = 123;

[1]:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20190319203239.gl46fxnfz6gzeeic@linutronix.de/
[2]:
https://lkml.org/lkml/2019/6/3/426

Fixes: f5fe12b1eaee2 ("ARM: spectre-v2: harden user aborts in kernel space")
Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
---
 arch/arm/mm/fault.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index efa402025031..f1b57b7d5a0c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -138,9 +138,6 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 {
 	struct task_struct *tsk = current;
 
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
-
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -173,8 +170,11 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
 	 */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		if (addr > TASK_SIZE)
+			harden_branch_predictor();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+	}
 	else
 		__do_kernel_fault(mm, addr, fsr, regs);
 }
@@ -251,6 +251,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	tsk = current;
 	mm  = tsk->mm;
 
+	if (addr > TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
 		local_irq_enable();
-- 
2.18.0

