Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983812D2AA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgLHMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgLHMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:23:48 -0500
Date:   Tue, 8 Dec 2020 13:23:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607430188;
        bh=utgRFHc5eDVfTJt/ATnGSUDOGde5zn7hRl74TtGW2gA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=S47or7LRaZu3Y5dAxGJkmmsSn5d5gMhDLDDS9p+sOvxxDx868SxlD53tRdsrGmh8w
         hOBoISFd2m0lqNKChKYvO5IxHc1al/Yaa/F5VJXHBMpGBMpZAKyTfrpjikBmea8zcG
         w/KSzLLbmttPcpqk2W00MuNDyUGWCruvqTcJfJVG9XcSlKc31vb4g2v4Sy8jqrGZkT
         wfqDLw/477RZIRbnLXRZwz4rimCAvBkXyof0jMq6aQSGnWQXyTKoKGY04UK7dytKnB
         RfmnHCGd4tRwwUv1uxAVGObBeGa7vPfjtUk20UWkYMgAKW7LGVht0oBJMY3T04kqAk
         6kcI9K09p615g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 5/9] tick/sched: Prevent false positive softirq
 pending warnings on RT
Message-ID: <20201208122300.GA16597@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.232293729@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.232293729@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:56PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> On RT a task which has soft interrupts disabled can block on a lock and
> schedule out to idle while soft interrupts are pending. This triggers the
> warning in the NOHZ idle code which complains about going idle with pending
> soft interrupts. But as the task is blocked soft interrupt processing is
> temporarily blocked as well which means that such a warning is a false
> positive.
> 
> To prevent that check the per CPU state which indicates that a scheduled
> out task has soft interrupts disabled.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/bottom_half.h |    6 ++++++
>  kernel/softirq.c            |   15 +++++++++++++++
>  kernel/time/tick-sched.c    |    2 +-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/bottom_half.h
> +++ b/include/linux/bottom_half.h
> @@ -32,4 +32,10 @@ static inline void local_bh_enable(void)
>  	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>  }
>  
> +#ifdef CONFIG_PREEMPT_RT
> +extern bool local_bh_blocked(void);
> +#else
> +static inline bool local_bh_blocked(void) { return false; }
> +#endif
> +
>  #endif /* _LINUX_BH_H */
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -138,6 +138,21 @@ static DEFINE_PER_CPU(struct softirq_ctr
>  	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
>  };
>  
> +/**
> + * local_bh_blocked() - Check for idle whether BH processing is blocked
> + *
> + * Returns false if the per CPU softirq::cnt is 0 otherwise true.
> + *
> + * This is invoked from the idle task to guard against false positive
> + * softirq pending warnings, which would happen when the task which holds
> + * softirq_ctrl::lock was the only running task on the CPU and blocks on
> + * some other lock.
> + */
> +bool local_bh_blocked(void)
> +{
> +	return this_cpu_read(softirq_ctrl.cnt) != 0;

__this_cpu_read()

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
