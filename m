Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8302DA7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 06:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgLOFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 00:37:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:56478 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgLOFhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 00:37:37 -0500
IronPort-SDR: l+2uFaDPv1nCJfL1Bh2dFLPHo8K1bLR3jaMUV8AsocNsrx1APDjpRGTj85nQVGsEGmox82Hn+Y
 bEkeV3QhJ1MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="193197872"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="193197872"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:35:51 -0800
IronPort-SDR: DkPnyV8K18XSavFe1h94e/LO6naWwfO/HCwlvCgDLYEkg7rbAGGuD/jFu/LyQbRqmgF/N3U1gD
 A4iNf8V/EGfw==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="368031348"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.5.96]) ([10.238.5.96])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:35:48 -0800
Subject: Re: [LKP] Re: [sched/hotplug] 2558aacff8:
 will-it-scale.per_thread_ops -1.6% regression
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, zhengjun.xing@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
References: <20201210081859.GA19784@xsang-OptiPlex-9020>
 <20201210161408.GX3021@hirez.programming.kicks-ass.net>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <33c543f8-97c9-cb18-a2f8-a90b8a5769cc@linux.intel.com>
Date:   Tue, 15 Dec 2020 13:35:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210161408.GX3021@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2020 12:14 AM, Peter Zijlstra wrote:
> On Thu, Dec 10, 2020 at 04:18:59PM +0800, kernel test robot wrote:
>> FYI, we noticed a -1.6% regression of will-it-scale.per_thread_ops due to commit:
>> commit: 2558aacff8586699bcd248b406febb28b0a25de2 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
> 
> Mooo, weird but whatever. Does the below help at all?

I test the patch, the regression reduced to -0.6%.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode:
 
lkp-cpl-4sp1/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/100%/thread/sched_yield/performance/0x700001e

commit:
   565790d28b1e33ee2f77bad5348b99f6dfc366fd
   2558aacff8586699bcd248b406febb28b0a25de2
   4b26139b8db627a55043183614a32b0aba799d27 (this test patch)

565790d28b1e33ee 2558aacff8586699bcd248b406f 4b26139b8db627a55043183614a
---------------- --------------------------- ---------------------------
          %stddev     %change         %stddev     %change         %stddev
              \          |                \          |                \
  4.011e+08            -1.6%  3.945e+08            -0.6%  3.989e+08 
    will-it-scale.144.threads
    2785455            -1.6%    2739520            -0.6%    2769967 
    will-it-scale.per_thread_ops
  4.011e+08            -1.6%  3.945e+08            -0.6%  3.989e+08 
    will-it-scale.workload

> 
> ---
>   kernel/sched/core.c  | 40 +++++++++++++++-------------------------
>   kernel/sched/sched.h | 13 +++++--------
>   2 files changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7af80c3fce12..f80245c7f903 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3985,15 +3985,20 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
>   	}
>   }
>   
> +static void balance_push(struct rq *rq);
> +
> +struct callback_head balance_push_callback = {
> +	.next = NULL,
> +	.func = (void (*)(struct callback_head *))balance_push,
> +};
> +
>   static inline struct callback_head *splice_balance_callbacks(struct rq *rq)
>   {
>   	struct callback_head *head = rq->balance_callback;
>   
>   	lockdep_assert_held(&rq->lock);
> -	if (head) {
> +	if (head)
>   		rq->balance_callback = NULL;
> -		rq->balance_flags &= ~BALANCE_WORK;
> -	}
>   
>   	return head;
>   }
> @@ -4014,21 +4019,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
>   	}
>   }
>   
> -static void balance_push(struct rq *rq);
> -
> -static inline void balance_switch(struct rq *rq)
> -{
> -	if (likely(!rq->balance_flags))
> -		return;
> -
> -	if (rq->balance_flags & BALANCE_PUSH) {
> -		balance_push(rq);
> -		return;
> -	}
> -
> -	__balance_callbacks(rq);
> -}
> -
>   #else
>   
>   static inline void __balance_callbacks(struct rq *rq)
> @@ -4044,10 +4034,6 @@ static inline void balance_callbacks(struct rq *rq, struct callback_head *head)
>   {
>   }
>   
> -static inline void balance_switch(struct rq *rq)
> -{
> -}
> -
>   #endif
>   
>   static inline void
> @@ -4075,7 +4061,7 @@ static inline void finish_lock_switch(struct rq *rq)
>   	 * prev into current:
>   	 */
>   	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
> -	balance_switch(rq);
> +	__balance_callbacks(rq);
>   	raw_spin_unlock_irq(&rq->lock);
>   }
>   
> @@ -7256,6 +7242,10 @@ static void balance_push(struct rq *rq)
>   
>   	lockdep_assert_held(&rq->lock);
>   	SCHED_WARN_ON(rq->cpu != smp_processor_id());
> +	/*
> +	 * Ensure the thing is persistent until balance_push_set(, on = false);
> +	 */
> +	rq->balance_callback = &balance_push_callback;
>   
>   	/*
>   	 * Both the cpu-hotplug and stop task are in this case and are
> @@ -7305,9 +7295,9 @@ static void balance_push_set(int cpu, bool on)
>   
>   	rq_lock_irqsave(rq, &rf);
>   	if (on)
> -		rq->balance_flags |= BALANCE_PUSH;
> +		rq->balance_callback = &balance_push_callback;
>   	else
> -		rq->balance_flags &= ~BALANCE_PUSH;
> +		rq->balance_callback = NULL;
>   	rq_unlock_irqrestore(rq, &rf);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f5acb6c5ce49..12ada79d40f3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -975,7 +975,6 @@ struct rq {
>   	unsigned long		cpu_capacity_orig;
>   
>   	struct callback_head	*balance_callback;
> -	unsigned char		balance_flags;
>   
>   	unsigned char		nohz_idle_balance;
>   	unsigned char		idle_balance;
> @@ -1226,6 +1225,8 @@ struct rq_flags {
>   #endif
>   };
>   
> +extern struct callback_head balance_push_callback;
> +
>   /*
>    * Lockdep annotation that avoids accidental unlocks; it's like a
>    * sticky/continuous lockdep_assert_held().
> @@ -1243,9 +1244,9 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>   #ifdef CONFIG_SCHED_DEBUG
>   	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>   	rf->clock_update_flags = 0;
> -#endif
>   #ifdef CONFIG_SMP
> -	SCHED_WARN_ON(rq->balance_callback);
> +	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
> +#endif
>   #endif
>   }
>   
> @@ -1408,9 +1409,6 @@ init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>   
>   #ifdef CONFIG_SMP
>   
> -#define BALANCE_WORK	0x01
> -#define BALANCE_PUSH	0x02
> -
>   static inline void
>   queue_balance_callback(struct rq *rq,
>   		       struct callback_head *head,
> @@ -1418,13 +1416,12 @@ queue_balance_callback(struct rq *rq,
>   {
>   	lockdep_assert_held(&rq->lock);
>   
> -	if (unlikely(head->next || (rq->balance_flags & BALANCE_PUSH)))
> +	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
>   		return;
>   
>   	head->func = (void (*)(struct callback_head *))func;
>   	head->next = rq->balance_callback;
>   	rq->balance_callback = head;
> -	rq->balance_flags |= BALANCE_WORK;
>   }
>   
>   #define rcu_dereference_check_sched_domain(p) \
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
> 

-- 
Zhengjun Xing
