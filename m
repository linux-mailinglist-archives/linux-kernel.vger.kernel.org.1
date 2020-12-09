Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957DF2D3F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgLIKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgLIKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:11:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C0C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 02:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x0VZ08ZyDvqYZ0g3miV9tckufVtVAHqucqobOSyGKtw=; b=ov0FanHmetPX7i1lNqw3IRvo5G
        sgHiQnbopg+J5Bxmr2NDmq8B7iWnSfzgRV1dswAeIYooN1KXkoNNf7J3bYaOPB2jpTHo202+XVFY3
        a79ED0556A0KENdYU+urEml4Lf9Yag2dtFPo/kJljSx8L9I5HB2sgbSeMGYI5M8rAIA5gD3qXfBdl
        u8mJyTALNEq/dxEys77/tQXHn0RjF4VnPyt4izAefjVkWL9dowyNgzsyIin3cUn5cWuUeQB4FFUlq
        35rAGsIPMZike39xxNBjC5ldxfu9NsnfdFkINZF2wWHPsSO8n3OgybuoSrV1LiMbl2z5pJr7BSaZN
        IMRv1mXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmwR9-0007Af-FY; Wed, 09 Dec 2020 10:11:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9B16305C1C;
        Wed,  9 Dec 2020 11:11:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2FAA20819094; Wed,  9 Dec 2020 11:11:02 +0100 (CET)
Date:   Wed, 9 Dec 2020 11:11:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [patch V2 4/9] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201209101102.GJ2414@hirez.programming.kicks-ass.net>
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
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide a local lock based serialization for soft interrupts on RT which
> allows the local_bh_disabled() sections and servicing soft interrupts to be
> preemptible.
> 
> Provide the necessary inline helpers which allow to reuse the bulk of the
> softirq processing code.

> +struct softirq_ctrl {
> +	local_lock_t	lock;
> +	int		cnt;
> +};
> +
> +static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
> +	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
> +};
> +
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

AFAICT this significantly changes the locking rules.

Where previously we could do:

	spin_lock(&ponies)
	spin_lock_bh(&foo);

vs

	spin_lock_bh(&bar);
	spin_lock(&ponies)

provided the rest of the code observed: bar -> ponies -> foo
and never takes ponies from in-softirq.

This is now a genuine deadlock on RT.

Also see:

  https://lkml.kernel.org/r/X9CheYjuXWc75Spa@hirez.programming.kicks-ass.net

> +			/* Required to meet the RCU bottomhalf requirements. */
> +			rcu_read_lock();
> +		} else {
> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
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


