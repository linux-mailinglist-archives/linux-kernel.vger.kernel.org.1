Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55C72D29A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgLHLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:17:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D42C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iVTXU+Eb22GxdH//i0S9TyPYiQ0IUQqjtgfjwN3FiNo=; b=DM10KibQfuggfZUpv0W1WoruM2
        ZOWv5Wlgw8Wlx5rdir0umKClVdlNzC0E+TO5LngbsrwMC+pg0qkW3lm4SIMZW2/0P9ZQO4e3nIWLx
        U9ClQtmsgK2PH23xSxaZ03605VZLm9UGgDCfxcZctV9N7C37iggAAHG0Y5e6LTBYWqj5wAuTkHqpS
        GSilLyJpyHHpYHy1CUxveRBj1YygmntnYFVe6jpBKAu0t6xh1SDgZ8xzgyjlIkxnS0XeJB2YdWLpB
        GkQAM11Ruk1XFpmCIJ+TY8MF9KS2wteTFp/NMjw+OBPhsvOpVFWqlYkSIeD4Q1c1L7a1fr5ruh7rw
        6s/WjHCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmazA-0006zG-AL; Tue, 08 Dec 2020 11:16:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44D5D3059C6;
        Tue,  8 Dec 2020 12:16:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3082F2009A8EE; Tue,  8 Dec 2020 12:16:44 +0100 (CET)
Date:   Tue, 8 Dec 2020 12:16:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: tick/sched: Make jiffies update quick check more robust
Message-ID: <20201208111644.GV2414@hirez.programming.kicks-ass.net>
References: <87czzpc02w.fsf@nanos.tec.linutronix.de>
 <20201207095907.GI3040@hirez.programming.kicks-ass.net>
 <877dpt7k5w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dpt7k5w.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:41:47PM +0100, Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 10:59, Peter Zijlstra wrote:
> >> +	if (IS_ENABLED(CONFIG_64BIT)) {
> >> +		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> >> +			return;
> >
> > Explicit ACQUIRE
> >
> >> +	} else {
> >> +		unsigned int seq;
> >> +
> >> +		/*
> >> +		 * Avoid contention on jiffies_lock and protect the quick
> >> +		 * check with the sequence count.
> >> +		 */
> >> +		do {
> >> +			seq = read_seqcount_begin(&jiffies_seq);
> >> +			nextp = tick_next_period;
> >> +		} while (read_seqcount_retry(&jiffies_seq, seq));
> >> +
> >> +		if (ktime_before(now, nextp))
> >> +			return;
> >
> > Actually has an implicit ACQUIRE:
> >
> > 	read_seqcount_retry() implies smp_rmb(), which ensures
> > 	LOAD->LOAD order, IOW any later load must happen after our
> > 	@tick_next_period load.
> >
> > 	Then it has a control dependency on ktime_before(,nextp), which
> > 	ensures LOAD->STORE order.
> >
> > 	Combined we have a LOAD->{LOAD,STORE} order on the
> > 	@tick_next_period load, IOW ACQUIRE.

It's actually the whole of:

+               } while (read_seqcount_retry(&jiffies_seq, seq));

That implies the ACQUIRE, don't need the rest.

> >> +	}
> >>  
> >> +	/* Quick check failed, i.e. update is required. */
> >>  	raw_spin_lock(&jiffies_lock);
> >
> > Another ACQUIRE, which means the above ACQUIRE only ensures we load the
> > lock value after?
> >
> > Or are we trying to guarantee the caller is sure to observe the new
> > jiffies value if we return?
> 
> The guarantee we need on 64bit for the check w/o seqcount is:
> 
> CPU0                                         CPU1
> 
>  if (ktime_before(now, tick_next_period))
>  	return;
> 
>  raw_spin_lock(&jiffies_lock);
>  ....
>  jiffies_64 += ticks;                           
>  
>  tick_next_period = next;                   if (ktime_before(now, tick_next_period))
>   	                                           return;
> 
> When CPU1 returns because it observes the new value in tick_next_period
> then it has to be guaranteed that jiffies_64 is observable as well.

Right, it does that. Good.

