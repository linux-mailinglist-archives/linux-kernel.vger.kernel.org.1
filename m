Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D081BAAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0REc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 13:04:32 -0400
Received: from foss.arm.com ([217.140.110.172]:38468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgD0REb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:04:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87E7931B;
        Mon, 27 Apr 2020 10:04:30 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE513F68F;
        Mon, 27 Apr 2020 10:04:27 -0700 (PDT)
Date:   Mon, 27 Apr 2020 18:04:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net, paulmck@kernel.org,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200427170423.i3yjmj63oinwr4qx@e107158-lin>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422112831.266499893@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/20 13:27, Peter Zijlstra wrote:
> SCHED_FIFO (or any static priority scheduler) is a broken scheduler
> model; it is fundamentally incapable of resource management, the one
> thing an OS is actually supposed to do.
> 
> It is impossible to compose static priority workloads. One cannot take
> two well designed and functional static priority workloads and mash
> them together and still expect them to work.
> 
> Therefore it doesn't make sense to expose the priority field; the
> kernel is fundamentally incapable of setting a sensible value, it
> needs systems knowledge that it doesn't have.
> 
> Take away sched_setschedule() / sched_setattr() from modules and
> replace them with:
> 
>   - sched_set_fifo(p); create a FIFO task (at prio 50)
>   - sched_set_fifo_low(p); create a task higher than NORMAL,
> 	which ends up being a FIFO task at prio 1.
>   - sched_set_normal(p, nice); (re)set the task to normal
> 
> This stops the proliferation of randomly chosen, and irrelevant, FIFO
> priorities that dont't really mean anything anyway.
> 
> The system administrator/integrator, whoever has insight into the
> actual system design and requirements (userspace) can set-up
> appropriate priorities if and when needed.
> 
> Cc: airlied@redhat.com
> Cc: alexander.deucher@amd.com
> Cc: awalls@md.metrocast.net
> Cc: axboe@kernel.dk
> Cc: broonie@kernel.org
> Cc: daniel.lezcano@linaro.org
> Cc: gregkh@linuxfoundation.org
> Cc: hannes@cmpxchg.org
> Cc: herbert@gondor.apana.org.au
> Cc: hverkuil@xs4all.nl
> Cc: john.stultz@linaro.org
> Cc: nico@fluxnic.net
> Cc: paulmck@kernel.org
> Cc: rafael.j.wysocki@intel.com
> Cc: rmk+kernel@arm.linux.org.uk
> Cc: sudeep.holla@arm.com
> Cc: tglx@linutronix.de
> Cc: ulf.hansson@linaro.org
> Cc: wim@linux-watchdog.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---

The random priorities were horrible indeed.

FWIW

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

>  include/linux/sched.h |    3 +++
>  kernel/sched/core.c   |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1631,6 +1631,9 @@ extern int idle_cpu(int cpu);
>  extern int available_idle_cpu(int cpu);
>  extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
>  extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
> +extern int sched_set_fifo(struct task_struct *p);
> +extern int sched_set_fifo_low(struct task_struct *p);
> +extern int sched_set_normal(struct task_struct *p, int nice);
>  extern int sched_setattr(struct task_struct *, const struct sched_attr *);
>  extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
>  extern struct task_struct *idle_task(int cpu);
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5055,6 +5055,8 @@ static int _sched_setscheduler(struct ta
>   * @policy: new policy.
>   * @param: structure containing the new RT priority.
>   *
> + * Use sched_set_fifo(), read its comment.
> + *
>   * Return: 0 on success. An error code otherwise.
>   *
>   * NOTE that the task may be already dead.
> @@ -5097,6 +5099,51 @@ int sched_setscheduler_nocheck(struct ta
>  }
>  EXPORT_SYMBOL_GPL(sched_setscheduler_nocheck);
>  
> +/*
> + * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
> + * incapable of resource management, which is the one thing an OS really should
> + * be doing.
> + *
> + * This is of course the reason it is limited to privileged users only.
> + *
> + * Worse still; it is fundamentally impossible to compose static priority
> + * workloads. You cannot take two correctly working static prio workloads
> + * and smash them together and still expect them to work.
> + *
> + * For this reason 'all' FIFO tasks the kernel creates are basically at:
> + *
> + *   MAX_RT_PRIO / 2
> + *
> + * The administrator _MUST_ configure the system, the kernel simply doesn't
> + * know enough information to make a sensible choice.
> + */
> +int sched_set_fifo(struct task_struct *p)
> +{
> +	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
> +	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_fifo);
> +
> +/*
> + * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
> + */
> +int sched_set_fifo_low(struct task_struct *p)
> +{
> +	struct sched_param sp = { .sched_priority = 1 };
> +	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_fifo_low);
> +
> +int sched_set_normal(struct task_struct *p, int nice)
> +{
> +	struct sched_attr attr = {
> +		.sched_policy = SCHED_NORMAL,
> +		.sched_nice = nice,
> +	};
> +	return sched_setattr_nocheck(p, &attr);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_normal);
> +
>  static int
>  do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
>  {
> 
> 
