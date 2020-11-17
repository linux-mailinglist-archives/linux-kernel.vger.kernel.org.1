Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513A12B5F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKQMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:45:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4526BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L6YLBlkW6W7l/DjGRUeegpN2Sts9zkEATW3WfyM92jI=; b=zhXiGoKud8aVcPw381ah8troIn
        T2mDi2pD03wus+BOUUJm7izR3PDf/hlfZAA7f+SoOK37Qq35HT6PsrXwuVEbKI3TScvpqBy4daJ1B
        tRt9uy4tDgs1uT5yocxmUWt47eAa1tZ6rEzeD3knoraVzb+9n5goVI1itaIdK/tBwKAKukKES+WGZ
        WNWgZoDmvxagRwhvYmUXKRTUQmkaXQQ1dU+UL+IKaPonPQkxCV2jzylp+C+D8neGTaI/6XBk1efCc
        9TAPcQWY23Hf7WyXLSZXM2rpryr+76PePxcl5KT1e+4biHMcoEyfBQQd7YweZiw35OBoK/6cgEda1
        A2SOMvYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf0M5-0006yv-6b; Tue, 17 Nov 2020 12:45:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B3313069B1;
        Tue, 17 Nov 2020 13:45:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EF40203DDBF7; Tue, 17 Nov 2020 13:45:03 +0100 (CET)
Date:   Tue, 17 Nov 2020 13:45:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] kthread: Move prio/affinite change into the newly
 created thread
Message-ID: <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
References: <20201110113848.801379-1-bigeasy@linutronix.de>
 <20201110113848.801379-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110113848.801379-2-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 12:38:47PM +0100, Sebastian Andrzej Siewior wrote:
> With enabled threaded interrupts the nouveau driver reported the
> following:
> | Chain exists of:
> |   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
> |
> |  Possible unsafe locking scenario:
> |
> |        CPU0                    CPU1
> |        ----                    ----
> |   lock(&cpuset_rwsem);
> |                                lock(&device->mutex);
> |                                lock(&cpuset_rwsem);
> |   lock(&mm->mmap_lock#2);
> 
> The device->mutex is nvkm_device::mutex.
> 
> Unblocking the lockchain at `cpuset_rwsem' is probably the easiest thing
> to do.
> Move the priority reset to the start of the newly created thread.
> 
> Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de

Moo... yes this is certainly the easiest solution, because nouveau is a
horrible rats nest. But when I spoke to Greg KH about this, he suggested
nouveau ought to be fixed.

Ben, I got terminally lost when trying to untangle nouvea init, is there
any chance this can be fixed to not hold that nvkm_device::mutex thing
while doing request_irq() ?

> ---
>  kernel/kthread.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 933a625621b8d..4a31127c6efbf 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -243,6 +243,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
>  
>  static int kthread(void *_create)
>  {
> +	static const struct sched_param param = { .sched_priority = 0 };
>  	/* Copy data: it's on kthread's stack */
>  	struct kthread_create_info *create = _create;
>  	int (*threadfn)(void *data) = create->threadfn;
> @@ -273,6 +274,13 @@ static int kthread(void *_create)
>  	init_completion(&self->parked);
>  	current->vfork_done = &self->exited;
>  
> +	/*
> +	 * The new thread inherited kthreadd's priority and CPU mask. Reset
> +	 * back to default in case they have been changed.
> +	 */
> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
> +
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> @@ -370,7 +378,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  	}
>  	task = create->result;
>  	if (!IS_ERR(task)) {
> -		static const struct sched_param param = { .sched_priority = 0 };
>  		char name[TASK_COMM_LEN];
>  
>  		/*
> @@ -379,13 +386,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  		 */
>  		vsnprintf(name, sizeof(name), namefmt, args);
>  		set_task_comm(task, name);
> -		/*
> -		 * root may have changed our (kthreadd's) priority or CPU mask.
> -		 * The kernel thread should not inherit these properties.
> -		 */
> -		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> -		set_cpus_allowed_ptr(task,
> -				     housekeeping_cpumask(HK_FLAG_KTHREAD));
>  	}
>  	kfree(create);
>  	return task;
> -- 
> 2.29.2
> 
