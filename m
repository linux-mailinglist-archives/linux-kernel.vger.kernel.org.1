Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F802D0D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgLGJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:59:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14FCC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qd2+AlNY9X1REh7opX5R/Afc8FG3yj+a1rEOCbrIfh4=; b=kWsWVo6E7Yc8h2Jl7DGzJTgGEO
        OwmgT0koMJLgiEd3nKsjklgnDKoqi9123olRq6wCa6/liDHWlONN9Zxooyf/lKrsNtwp7wCfjEFCg
        AaTDCkVJII6Dr7mXMLVR+mBTH6oRut/Clfs6fn4RUW5rvKJTXZbgqq1wC+l7ASVO5bbJc9C18Lz3X
        Bf9chnO54FjBSJgLThQtVf8QHxceNIgbBd6+3dXbNwLkVz5bj/WlC0xhl43Lo9AhOZ8s5jJwukalP
        D4vxqc5eo4ZT2YbXFBGo4hKCq9JavKJeD6VY+TIxJGGOxd5ZsJGLzQEykYYCE7/9qpM5dW+NTB4LH
        /uj7OMuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmDIU-0002YC-Ns; Mon, 07 Dec 2020 09:59:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0374F301478;
        Mon,  7 Dec 2020 10:59:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D40A221053394; Mon,  7 Dec 2020 10:59:07 +0100 (CET)
Date:   Mon, 7 Dec 2020 10:59:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: tick/sched: Make jiffies update quick check more robust
Message-ID: <20201207095907.GI3040@hirez.programming.kicks-ass.net>
References: <87czzpc02w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czzpc02w.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:55:19AM +0100, Thomas Gleixner wrote:
>  	/*
> +	 * 64bit can do a quick check without holding jiffies lock and
> +	 * without looking at the sequence count. The smp_load_acquire()
>  	 * pairs with the update done later in this function.
>  	 *
> +	 * 32bit cannot do that because the store of tick_next_period
> +	 * consists of two 32bit stores and the first store could move it
> +	 * to a random point in the future.
>  	 */
> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> +			return;

Explicit ACQUIRE

> +	} else {
> +		unsigned int seq;
> +
> +		/*
> +		 * Avoid contention on jiffies_lock and protect the quick
> +		 * check with the sequence count.
> +		 */
> +		do {
> +			seq = read_seqcount_begin(&jiffies_seq);
> +			nextp = tick_next_period;
> +		} while (read_seqcount_retry(&jiffies_seq, seq));
> +
> +		if (ktime_before(now, nextp))
> +			return;

Actually has an implicit ACQUIRE:

	read_seqcount_retry() implies smp_rmb(), which ensures
	LOAD->LOAD order, IOW any later load must happen after our
	@tick_next_period load.

	Then it has a control dependency on ktime_before(,nextp), which
	ensures LOAD->STORE order.

	Combined we have a LOAD->{LOAD,STORE} order on the
	@tick_next_period load, IOW ACQUIRE.

> +	}
>  
> +	/* Quick check failed, i.e. update is required. */
>  	raw_spin_lock(&jiffies_lock);

Another ACQUIRE, which means the above ACQUIRE only ensures we load the
lock value after?

Or are we trying to guarantee the caller is sure to observe the new
jiffies value if we return?

> +	/*
> +	 * Reevaluate with the lock held. Another CPU might have done the
> +	 * update already.
> +	 */
>  	if (ktime_before(now, tick_next_period)) {
>  		raw_spin_unlock(&jiffies_lock);
>  		return;
> @@ -112,11 +118,25 @@ static void tick_do_update_jiffies64(kti
>  	jiffies_64 += ticks;
>  
>  	/*
> +	 * Keep the tick_next_period variable up to date.
>  	 */
> +	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
> +
> +	if (IS_ENABLED(CONFIG_64BIT)) {
> +		/*
> +		 * Pairs with smp_load_acquire() in the lockless quick
> +		 * check above and ensures that the update to jiffies_64 is
> +		 * not reordered vs. the store to tick_next_period, neither
> +		 * by the compiler nor by the CPU.
> +		 */
> +		smp_store_release(&tick_next_period, nextp);
> +	} else {
> +		/*
> +		 * A plain store is good enough on 32bit as the quick check
> +		 * above is protected by the sequence count.
> +		 */
> +		tick_next_period = nextp;
> +	}
>  
>  	/*
>  	 * Release the sequence count. calc_global_load() below is not
