Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DAB2F335A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbhALOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbhALOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:53:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82275C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cWomoZmYrLsTX6VVzmoZi9nfjKZIvX9wQPG49wct9BI=; b=CTJMhl84u5P4V2Ws0MO1BEqdc6
        n7Nh4Uz/HYG0QRhF41bOKjDiMWyM19w5ikpV6lgo8aPNOqpwXrJ2BN3+LRhXhC1Ow2y7fArL23DCI
        WuG9NzH8sIFVtHDL2nKyRh614tZIELWqa4z9BO4hKyGglfm05IAtbupLHArZ4wbAFf8ZRCUohIydp
        NMDRxNLDq/OJQMzFY+s+PDeqWRKuz1SRT9Zjw3QrErLC0Sr/jj+yVELUh8oCP332X1jRKdKdJvJGh
        7K8x39y+VqfcFJEXx8OREg43rEXZThh3pAG7NnamPM+d2ILS+XL0TMznMHRNbU5xlkJ/73sFn2FKN
        8mABQCCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzL1I-004v62-2t; Tue, 12 Jan 2021 14:51:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C89853059DE;
        Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B23E920C228D9; Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Message-ID: <20210112144843.849135905@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jan 2021 15:43:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
References: <20210112144344.850850975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the per-cpu workqueue workers as KTHREAD_IS_PER_CPU.

Workqueues have unfortunate semantics in that per-cpu workers are not
default flushed and parked during hotplug, however a subset does
manual flush on hotplug and hard relies on them for correctness.

Therefore play silly games..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/workqueue.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct
 	 */
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
+	else
+		kthread_set_per_cpu(worker->task, true);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1883,6 +1885,7 @@ static void worker_detach_from_pool(stru
 
 	mutex_lock(&wq_pool_attach_mutex);
 
+	kthread_set_per_cpu(worker->task, false);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -4919,8 +4922,10 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool)
+		for_each_pool_worker(worker, pool) {
+			kthread_set_per_cpu(worker->task, false);
 			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
@@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool)
+	for_each_pool_worker(worker, pool) {
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
+		kthread_set_per_cpu(worker->task, true);
+	}
 
 	raw_spin_lock_irq(&pool->lock);
 


