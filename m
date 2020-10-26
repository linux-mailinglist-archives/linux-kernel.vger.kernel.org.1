Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74B2992BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786296AbgJZQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:46:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:42392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780572AbgJZQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603730756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kChY8deJI75T79lVGPftJ4ey9Ah/Bxr9MOF++yylAmI=;
        b=SruZRHB4/2X2tN68C38bbrDleSxEM9/1XPl7zpK3UMO1y3WFzNYzatV+nzV8NadcdHHQxw
        EaF376ONJgPFsNo0RJ9i+pJb4ScpsYVjrGVzUUVWVHQqycyW9EwB+oJScCLHg8d+UPHzOk
        rICI4ymhR4Isaxz+2JTlwFsVnMb/8T8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7B56ACD8;
        Mon, 26 Oct 2020 16:45:55 +0000 (UTC)
Date:   Mon, 26 Oct 2020 17:45:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     qiang.zhang@windriver.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
Message-ID: <20201026164555.GA7544@alley>
References: <20201026065213.30477-1-qiang.zhang@windriver.com>
 <20201026135011.GC73258@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026135011.GC73258@mtj.duckdns.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-10-26 09:50:11, Tejun Heo wrote:
> On Mon, Oct 26, 2020 at 02:52:13PM +0800, qiang.zhang@windriver.com wrote:
> > @@ -737,8 +741,11 @@ __kthread_create_worker(int cpu, unsigned int flags,
> >  	if (IS_ERR(task))
> >  		goto fail_task;
> >  
> > -	if (cpu >= 0)
> > +	if (cpu >= 0) {
> >  		kthread_bind(task, cpu);
> > +		worker->bind_cpu = cpu;
> > +		cpuhp_state_add_instance_nocalls(kworker_online, &worker->cpuhp_node);
> > +	}
> >  
> >  	worker->flags = flags;
> >  	worker->task = task;
> ...
> > +static int kworker_cpu_online(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);
> > +	struct task_struct *task = worker->task;
> > +
> > +	if (cpu == worker->bind_cpu)
> > +		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpumask_of(cpu)) < 0);
> > +	return 0;
> > +}
> 
> I don't think this works. The kthread may have changed its binding while
> running using set_cpus_allowed_ptr() as you're doing above. Besides, when a
> cpu goes offline, the bound kthread can fall back to other cpus but its cpu
> mask isn't cleared, is it?

If I get it correctly, select_fallback_rq() calls
do_set_cpus_allowed() explicitly or in cpuset_cpus_allowed_fallback().
It seems that the original mask gets lost.

It would make sense to assume that kthread_worker API will take care of
the affinity when it was set by kthread_create_worker_on_cpu().

But is it safe to assume that the work can be safely proceed also
on another CPU? We should probably add a warning into
kthread_worker_fn() when it detects wrong CPU.

BTW: kthread_create_worker_on_cpu() is currently used only by
     start_power_clamp_worker(). And it has its own CPU hotplug
     handling. The kthreads are stopped and started again
     in powerclamp_cpu_predown() and  powerclamp_cpu_online().


I havn't checked all details yet. But in principle, the patch looks
sane to me.

Best Regards,
Petr
