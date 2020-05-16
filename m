Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB41D5E15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgEPDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 23:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgEPDHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 23:07:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD632073E;
        Sat, 16 May 2020 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589598438;
        bh=1b8MmOMwKzarMS/FSgx6QArmP+E1/8A+fav5brKGy24=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Oka86VCgwy4gmpIZrFRQ00zq4FJ9fIOpRLz2hNAfTHkU8bY0HUzWiRT1xeDmTpFQU
         38yshK11+mj44NHIYZdE+UmdN1viinT3Vp0PfA0/9AG5UDw1mFNRtFiQWtA1RoGFit
         AiBV7hFJBOoj4XWggryGu7Qjch+psVFfsXEpOTH8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1A9BF35234B4; Fri, 15 May 2020 20:07:18 -0700 (PDT)
Date:   Fri, 15 May 2020 20:07:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>, stable@kernel.org
Subject: Re: [PATCH] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Message-ID: <20200516030718.GL2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200515003429.4317-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515003429.4317-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:29AM +0200, Frederic Weisbecker wrote:
> So far setting a tick dependency on any task, including current, used to
> trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
> an issue as long as it was only used by posix-cpu-timers on nohz_full,
> a combo that nobody seemed to use in real life.
> 
> But RCU started to use task tick dependency on current task to fix
> stall issues on callbacks processing. These trigger regular and
> undesired system wide IPIs on nohz_full.
> 
> The fix is very easy while setting a tick dependency on the current
> task, only its CPU needs an IPI.

This passes moderate rcutorture testing.  If you want me to take it, please
let me know, and otherwise:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
> Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: stable@kernel.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/time/tick-sched.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 3e2dc9b8858c..f0199a4ba1ad 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
>  EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
>  
>  /*
> - * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
> - * per task timers.
> + * Set a per-task tick dependency. RCU need this. Also posix CPU timers
> + * in order to elapse per task timers.
>   */
>  void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
>  {
> -	/*
> -	 * We could optimize this with just kicking the target running the task
> -	 * if that noise matters for nohz full users.
> -	 */
> -	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
> +	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
> +		if (tsk == current) {
> +			preempt_disable();
> +			tick_nohz_full_kick();
> +			preempt_enable();
> +		} else {
> +			/*
> +			 * Some future tick_nohz_full_kick_task()
> +			 * should optimize this.
> +			 */
> +			tick_nohz_full_kick_all();
> +		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
>  
> -- 
> 2.26.2
> 
