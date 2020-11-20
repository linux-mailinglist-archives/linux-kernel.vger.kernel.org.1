Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CE2BB8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgKTWR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgKTWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:17:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE72C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:17:28 -0800 (PST)
Date:   Fri, 20 Nov 2020 23:17:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605910646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDMsQqZvMY3BDZ5c3i/PAw+2A0OQq7j5i3pJCfUo0/U=;
        b=J7SVOtIGGI30btrqU14Ra5SMKUWZoY6De9VQ8z+iFn4W8vtqnlqd1IuEYLDfM/yWetsfrv
        in4WYEY5GylYst+Xk9FCdeaudWZmTNsl6Ywv8MQF9qp836ao43N2Bhfo7kDEXGryQMr51N
        PnzmdkZIUNtaxaZwfV+BvYDE1SGsrXwCIWhteVzAqju3j90prL1HfumLTjYnYIX6/uZf01
        XFWQQqh10mty4vneImbUVKv63Ybd2XlxwB6IS3xhfwHolyDpGSIHJ81wVmUhQNlykamNXd
        qfPNXrGLx+4l4ilOAyzpp3j+Qoq9NZb47c4WiknSkUDYTQq8Y+C6v8XCrQqOtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605910646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hDMsQqZvMY3BDZ5c3i/PAw+2A0OQq7j5i3pJCfUo0/U=;
        b=i5HqrTNhqp6pDInxCHlksuT8SbzpME3NEMlcFuoowFiMsp1nkADxvOXC+8jeuAd+2t/A+n
        0MbG9IZcca6FnBAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] kthread: Move prio/affinite change into the newly
 created thread
Message-ID: <20201120221724.h5nji5fqywwk4p2c@linutronix.de>
References: <20201110113848.801379-1-bigeasy@linutronix.de>
 <20201110113848.801379-2-bigeasy@linutronix.de>
 <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-17 13:45:03 [+0100], Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 12:38:47PM +0100, Sebastian Andrzej Siewior wrote:
> > With enabled threaded interrupts the nouveau driver reported the
> > following:
> > | Chain exists of:
> > |   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
> > |
> > |  Possible unsafe locking scenario:
> > |
> > |        CPU0                    CPU1
> > |        ----                    ----
> > |   lock(&cpuset_rwsem);
> > |                                lock(&device->mutex);
> > |                                lock(&cpuset_rwsem);
> > |   lock(&mm->mmap_lock#2);
> > 
> > The device->mutex is nvkm_device::mutex.
> > 
> > Unblocking the lockchain at `cpuset_rwsem' is probably the easiest thing
> > to do.
> > Move the priority reset to the start of the newly created thread.
> > 
> > Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")
> > Reported-by: Mike Galbraith <efault@gmx.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de
> 
> Moo... yes this is certainly the easiest solution, because nouveau is a
> horrible rats nest. But when I spoke to Greg KH about this, he suggested
> nouveau ought to be fixed.
> 
> Ben, I got terminally lost when trying to untangle nouvea init, is there
> any chance this can be fixed to not hold that nvkm_device::mutex thing
> while doing request_irq() ?

Ben, did you had a chance to peek at this?

> > ---
> >  kernel/kthread.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 933a625621b8d..4a31127c6efbf 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -243,6 +243,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
> >  
> >  static int kthread(void *_create)
> >  {
> > +	static const struct sched_param param = { .sched_priority = 0 };
> >  	/* Copy data: it's on kthread's stack */
> >  	struct kthread_create_info *create = _create;
> >  	int (*threadfn)(void *data) = create->threadfn;
> > @@ -273,6 +274,13 @@ static int kthread(void *_create)
> >  	init_completion(&self->parked);
> >  	current->vfork_done = &self->exited;
> >  
> > +	/*
> > +	 * The new thread inherited kthreadd's priority and CPU mask. Reset
> > +	 * back to default in case they have been changed.
> > +	 */
> > +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> > +	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
> > +
> >  	/* OK, tell user we're spawned, wait for stop or wakeup */
> >  	__set_current_state(TASK_UNINTERRUPTIBLE);
> >  	create->result = current;
> > @@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> >  	}
> >  	task = create->result;
> >  	if (!IS_ERR(task)) {
> > -		static const struct sched_param param = { .sched_priority = 0 };
> >  		char name[TASK_COMM_LEN];
> >  
> >  		/*
> > @@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
> >  		 */
> >  		vsnprintf(name, sizeof(name), namefmt, args);
> >  		set_task_comm(task, name);
> > -		/*
> > -		 * root may have changed our (kthreadd's) priority or CPU mask.
> > -		 * The kernel thread should not inherit these properties.
> > -		 */
> > -		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> > -		set_cpus_allowed_ptr(task,
> > -				     housekeeping_cpumask(HK_FLAG_KTHREAD));
> >  	}
> >  	kfree(create);
> >  	return task;

Sebastian
