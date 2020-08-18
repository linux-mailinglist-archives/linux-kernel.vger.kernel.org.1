Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1122483FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHRL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:28:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D8C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EU8brcDaDiYW4fr6pjY4X18D72HZqxsjECTnBCKTXzk=; b=is/mGd+Cdj8TRUy6yDxDvR7u6M
        14emhs2VKoIFad4Ym8FpoQzTZUaF/pDQ5Ahd6Kz3fRAuFdgzI5T+hdC18oUXE/1DHG16AgraiWGMf
        jmK8W5m+dERaMXqyWvo1Z02kjfn5EIxwefRoHYMLCC8L6nsfOYSWeejOzmsldN4FPBBRc7Uwk9HgU
        ZfU9qILnX3eYcziZ5jIQQbwVMv6w4bfM/QEXPZWh/bITnXjzgOQeYNPuPihCEtLiKylQj2bTHnunZ
        +Aunr8JG/KWFUPRV/2XUoBXXYUmAEJ4WlKCKFP5nCkJvFL9DmS5yyoOLjz4OQW6PHBJzoNkO+0WQ4
        PsD3sh3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7zmP-0002AZ-OH; Tue, 18 Aug 2020 11:27:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E98B5307691;
        Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6CB18200D4C3A; Tue, 18 Aug 2020 13:27:44 +0200 (CEST)
Message-ID: <20200818112418.328209144@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 12:51:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, paulmck@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH v2 06/10] irq_work: Provide irq_work_queue_remote_static()
References: <20200818105102.926463950@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the same horrible semantics provided by
smp_call_function_single_async(), doing so allows skiping a bunch of
atomic ops.

API wise this is horrible crap as it relies on external serialization.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/irq_work.h |    3 ++-
 kernel/irq_work.c        |   21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -19,7 +19,7 @@ struct irq_work {
 };
 
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
-	.node = { .u_flags = (_flags), },			\
+	.node = { .u_flags = CSD_TYPE_IRQ_WORK | (_flags), },	\
 	.func = (_func),					\
 }
 
@@ -68,6 +68,7 @@ static inline bool irq_work_needs_cpu(vo
 
 #ifdef CONFIG_SMP
 extern int irq_work_queue_remote(int cpu, struct irq_work *work);
+extern int irq_work_queue_remote_static(int cpu, struct irq_work *work);
 extern void irq_work_single(void *arg);
 #endif
 
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -29,7 +29,7 @@ static bool irq_work_claim(struct irq_wo
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
 	 * The pairing smp_mb() in irq_work_single() makes sure
@@ -63,6 +63,9 @@ void irq_work_single(void *arg)
 	work->func(work);
 	lockdep_irq_work_exit(flags);
 
+	if (!(flags & IRQ_WORK_BUSY))
+		return;
+
 	/*
 	 * Clear the BUSY bit, if set, and return to the free state if no-one
 	 * else claimed it meanwhile.
@@ -108,6 +111,22 @@ int irq_work_queue_remote(int cpu, struc
 
 	return 0;
 }
+
+int irq_work_queue_remote_static(int cpu, struct irq_work *work)
+{
+	/*
+	 * Ensures preemption is disabled in the caller.
+	 */
+	WARN_ON_ONCE(cpu == smp_processor_id());
+
+	if (work->node.u_flags & IRQ_WORK_PENDING)
+		return -EBUSY;
+
+	work->node.u_flags |= IRQ_WORK_PENDING;
+	__smp_call_single_queue(cpu, &work->node.llist);
+
+	return 0;
+}
 
 #endif /* CONFIG_SMP */
 


