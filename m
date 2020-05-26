Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAC19CA90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgDBTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 15:50:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38900 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbgDBTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:50:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jK5rB-0002B3-13; Thu, 02 Apr 2020 21:50:29 +0200
Date:   Thu, 2 Apr 2020 21:50:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irq_poll: Use raise_softirq_irqoff() in cpu_dead notifier
Message-ID: <20200402195028.skpufyn4c6ktgai3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raise_softirq_irqoff() adds a pending sofirq mask and this is it. The
softirq won't be invoked unless something checks for a pending softirq
which should happen once the next interrupt fires. The CPU might go
idle in the meantime.

Use raise_softirq_irqoff() to wake ksoftirqd() if the list has work
items pending.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Maybe preempt_check_resched() should be added to act on a possible
need_resched flag. Otherwise it will be delayed to the next
cond_resched() / spin_unlock().

 lib/irq_poll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2f17b488d58e1..484dbd2aa09fb 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -194,7 +194,8 @@ static int irq_poll_cpu_dead(unsigned int cpu)
 	local_irq_disable();
 	list_splice_init(&per_cpu(blk_cpu_iopoll, cpu),
 			 this_cpu_ptr(&blk_cpu_iopoll));
-	__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
+	if (!list_empty(this_cpu_ptr(&blk_cpu_iopoll)))
+		raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 	local_irq_enable();
 
 	return 0;
-- 
2.26.0

