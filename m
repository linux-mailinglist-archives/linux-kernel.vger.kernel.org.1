Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D963F2664E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgIKQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:48:02 -0400
Received: from foss.arm.com ([217.140.110.172]:39316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgIKQqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:46:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4065106F;
        Fri, 11 Sep 2020 09:46:48 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69EDD3F68F;
        Fri, 11 Sep 2020 09:46:47 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:46:45 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     qianjun.kernel@gmail.com
Cc:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, urezki@gmail.com,
        John Dias <joaodias@google.com>, Wei Wang <wvw@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH V6 1/1] Softirq:avoid large sched delay from the pending
 softirqs
Message-ID: <20200911164644.eqjqjucvqfvrmr67@e107158-lin.cambridge.arm.com>
References: <20200909090931.8836-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909090931.8836-1-qianjun.kernel@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/20 17:09, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> When get the pending softirqs, it need to process all the pending
> softirqs in the while loop. If the processing time of each pending
> softirq is need more than 2 msec in this loop, or one of the softirq
> will running a long time, according to the original code logic, it
> will process all the pending softirqs without wakeuping ksoftirqd,
> which will cause a relatively large scheduling delay on the
> corresponding CPU, which we do not wish to see. The patch will check
> the total time to process pending softirq, if the time exceeds 2 ms
> we need to wakeup the ksofirqd to aviod large sched delay.
> 
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>

In Android there's a patch that tries to avoid schedling an RT task on a cpu
that is running softirqs. I wonder if this patch helps with this case.

https://android.googlesource.com/kernel/msm/+/5c3f54c34acf4d9ed01530288d4a98acff815d79%5E%21/#F0

John, Wei, is this something of interest to you?

IIUC this patch will make sure the total softirq duration is 2ms rather than
each call is 2ms.

I persume if there's a single handler that takes a lot of time then this won't
help. But in that case, one can argue there's a potential bug with this
handler.

Cheers

--
Qais Yousef

> ---
>  kernel/softirq.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c4201b7f..1f696c8 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -25,6 +25,7 @@
>  #include <linux/smpboot.h>
>  #include <linux/tick.h>
>  #include <linux/irq.h>
> +#include <linux/sched/clock.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/irq.h>
> @@ -199,18 +200,17 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>  
>  /*
>   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
> - * but break the loop if need_resched() is set or after 2 ms.
> - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
> - * certain cases, such as stop_machine(), jiffies may cease to
> - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> - * well to make sure we eventually return from this method.
> + * but break the loop if need_resched() is set or after MAX_SOFTIRQ_TIME_NS
> + * ns. In the loop, if the processing time of the softirq has exceeded
> + * MAX_SOFTIRQ_TIME_NS ns, we also need to break the loop to wakeup the
> + * ksofirqd.
>   *
>   * These limits have been established via experimentation.
>   * The two things to balance is latency against fairness -
>   * we want to handle softirqs as soon as possible, but they
>   * should not be able to lock up the box.
>   */
> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
> +#define MAX_SOFTIRQ_TIME_NS 2000000
>  #define MAX_SOFTIRQ_RESTART 10
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -246,15 +246,20 @@ static inline void lockdep_softirq_end(bool in_hardirq)
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>  
> +DEFINE_PER_CPU(__u32, pending_new_flag);
> +DEFINE_PER_CPU(__u32, pending_next_bit);
> +#define SOFTIRQ_PENDING_MASK ((1UL << NR_SOFTIRQS) - 1)
> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> +	u64 end = sched_clock() + MAX_SOFTIRQ_TIME_NS;
>  	unsigned long old_flags = current->flags;
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
>  	bool in_hardirq;
> -	__u32 pending;
> -	int softirq_bit;
> +	__u32 pending, pending_left, pending_new;
> +	int softirq_bit, next_bit;
> +	unsigned long flags;
>  
>  	/*
>  	 * Mask out PF_MEMALLOC as the current task context is borrowed for the
> @@ -277,10 +282,33 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  
>  	h = softirq_vec;
>  
> -	while ((softirq_bit = ffs(pending))) {
> -		unsigned int vec_nr;
> +	next_bit = per_cpu(pending_next_bit, smp_processor_id());
> +	per_cpu(pending_new_flag, smp_processor_id()) = 0;
> +
> +	pending_left = pending &
> +		(SOFTIRQ_PENDING_MASK << next_bit);
> +	pending_new = pending &
> +		(SOFTIRQ_PENDING_MASK >> (NR_SOFTIRQS - next_bit));
> +
> +	/*
> +	 * In order to be fair, we shold process the pengding bits by the
> +	 * last processing order.
> +	 */
> +	while ((softirq_bit = ffs(pending_left)) ||
> +		(softirq_bit = ffs(pending_new))) {
>  		int prev_count;
> +		unsigned int vec_nr = 0;
>  
> +		/*
> +		 * when the left pengding bits have been handled, we should
> +		 * to reset the h to softirq_vec.
> +		 */
> +		if (!ffs(pending_left)) {
> +			if (per_cpu(pending_new_flag, smp_processor_id()) == 0) {
> +				h = softirq_vec;
> +				per_cpu(pending_new_flag, smp_processor_id()) = 1;
> +			}
> +		}
>  		h += softirq_bit - 1;
>  
>  		vec_nr = h - softirq_vec;
> @@ -298,17 +326,44 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  			preempt_count_set(prev_count);
>  		}
>  		h++;
> -		pending >>= softirq_bit;
> +
> +		if (ffs(pending_left))
> +			pending_left >>= softirq_bit;
> +		else
> +			pending_new >>= softirq_bit;
> +
> +		/*
> +		 * the softirq's action has been run too much time,
> +		 * so it may need to wakeup the ksoftirqd
> +		 */
> +		if (need_resched() && sched_clock() > end) {
> +			/*
> +			 * Ensure that the remaining pending bits will be
> +			 * handled.
> +			 */
> +			local_irq_save(flags);
> +			if (ffs(pending_left))
> +				or_softirq_pending((pending_left << (vec_nr + 1)) |
> +							pending_new);
> +			else
> +				or_softirq_pending(pending_new << (vec_nr + 1));
> +			local_irq_restore(flags);
> +			per_cpu(pending_next_bit, smp_processor_id()) = vec_nr + 1;
> +			break;
> +		}
>  	}
>  
> +	/* reset the pending_next_bit */
> +	per_cpu(pending_next_bit, smp_processor_id()) = 0;
> +
>  	if (__this_cpu_read(ksoftirqd) == current)
>  		rcu_softirq_qs();
>  	local_irq_disable();
>  
>  	pending = local_softirq_pending();
>  	if (pending) {
> -		if (time_before(jiffies, end) && !need_resched() &&
> -		    --max_restart)
> +		if (!need_resched() && --max_restart &&
> +		    sched_clock() <= end)
>  			goto restart;
>  
>  		wakeup_softirqd();
> -- 
> 1.8.3.1
> 
