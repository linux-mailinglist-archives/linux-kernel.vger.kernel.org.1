Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CE12CF37E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgLDSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgLDSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:00:04 -0500
Date:   Fri, 4 Dec 2020 09:59:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607104764;
        bh=stx28BLkuSKf75/8Q2amOwQXxovpFdEOUeWIz6NzVY4=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yzh44eBjSDs+/li8CL5E64EJc2uekRuqwExYejoDtHuXtqYK7lqo3nTz9iyUgwBu0
         dq894nqGHv8bjL6WWD+FBJ+mzlJyT3mTD8H8SILcWMiJPEEtuOuEebJoVn8+yZDFqy
         ahCOtlop9tMDcEtY572jXr5GdC88lxaB2U13ptLCMnfsWyiRgucC6/x2WzgiZlzDkE
         M2DXjDcCPoGn9m2MAoGZMdTciC+yppseTgqZsvlPFhZQphKmDx3YYA2cZXFoi7sFHS
         GIIWOogojbAsIimPJl7wEZbavnH+KQx3NmkTOrgyyfvITLMs7YOYb8S1iqe+iWuQMF
         lGVo5U/3kWRvA==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 6/9] rcu: Prevent false positive softirq warning on RT
Message-ID: <20201204175923.GZ1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.338268919@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.338268919@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:57PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Soft interrupt disabled sections can legitimately be preempted or schedule
> out when blocking on a lock on RT enabled kernels so the RCU preempt check
> warning has to be disabled for RT kernels.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -319,7 +319,8 @@ static inline void rcu_preempt_sleep_che
>  #define rcu_sleep_check()						\
>  	do {								\
>  		rcu_preempt_sleep_check();				\
> -		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
> +		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
> +		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
>  				 "Illegal context switch in RCU-bh read-side critical section"); \
>  		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
>  				 "Illegal context switch in RCU-sched read-side critical section"); \
> 
