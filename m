Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086F52F49C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbhAMLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbhAMLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:12:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBFC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/C+vi0ZhgENVD3jXY1szgMhn3Gfatr45WqdY9lWpeE=; b=BXPvsgb8VtnIQaEW6ecWhQ9kIO
        fg4Mn8MOtkQtfUCTxCJmVGWcQWTXhCXOHdI+txpdk680eeUDa7+HQUUTJaDq/o8G3axPNkOd04xge
        ZZa7I39GWNYaSvgIQVz6e0l5Etjv3FeztLKc+y6KSovKd5PE6kp1ywZwH5JDy/E9D3RcxiimWRTK+
        0+CCG2EtUko9S3CRtD4awvEh2uugnibuICGJkXYnoqXfOuJPyLXuW0ikCocLu/TDnSrQZSGLHVkhD
        hmWX62JXx2dONaC3yR05FWzMT5FSP8Of7a2YdZ277HoIX9OQTUCmbZq6CwvHk0ekO+Ty+sU3W48dd
        BmR85FSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kze3M-000732-Qr; Wed, 13 Jan 2021 11:11:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01317300238;
        Wed, 13 Jan 2021 12:10:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC4FB211618D1; Wed, 13 Jan 2021 12:10:59 +0100 (CET)
Date:   Wed, 13 Jan 2021 12:10:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paul McKenney <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -tip V3 0/8] workqueue: break affinity initiatively
Message-ID: <X/7VQ8pF5h/K+Cj1@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <X/hGHNGB9fltElWB@hirez.programming.kicks-ass.net>
 <87o8hv7pnd.fsf@nanos.tec.linutronix.de>
 <X/wv7+PP8ywNYmIS@hirez.programming.kicks-ass.net>
 <X/yH9+MGa1JCNZ8x@hirez.programming.kicks-ass.net>
 <jhj7doj1dr1.mognet@arm.com>
 <X/yzrJw4UbQsK3KB@hirez.programming.kicks-ass.net>
 <CAJhGHyA0rfR92W7T7RnhPrmLMkmV4Mb7fUSeG2VEHhsH-pSxsw@mail.gmail.com>
 <X/236obyM0nqL5+X@hirez.programming.kicks-ass.net>
 <CAJhGHyDtku6PjLtkq7TGmcQnds5cakR6viki=bPoxxkdC0p-Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDtku6PjLtkq7TGmcQnds5cakR6viki=bPoxxkdC0p-Tw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:38:12PM +0800, Lai Jiangshan wrote:

> But the hard problem is "how to suppress the warning of
> online&!active in __set_cpus_allowed_ptr()" for late spawned
> unbound workers during hotplug.

I cannot see create_worker() go bad like that.

The thing is, it uses:

  kthread_bind_mask(, pool->attr->cpumask)
  worker_attach_to_pool()
    set_cpus_allowed_ptr(, pool->attr->cpumask)

which means set_cpus_allowed_ptr() must be a NOP, because the affinity
is already set by kthread_bind_mask(). Further, the first wakeup of that
worker will then hit:

  select_task_rq()
    is_cpu_allowed()
      is_per_cpu_kthread() -- false
    select_fallback_rq()


So normally that really isn't a problem. I can only see a tiny hole
there, where someone changes the cpumask between kthread_bind_mask() and
set_cpus_allowed_ptr(). AFAICT that can be fixed in two ways:

 - add wq_pool_mutex around things in create_worker(), or
 - move the set_cpus_allowed_ptr() out of worker_attach_to_pool() and
   into rescuer_thread().

Which then brings us to rescuer_thread...  If we manage to trigger the
rescuer during hotplug, then yes, I think that can go wobbly.

Let me consider that a bit more while I try and make sense of that splat
Paul reported.

---

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ec0771e4a3fb..fe05308dc472 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1844,15 +1844,19 @@ static struct worker *alloc_worker(int node)
  * cpu-[un]hotplugs.
  */
 static void worker_attach_to_pool(struct worker *worker,
-				   struct worker_pool *pool)
+				  struct worker_pool *pool,
+				  bool set_affinity)
 {
 	mutex_lock(&wq_pool_attach_mutex);
 
-	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	if (set_affinity) {
+		/*
+		 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have
+		 * any online CPUs.  It'll be re-applied when any of the CPUs
+		 * come up.
+		 */
+		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	}
 
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
@@ -1944,7 +1948,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
 	/* successful, attach the worker to the pool */
-	worker_attach_to_pool(worker, pool);
+	worker_attach_to_pool(worker, pool, false);
 
 	/* start the newly created worker */
 	raw_spin_lock_irq(&pool->lock);
@@ -2509,7 +2513,11 @@ static int rescuer_thread(void *__rescuer)
 
 		raw_spin_unlock_irq(&wq_mayday_lock);
 
-		worker_attach_to_pool(rescuer, pool);
+		/*
+		 * XXX can go splat when running during hot-un-plug and
+		 * the pool affinity is wobbly.
+		 */
+		worker_attach_to_pool(rescuer, pool, true);
 
 		raw_spin_lock_irq(&pool->lock);
 
