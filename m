Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5182D146D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLGPIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:08:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLGPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:08:46 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607353684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnrHnr5z4bTR9nOXE88DDCJG1jPdD/bbnxuuRi+Jxi8=;
        b=I0Yp6zf5TNIfafQM3iNcQDsde5tYVKlZw43vWSuUwbUydYaxPnvnBIHr/LF8DKZnekSolz
        1IbSa10wLpLl3tYHRmW53/4S9neB3C6Ty2GntLQx8/RNLQ4AYA2rIOfxOKt5lLjAaBDNJY
        UX6RIAJ0e/dsug7VR8zSf48I2PdCSbzCUHC6rSqJCL0vQzcVQhPqrC7B2HDJ4WOXerkwXT
        yi5RY7Blg8OUpH4VUAO51sCSnspp5rcAlSCRzAFympgg2Q5+37qfhzsFxHIL5/2sQALf7y
        bs8m0hk5VIB/qvNVPZnMQNs5qDPIa782SXV5xLr3S5O9md1XZHLo4wwavDc5MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607353684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnrHnr5z4bTR9nOXE88DDCJG1jPdD/bbnxuuRi+Jxi8=;
        b=a7/L2TkYnB4w+HGE914/SeGqaeXM1/e7/Q2rkUx/lLgRLL3oq7z9yo18fbrk/WbK0V1Uq4
        /7eXnGN3TAfnlcCg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201207141609.GE122233@lothringen>
References: <20201204170151.960336698@linutronix.de> <20201204170805.114951971@linutronix.de> <20201207141609.GE122233@lothringen>
Date:   Mon, 07 Dec 2020 16:08:04 +0100
Message-ID: <871rg17iy3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 15:16, Frederic Weisbecker wrote:
> On Fri, Dec 04, 2020 at 06:01:55PM +0100, Thomas Gleixner wrote:
>> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>> +{
>> +	unsigned long flags;
>> +	int newcnt;
>> +
>> +	WARN_ON_ONCE(in_hardirq());
>> +
>> +	/* First entry of a task into a BH disabled section? */
>> +	if (!current->softirq_disable_cnt) {
>> +		if (preemptible()) {
>> +			local_lock(&softirq_ctrl.lock);
>> +			/* Required to meet the RCU bottomhalf requirements. */
>> +			rcu_read_lock();
>> +		} else {
>> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
>
> So, to be clear this adds a new constraint where we can't call
> local_bh_disable() inside a preempt disabled section? I guess the rest of the
> RT code chased all the new offenders :-)

There are not that many.

>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Track the per CPU softirq disabled state. On RT this is per CPU
>> +	 * state to allow preemption of bottom half disabled sections.
>> +	 */
>> +	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
>> +	/*
>> +	 * Reflect the result in the task state to prevent recursion on the
>> +	 * local lock and to make softirq_count() & al work.
>> +	 */
>> +	current->softirq_disable_cnt = newcnt;
>> +
>> +	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
>> +		raw_local_irq_save(flags);
>> +		lockdep_softirqs_off(ip);
>> +		raw_local_irq_restore(flags);
>> +	}
>> +}
>> +EXPORT_SYMBOL(__local_bh_disable_ip);
>> +
> [...]
>> +
>> +void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>> +{
>> +	bool preempt_on = preemptible();
>> +	unsigned long flags;
>> +	u32 pending;
>> +	int curcnt;
>> +
>> +	WARN_ON_ONCE(in_irq());
>> +	lockdep_assert_irqs_enabled();
>> +
>> +	local_irq_save(flags);
>> +	curcnt = this_cpu_read(softirq_ctrl.cnt);
>
> __this_cpu_read() ?

Yes.

>> +
>> +	/*
>> +	 * If this is not reenabling soft interrupts, no point in trying to
>> +	 * run pending ones.
>> +	 */
>> +	if (curcnt != cnt)
>> +		goto out;
>
> I guess you could move the local_irq_save() here?

Indeed.

