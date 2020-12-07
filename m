Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F502D135F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgLGOQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgLGOQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:16:52 -0500
Date:   Mon, 7 Dec 2020 15:16:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607350571;
        bh=oIbPhMNR4XARO0ja7uESeoODzJpLh1tAKSR4EIr8wdE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=La/mOMIgf1ROy+6yRYs4PrRaRmCr8ULNmKdQ0wbhNi7WBXbrogQenZQ+h9Y3kKEKd
         R8DY3N2V67yuRg0XcEawacjBzMg1womPRnQ23I74A9PlwxuH72oWKXMWlkyHAxiSgn
         yMQkioE9mjWIb3hCdP8CUcQAU23DRwnfFkGM1E9jhpyl+B34/RPhBbDRkMqr/ypQGX
         A0kHuoYZd7G7ehhu7pP8d0k9b/yKPF8hiEf8k3iXA/L1dqOMJj9zHz/me1179AFwgi
         9Wz8zERTuucoQWYC5/eIyLXa9FGcQFowaHVyWlD+iRYbChgIJRwO5ECcn8/eGsk945
         XyHPuQqdPsIZw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201207141609.GE122233@lothringen>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.114951971@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.114951971@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int newcnt;
> +
> +	WARN_ON_ONCE(in_hardirq());
> +
> +	/* First entry of a task into a BH disabled section? */
> +	if (!current->softirq_disable_cnt) {
> +		if (preemptible()) {
> +			local_lock(&softirq_ctrl.lock);
> +			/* Required to meet the RCU bottomhalf requirements. */
> +			rcu_read_lock();
> +		} else {
> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));

So, to be clear this adds a new constraint where we can't call
local_bh_disable() inside a preempt disabled section? I guess the rest of the
RT code chased all the new offenders :-)

> +		}
> +	}
> +
> +	/*
> +	 * Track the per CPU softirq disabled state. On RT this is per CPU
> +	 * state to allow preemption of bottom half disabled sections.
> +	 */
> +	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
> +	/*
> +	 * Reflect the result in the task state to prevent recursion on the
> +	 * local lock and to make softirq_count() & al work.
> +	 */
> +	current->softirq_disable_cnt = newcnt;
> +
> +	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
> +		raw_local_irq_save(flags);
> +		lockdep_softirqs_off(ip);
> +		raw_local_irq_restore(flags);
> +	}
> +}
> +EXPORT_SYMBOL(__local_bh_disable_ip);
> +
[...]
> +
> +void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	bool preempt_on = preemptible();
> +	unsigned long flags;
> +	u32 pending;
> +	int curcnt;
> +
> +	WARN_ON_ONCE(in_irq());
> +	lockdep_assert_irqs_enabled();
> +
> +	local_irq_save(flags);
> +	curcnt = this_cpu_read(softirq_ctrl.cnt);

__this_cpu_read() ?

> +
> +	/*
> +	 * If this is not reenabling soft interrupts, no point in trying to
> +	 * run pending ones.
> +	 */
> +	if (curcnt != cnt)
> +		goto out;

I guess you could move the local_irq_save() here?

> +	pending = local_softirq_pending();
> +	if (!pending || ksoftirqd_running(pending))
> +		goto out;
> +
> +	/*
> +	 * If this was called from non preemptible context, wake up the
> +	 * softirq daemon.
> +	 */
> +	if (!preempt_on) {
> +		wakeup_softirqd();
> +		goto out;
> +	}
> +
> +	/*
> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> +	 * in_serving_softirq() become true.
> +	 */
> +	cnt = SOFTIRQ_OFFSET;
> +	__local_bh_enable(cnt, false);
> +	__do_softirq();
> +
> +out:
> +	__local_bh_enable(cnt, preempt_on);
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(__local_bh_enable_ip);

Thanks.
