Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66E828EFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgJOKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389117AbgJOKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:12:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J3ji+5AsJZECRfTC9svVX7xsQS+BptdVBIVyCA9ozO4=; b=bwcgStL5W3gVnKRTdg9E+rmYC/
        3Gfn9otkknopnvUXFfNvN4TT595eXvPU1rdtZ6+XuMVovI7tBV1zxJMF7D4bPY2HPQJmvoXmrsp/+
        c2Xvon+ug31BN8tBRMJJZ9YXpOEmiBmHtaVv9MS/zLwFRDOCdy8ULqx6tVHpq2WbnQf+joDUPt9Iz
        LApeiRW76GNnKV3SGlRdN2n5QpddOaGJ8qNu4CqDMpkbnj9UOVSOx7bze6omUrQXKrodTQuov7gu1
        kTvKj9eVIdiNp2mZKDA+xnSdlFEYyRTFlNrw07IeNe4rap3Gs/aeWznqvSnRmSGlL0NXrWvphEPku
        vHOc9R1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT0FS-0005bz-5U; Thu, 15 Oct 2020 10:12:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08543300DB4;
        Thu, 15 Oct 2020 12:12:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7C1120325ECE; Thu, 15 Oct 2020 12:12:35 +0200 (CEST)
Date:   Thu, 15 Oct 2020 12:12:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201015101235.GA2611@hirez.programming.kicks-ass.net>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
 <20201014083321.GA2628@hirez.programming.kicks-ass.net>
 <20201014234053.GA86158@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014234053.GA86158@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 01:40:53AM +0200, Frederic Weisbecker wrote:
> > re tick_nohz_task_switch() being placed wrong, it should probably be
> > placed before finish_lock_switch(). Something like so.
> > 
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index cf044580683c..5c92c959824f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4084,6 +4084,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  	vtime_task_switch(prev);
> >  	perf_event_task_sched_in(prev, current);
> >  	finish_task(prev);
> > +	tick_nohz_task_switch();
> >  	finish_lock_switch(rq);
> >  	finish_arch_post_lock_switch();
> >  	kcov_finish_switch(current);
> > @@ -4121,7 +4122,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> >  		put_task_struct_rcu_user(prev);
> >  	}
> >  
> > -	tick_nohz_task_switch();
> 
> IIRC, we wanted to keep it outside rq lock because it shouldn't it...

But now you've created a window with IRQs on and cause additional IRQ
state changes.

If you're really worried about rq->lock, I suppose we can do:

	rq_unlock(rq->lock);
	tick_nohz_task_switch();
	local_irq_enable();

(much like we do at the beginning of __schedule for RCU)
