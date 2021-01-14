Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1132F619B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbhANNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:12:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B0CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 05:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ebUnZW1AQJPxu5ojrsJH28XYwALDU7JpBf3f9D5JPLU=; b=FXvCqXrgoZHAOqcfePOMT7FEk1
        qW4DAd7/juGkGp5obAzy7Gnu9EGmQaNi07iKLs00USXWybUA1jF0flosDvHBMP2y0kbVm4HYYHZnJ
        Qoh2BJJiTqc/n+Mrnnu1DLEkiDINsU9HK/W4ulQR0MfNWScTt1DGzEmVUnfygf72uaaHvpsMd0HTn
        zUarKieqWuwgWqRATa3+6jMCQ6dCYoqqCFyIbVMY0ZQJa3ZyYGq4LO2F9Mq0QHYWG4HbeuMU1NiWD
        4jc+e6m5CQoGXhCys5J0Aaj28SJ1HNaAaTOu5KE8JhhaDunw4J0B+PAwum20ZFLAh23QAXVc26iKV
        VqFWUYmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l02Q2-0005zR-6d; Thu, 14 Jan 2021 13:12:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25CA1301324;
        Thu, 14 Jan 2021 14:12:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA8B8200D400B; Thu, 14 Jan 2021 14:12:03 +0100 (CET)
Date:   Thu, 14 Jan 2021 14:12:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Message-ID: <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net>
References: <20210112144344.850850975@infradead.org>
 <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:28:13PM +0800, Lai Jiangshan wrote:
> On Tue, Jan 12, 2021 at 10:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > @@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker
> >          * of all workers first and then clear UNBOUND.  As we're called
> >          * from CPU_ONLINE, the following shouldn't fail.
> >          */
> > -       for_each_pool_worker(worker, pool)
> > +       for_each_pool_worker(worker, pool) {
> >                 WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> >                                                   pool->attrs->cpumask) < 0);
> > +               kthread_set_per_cpu(worker->task, true);
> 
> Will the schedule break affinity in the middle of these two lines due to
> patch4 allowing it and result in Paul's reported splat.

So something like the below _should_ work, except i'm seeing odd WARNs.
I'll prod at it some more.

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2371,6 +2371,7 @@ static int worker_thread(void *__worker)
 	/* tell the scheduler that this is a workqueue worker */
 	set_pf_worker(true);
 woke_up:
+	kthread_parkme();
 	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
@@ -2428,6 +2429,7 @@ static int worker_thread(void *__worker)
 			move_linked_works(work, &worker->scheduled, NULL);
 			process_scheduled_works(worker);
 		}
+		kthread_parkme();
 	} while (keep_working(pool));
 
 	worker_set_flags(worker, WORKER_PREP);
@@ -4978,9 +4980,9 @@ static void rebind_workers(struct worker
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
 	for_each_pool_worker(worker, pool) {
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
+		kthread_park(worker->task);
 		kthread_set_per_cpu(worker->task, true);
+		kthread_unpark(worker->task);
 	}
 
 	raw_spin_lock_irq(&pool->lock);
