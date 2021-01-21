Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AAD2FE7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbhAUKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbhAUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:37:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC681C061795
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SuSRAD4sT96NAxuLxskyEwH2Dk9NCISATOso9/QHfIY=; b=dJnaxTQlC0a3eGhYINzy+++198
        YVQVQ5RnZOvGOMOe6CxwKkN5SUD8EzxP9ZRbDk0j0EE5S8/4zvjxbVnig1lZ+pZIfvUI2pVVGygoM
        G27Feh5lYW1Bzc61bvEw/NiAo98/Af8AaiordlOKSRfFA5mrEt+T6+h7kUX1AhpFpw9K8+aRhUV1e
        TVdVBdlVaEP6K7CdRV2A1Wvm4W6m462/LUszoANTpcK367077fak5m/LZ8Jjh5AxIjALq+coVZgx5
        ju7jPyfX1T2WWb1Y0bipGcCgkiUmFcLrfDdvJz2Ln1+I3gaifdbU04GrBp/aWIMgDa/utIKBNU+i9
        V12mb9Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2XKM-0007O8-3G; Thu, 21 Jan 2021 10:36:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0613F305C10;
        Thu, 21 Jan 2021 11:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 674D220C86813; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103506.693465814@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 5/9] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
References: <20210121101702.402798862@infradead.org>
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
+		kthread_set_per_cpu(worker->task, pool->cpu);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1883,6 +1885,7 @@ static void worker_detach_from_pool(stru
 
 	mutex_lock(&wq_pool_attach_mutex);
 
+	kthread_set_per_cpu(worker->task, -1);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -4919,8 +4922,10 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool)
+		for_each_pool_worker(worker, pool) {
+			kthread_set_per_cpu(worker->task, -1);
 			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
@@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool)
+	for_each_pool_worker(worker, pool) {
+		kthread_set_per_cpu(worker->task, pool->cpu);
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
+	}
 
 	raw_spin_lock_irq(&pool->lock);
 


