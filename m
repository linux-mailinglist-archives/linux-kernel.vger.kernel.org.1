Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF5223BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGQMvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 08:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgGQMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:51:45 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416562070A;
        Fri, 17 Jul 2020 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594990304;
        bh=U9B3Aohw78O/eD7BbCEY0csjKD1Rg0sjK5ciTtxBuV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPs9F2X0GwNG2NNwcEhdLaAXdIxdu57hofwauDJc5y1FFs8jqNTb+pZDXmp6qFecC
         tx7EFGgGmtIlZXctAO0Rn0GupZwt1eTSo5TrCybyZYGk08rBX5+GYtfNb3VFqK6Bqq
         89Fh9ooK7s8PoijqiyiwzKHsMTyb3auKLMon+qUo=
Date:   Fri, 17 Jul 2020 14:51:42 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 4/9] timers: Always keep track of next expiry
Message-ID: <20200717125141.GA25465@lenoir>
References: <20200707013253.26770-1-frederic@kernel.org>
 <20200707013253.26770-5-frederic@kernel.org>
 <alpine.DEB.2.21.2007141037490.1386@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007141037490.1386@somnus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:49:28AM +0200, Anna-Maria Behnsen wrote:
> Hi Frederic,
> 
> On Tue, 7 Jul 2020, Frederic Weisbecker wrote:
> 
> > So far next expiry was only tracked while the CPU was in nohz_idle mode
> > in order to cope with missing ticks that can't increment the base->clk
> > periodically anymore.
> > 
> > We are going to expand that logic beyond nohz in order to spare timers
> > softirqs so do it unconditionally.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >  kernel/time/timer.c | 36 +++++++++++++++++++-----------------
> >  1 file changed, 19 insertions(+), 17 deletions(-)
> > 
> > diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> > index acf7cb8c09f8..8a4138e47aa4 100644
> > --- a/kernel/time/timer.c
> > +++ b/kernel/time/timer.c
> > @@ -558,8 +558,22 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> >  	 * timer is not deferrable. If the other CPU is on the way to idle
> >  	 * then it can't set base->is_idle as we hold the base lock:
> >  	 */
> > -	if (!base->is_idle)
> > -		return;
> > +	if (base->is_idle)
> > +		wake_up_nohz_cpu(base->cpu);
> > +}
> > +
> > +/*
> > + * Enqueue the timer into the hash bucket, mark it pending in
> > + * the bitmap and store the index in the timer flags.
> > + */
> > +static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
> > +			  unsigned int idx)
> > +{
> > +	hlist_add_head(&timer->entry, base->vectors + idx);
> > +	__set_bit(idx, base->pending_map);
> > +	timer_set_idx(timer, idx);
> > +
> > +	trace_timer_start(timer, timer->expires, timer->flags);
> >  
> >  	/* Check whether this is the new first expiring timer: */
> >  	if (time_after_eq(timer->expires, base->next_expiry))
> > @@ -578,21 +592,7 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
> >  	} else {
> >  		base->next_expiry = timer->expires;
> >  	}
> > -	wake_up_nohz_cpu(base->cpu);
> > -}
> >  
> > -/*
> > - * Enqueue the timer into the hash bucket, mark it pending in
> > - * the bitmap and store the index in the timer flags.
> > - */
> > -static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
> > -			  unsigned int idx)
> > -{
> > -	hlist_add_head(&timer->entry, base->vectors + idx);
> > -	__set_bit(idx, base->pending_map);
> > -	timer_set_idx(timer, idx);
> > -
> > -	trace_timer_start(timer, timer->expires, timer->flags);
> >  	trigger_dyntick_cpu(base, timer);
> >  }
> >  
> 
> Could you please split those two hunks which do only a restructuring into a
> separate patch?

The problem is that those hunks are not only a restructuring but they also
change the way we update next_expiry, since we do it outside idle context.
And that update won't make sense without the proper initialization of next_expiry
that comes later in the patch.

Thanks.
