Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F82CBC34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgLBL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgLBL7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:59:08 -0500
From:   Frederic Weisbecker <frederic@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5/5] irq: Call tick_irq_enter() inside HARDIRQ_OFFSET
Date:   Wed,  2 Dec 2020 12:57:32 +0100
Message-Id: <20201202115732.27827-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202115732.27827-1-frederic@kernel.org>
References: <20201202115732.27827-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that account_hardirq_enter() is called after HARDIRQ_OFFSET has
been incremented, there is nothing left that prevents us from also
moving tick_irq_enter() after HARDIRQ_OFFSET is incremented.

The desired outcome is to remove the nasty hack that prevents softirqs
from being raised through ksoftirqd instead of the hardirq bottom half.
Also tick_irq_enter() then becomes appropriately covered by lockdep.

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
 kernel/softirq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b8f42b3ba8ca..d5bfd5e661fc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -377,16 +377,12 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
  */
 void irq_enter_rcu(void)
 {
-	if (is_idle_task(current) && !in_interrupt()) {
-		/*
-		 * Prevent raise_softirq from needlessly waking up ksoftirqd
-		 * here, as softirq will be serviced on return from interrupt.
-		 */
-		local_bh_disable();
+	__irq_enter_raw();
+
+	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
 		tick_irq_enter();
-		_local_bh_enable();
-	}
-	__irq_enter();
+
+	account_hardirq_enter(current);
 }
 
 /**
-- 
2.25.1

