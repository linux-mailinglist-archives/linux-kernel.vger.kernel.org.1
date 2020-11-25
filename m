Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048302C36A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgKYCQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKYCQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:16:00 -0500
Received: from localhost.localdomain (unknown [94.238.200.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938DB20BED;
        Wed, 25 Nov 2020 02:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606270560;
        bh=SpjewY+zCUd4+dIAcXesrctaRe/IkPPUnJz7GEMao2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdwpOJixZ7e0vyG7uFfu1Wbbhqq9tOMFxt8fKy967bqDJFh8yY5UBwmrdPB7zdQp8
         qeRAYkLhw+ycCMmZz79SepIH0W4xaOcvS31cDjtaAWDC/02rWDX2Su0jHv2ysolwV5
         Tsb4QlR1JhKQOg0mQ5cBmv25RAOSUdA6nYa1kroI=
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
Subject: [RFC PATCH 4/4] irq: Call tick_irq_enter() inside HARDIRQ_OFFSET
Date:   Wed, 25 Nov 2020 03:15:42 +0100
Message-Id: <20201125021542.30237-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201125021542.30237-1-frederic@kernel.org>
References: <20201125021542.30237-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that account_irq_enter_time() is called after HARDIRQ_OFFSET has
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
index 24254c41bb7c..447ee4d6fe4d 100644
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
+	account_irq_enter_time(current);
 }
 
 /**
-- 
2.25.1

