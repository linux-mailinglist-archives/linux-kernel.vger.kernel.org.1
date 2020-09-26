Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1CF2798CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIZMWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 08:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZMWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 08:22:23 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBA2238E6;
        Sat, 26 Sep 2020 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601122943;
        bh=006xBjR82/BKPE/0UZL1e7DnAaSXPsvHWZB2ii5OHRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9/rcOxD3HnEPIxfBmym1/0xY+YLsFoiMYzuw+IeqQXV79VFa/aKFDwF0frrZFodq
         MVG04PGkGfuvlwEq8+dQ9Ss0/rTdcIA+UAd3jwNRZc6kQQCCi/3AJubzOyECcLWPnO
         3tMbTlK33QSt+C67qew3E5V3m56OoiI7H0bCn7JY=
Date:   Sat, 26 Sep 2020 14:22:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200926122220.GA10735@lenoir>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
 <878scz89tl.fsf@nanos.tec.linutronix.de>
 <20200925004207.GE19346@lenoir>
 <874knlv5pq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874knlv5pq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 12:42:25AM +0200, Thomas Gleixner wrote:
> On Fri, Sep 25 2020 at 02:42, Frederic Weisbecker wrote:
> 
> > On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
> >> Subject: softirq; Prevent starvation of higher softirq vectors
> > [...]
> >> +	/*
> >> +	 * Word swap pending to move the not yet handled bits of the previous
> >> +	 * run first and then clear the duplicates in the newly raised ones.
> >> +	 */
> >> +	swahw32s(&cur_pending);
> >> +	pending = cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
> >> +
> >>  	for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
> >>  		int prev_count;
> >>  
> >> +		vec_nr &= SIRQ_VECTOR_MASK;
> >
> > Shouldn't NR_SOFTIRQS above protect from that?
> 
> It does, but that's wrong. The bitmap size in that for_each() loop must
> obviously be SIRQ_PREV_SHIFT + NR_SOFTIRQS for this to work.

Ah! I see, I thought you were ignoring the high bits on
purpose, hence my questions after about pending.

> 
> >> +	} else {
> >> +		/*
> >> +		 * Retain the unprocessed bits and swap @cur_pending back
> >> +		 * into normal ordering
> >> +		 */
> >> +		cur_pending = (u32)pending;
> >> +		swahw32s(&cur_pending);
> >> +		/*
> >> +		 * If the previous bits are done move the low word of
> >> +		 * @pending into the high word so it's processed first.
> >> +		 */
> >> +		if (!(cur_pending & SIRQ_PREV_MASK))
> >> +			cur_pending <<= SIRQ_PREV_SHIFT;
> >
> > If the previous bits are done and there is no timeout, should
> > we consider to restart a loop?
> 
> We only enter this code path if there was a timeout. Otherwise pending
> would be 0.

Right with SIRQ_PREV_SHIFT + NR_SOFTIRQS now that whole makes sense!

Thanks!
