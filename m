Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B9427C7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgI2L4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgI2Loc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:44:32 -0400
Received: from localhost (unknown [94.238.194.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4A6206E5;
        Tue, 29 Sep 2020 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601379871;
        bh=FlYoqh3QgiA9Th7P5ByZ6Kvb/cvpXawfxNJ5tZR/lOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ynxmQ4D+nZgzCLX3XmotpUaNXUGHBrcvHYaaHWI9SQ0zovc9qnxt3aZAUoqysLL74
         w2Qr377X2Lp3hT+GVJRfSwRN5KRGkusaempbTMCQsaGorcIGLxSnnpbknaoA93fs8E
         FnDSdrEAr6ZjnUwBoo1c4eJ6KwdA/nS8uD3shooY=
Date:   Tue, 29 Sep 2020 13:44:28 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>, qais.yousef@arm.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200929114428.GA56480@lothringen>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
 <878scz89tl.fsf@nanos.tec.linutronix.de>
 <20200925004207.GE19346@lenoir>
 <CAKc596Km6kjQcp2MJmH9BZLY_7i7yFmHDmRnaJGsm4WzUNjwaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKc596Km6kjQcp2MJmH9BZLY_7i7yFmHDmRnaJGsm4WzUNjwaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:51:48PM +0800, jun qian wrote:
> Frederic Weisbecker <frederic@kernel.org> 于2020年9月25日周五 上午8:42写道：
> >
> > On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
> > > Subject: softirq; Prevent starvation of higher softirq vectors
> > [...]
> > > +     /*
> > > +      * Word swap pending to move the not yet handled bits of the previous
> > > +      * run first and then clear the duplicates in the newly raised ones.
> > > +      */
> > > +     swahw32s(&cur_pending);
> > > +     pending = cur_pending & ~(cur_pending << SIRQ_PREV_SHIFT);
> > > +
> > >       for_each_set_bit(vec_nr, &pending, NR_SOFTIRQS) {
> > >               int prev_count;
> > >
> > > +             vec_nr &= SIRQ_VECTOR_MASK;
> >
> > Shouldn't NR_SOFTIRQS above protect from that?
> >
> > >               __clear_bit(vec_nr, &pending);
> > >               kstat_incr_softirqs_this_cpu(vec_nr);
> > >
> > [...]
> > > +     } else {
> > > +             /*
> > > +              * Retain the unprocessed bits and swap @cur_pending back
> > > +              * into normal ordering
> > > +              */
> > > +             cur_pending = (u32)pending;
> > > +             swahw32s(&cur_pending);
> > > +             /*
> > > +              * If the previous bits are done move the low word of
> > > +              * @pending into the high word so it's processed first.
> > > +              */
> > > +             if (!(cur_pending & SIRQ_PREV_MASK))
> > > +                     cur_pending <<= SIRQ_PREV_SHIFT;
> >
> > If the previous bits are done and there is no timeout, should
> > we consider to restart a loop?
> >
> > A common case would be to enter do_softirq() with RCU_SOFTIRQ set
> > in the SIRQ_PREV_MASK and NET_RX_SOFTIRQ set in the normal mask.
> >
> > You would always end up processing the RCU_SOFTIRQ here and trigger
> > ksoftirqd for the NET_RX_SOFTIRQ.
> 
> yes, I found that this problem also exists in our project. The RCU
> softirq may cost
> 9ms,

Ouch!

> that will delay the net_rx/tx softirq to process, Peter's branch
> maybe can slove
> the problem
> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git core/softirq

It's probably also the right time for me to resume on this patchset:

https://lwn.net/Articles/779564/

In the long term this will allow us to have per vector threads that can be
individually triggered upon high loads, and even soft interruptible by
other vectors from irq_exit(). Also if several vectors are on high loads
at the same time, this leaves the balance decisions to the scheduler instead
of all these workarounds we scratch our heads on for several years now.

Besides, I'm convinced that splitting the softirqs is something we want in
the long run anyway.
