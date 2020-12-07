Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943FC2D08AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgLGA6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 19:58:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGA6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 19:58:07 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607302645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RqWejZ64vo1PJw6viCjSv1U/BAWfm+OSTAVUkrWIHbA=;
        b=tbHQqbyUM5Q13y3AdW1lqOri4TlhKxVYBuPfZyWV85a53PFS2sIYJu97yJT9RFZe/fi+wo
        58Q6Jy2RV2wn+JBU2NfhozF6KNOBRXxUkrRr5geF4QVO118a0u90VX6OVAlqoN2k8NarNC
        g1gb05zwn8LlZ/wiPfglX1pKFEe7bhxaWgpq+ZAr071ub+iOz456qGy44zhW+nO2fhqvEj
        nWrIRxP0rhI2e+dXZpdpflZI5r/FZUoICNeB+03qoqNsbHo/T/HeN45C0r5qYQZK6MxU4o
        LtqKCZ2cVOvl8T/siCHh4/5OzjEPij/tmXkHrbM8Eai2WcfUlreq4p4mguf/mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607302645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RqWejZ64vo1PJw6viCjSv1U/BAWfm+OSTAVUkrWIHbA=;
        b=ieiJcAW10zcO/FBw8IDYsfuzkq2oFURPcZN4ZsofLbKdiX7PvZ91d8fnj63sOT7R8DHzyN
        PIotgTAWVCsh4YCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 2/9] irqtime: Make accounting correct on RT
In-Reply-To: <20201207002343.GA113660@lothringen>
References: <20201204170151.960336698@linutronix.de> <20201204170804.889561591@linutronix.de> <20201207002343.GA113660@lothringen>
Date:   Mon, 07 Dec 2020 01:57:25 +0100
Message-ID: <87czzm77re.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 01:23, Frederic Weisbecker wrote:
>> --- a/kernel/sched/cputime.c
>> +++ b/kernel/sched/cputime.c
>> @@ -60,7 +60,7 @@ void irqtime_account_irq(struct task_str
>>  	cpu = smp_processor_id();
>>  	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
>>  	irqtime->irq_start_time += delta;
>> -	pc = preempt_count() - offset;
>> +	pc = irq_count() - offset;
>
> There are many preempt_count() users all around waiting for similar issues.
> Wouldn't it be more reasonable to have current->softirq_disable_cnt just saving
> the softirq count on context switch?

There are not that many and all of them need to be looked at.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d2003a7d5ab5..6c899c35d6ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3469,6 +3469,10 @@ static inline void prepare_task(struct task_struct *next)
>  
>  static inline void finish_task(struct task_struct *prev)
>  {
> +#ifdef CONFIG_PREEMPT_RT
> +	prev->softirq_disable_cnt = softirq_count();
> +	__preempt_count_sub(prev->softirq_disable_cnt);
> +#endif

You fundamentaly break RT with that.

If local_bh_disable() fiddles with the actual preempt_count on RT then
softirq disabled sections and softirq processing are not longer
preemtible.

You asked me in the last round of patches to add a proper argument for
pulling out the softirq count from preempt_count. Here is the revised
changelog which you agreed with:

 "RT requires the softirq processing and local bottomhalf disabled regions to
  be preemptible. Using the normal preempt count based serialization is
  therefore not possible because this implicitely disables preemption.
  ....
 "

Full text in patch 1/9.

According to the above folding of softirq count into the actual preempt
count cannot work at all.

The current RT approach just works except for the places which look at
the raw preempt_count and not using the wrappers. Those places are
restricted to core code and a pretty small number.

Trying to do what you suggest would be a major surgery all over the
place including a complete trainwreck on the highly optimized
preempt_enable() --> preempt decision.

> And I expect a few adjustments in schedule_debug() and atomic checks more
> generally but that should be it and it would probably be less error-prone.

Dream on.

> Although I'm probably overlooking other issues on the way.

I think so.

Thanks,

        tglx
