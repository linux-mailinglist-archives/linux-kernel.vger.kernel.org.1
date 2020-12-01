Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE92C2C93B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbgLAANT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgLAANT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:13:19 -0500
Received: from localhost.localdomain (mtl93-h04-176-174-252-224.dsl.sta.abo.bbox.fr [176.174.252.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DBB207FF;
        Tue,  1 Dec 2020 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606781558;
        bh=YDG0uNnWtxaTSU1/SxaKGt64Eqo+nQAPmBIrwkvcJyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcG+Z2lCfAXqtfWsBm+9ldPZw5Bn8xo+BNxRayY4OrSyJTnOV8VchU0WVmucmksz8
         M9E/4ChHgUnMRftlzqp/MMy62y98I3A43sA0ccbH3pWQ2m9oKBkq71IIiEOnj4kptE
         zQN9eELgWJaM5dKrRTFU+0VXCBqszMHFc2V4HU0g=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/5] sched/cputime: Remove symbol exports from IRQ time accounting
Date:   Tue,  1 Dec 2020 01:12:22 +0100
Message-Id: <20201201001226.65107-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201001226.65107-1-frederic@kernel.org>
References: <20201201001226.65107-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

account_irq_enter_time() and account_irq_exit_time() are not called
from modules. EXPORT_SYMBOL_GPL() can be safely removed from the IRQ
cputime accounting functions called from there.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/vtime.c | 10 +++++-----
 kernel/sched/cputime.c   |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3c8f6c..f9f2a11958a5 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -226,7 +226,7 @@ void vtime_flush(struct task_struct *tsk)
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	u64 timer;
 
@@ -245,12 +245,12 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 
 	virt_timer_forward(timer);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
-
-void vtime_account_kernel(struct task_struct *tsk)
-__attribute__((alias("vtime_account_irq_enter")));
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_irq_enter(struct task_struct *tsk)
+__attribute__((alias("vtime_account_kernel")));
+
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5a55d2300452..61ce9f9bf0a3 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -71,7 +71,6 @@ void irqtime_account_irq(struct task_struct *curr)
 	else if (in_serving_softirq() && curr != this_cpu_ksoftirqd())
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
-EXPORT_SYMBOL_GPL(irqtime_account_irq);
 
 static u64 irqtime_tick_accounted(u64 maxtime)
 {
@@ -434,7 +433,6 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 	else
 		vtime_account_kernel(tsk);
 }
-EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 #endif /* __ARCH_HAS_VTIME_ACCOUNT */
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
-- 
2.25.1

