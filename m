Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A630277D17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIYAmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIYAmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:42:11 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD97C2371F;
        Fri, 25 Sep 2020 00:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600994531;
        bh=TCfSEA+H7aOgaW8Nsc69cPihnr8c1iFQSE73UuGOoIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIqP8QW88Vwb6grAdYfOjDccP0gTXQXZmiUnl5zs+1cKp0hUnywzCUlCG/QgALEH+
         32tbjiqLA3Cq4ZHbdC3ATmGwpewOHoJVkS81RU+D/tz4+nOEJ2ObzVzn/rd3FSASTA
         j+WyAf4nyrzLjaKZcYoCsm+Ez0IpOpaRLxY3QuVI=
Date:   Fri, 25 Sep 2020 02:42:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200925004207.GE19346@lenoir>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
 <878scz89tl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878scz89tl.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
> Subject: softirq; Prevent starvation of higher softirq vectors
[...]
> +	/*
> +	 * Word swap pending to move the not yet handled bits of the previous
> +	 * run first and then clear the duplicates in the newly raised ones.
> +	 */
> +	swahw32s(&cur_pending);
> +	pending = cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
> +
>  	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
>  		int prev_count;
>  
> +		vec_nr &= SIRQ_VECTOR_MASK;

Shouldn't NR_SOFTIRQS above protect from that?

>  		__clear_bit(vec_nr, &pending);
>  		kstat_incr_softirqs_this_cpu(vec_nr);
>
[...]
> +	} else {
> +		/*
> +		 * Retain the unprocessed bits and swap @cur_pending back
> +		 * into normal ordering
> +		 */
> +		cur_pending = (u32)pending;
> +		swahw32s(&cur_pending);
> +		/*
> +		 * If the previous bits are done move the low word of
> +		 * @pending into the high word so it's processed first.
> +		 */
> +		if (!(cur_pending & SIRQ_PREV_MASK))
> +			cur_pending <<= SIRQ_PREV_SHIFT;

If the previous bits are done and there is no timeout, should
we consider to restart a loop?

A common case would be to enter do_softirq() with RCU_SOFTIRQ set
in the SIRQ_PREV_MASK and NET_RX_SOFTIRQ set in the normal mask.

You would always end up processing the RCU_SOFTIRQ here and trigger
ksoftirqd for the NET_RX_SOFTIRQ.

Although that's probably no big deal as we should be already in ksoftirqd
if we processed prev bits. We are just going to iterate the kthread loop
instead of the do_softirq loop. Probably no real issue then...


>  
> +		/* Merge the newly pending ones into the low word */
> +		cur_pending |= new_pending;
> +	}
> +	set_softirq_pending(cur_pending);
>  	wakeup_softirqd();
>  out:
>  	lockdep_softirq_end(in_hardirq);

