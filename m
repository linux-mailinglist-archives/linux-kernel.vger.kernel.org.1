Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93892B923F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgKSMM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKSMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:12:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF04CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l3xEnAx4q8O0EP6AAD5sJP833p89scGo7JAtlQmqAnM=; b=sWVv8WMZgyy6TyKuaeo5wkfASG
        Q25ZE2SOW/e9952expcHVgWvFp0TgKBiz3YJIwgmsW1vdtynDYk0HY2FaMlN1X0k+a4NttdR+SVrk
        X53X+Iw+NF0AcWtvAUH492STL35zM4HXfHg2PJ++A+yXmLTUGWRGoT5tlVbT+JXHAWieIUSenrL72
        mP839E/mJJ/b/KHeeAcqzjG1m//HTx54i9l/QwUSS0ldDexD3kdcYPECxpkJage+sWSWhowFa8TTE
        1f8teRtm4q47way9aJ1g+eOqBnG7szbh3Ti5OR/lGa+m6L1ZJL3TlYxf1q+bBqvRdCOgGZf50nNP1
        5mRXf/AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfinC-0003Ro-Mz; Thu, 19 Nov 2020 12:12:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32AEA306BCA;
        Thu, 19 Nov 2020 13:12:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3BB120126362; Thu, 19 Nov 2020 13:12:00 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:12:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 5/8] sched: highmem: Store local kmaps in task struct
Message-ID: <20201119121200.GG3121429@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.372935758@linutronix.de>
 <20201119115132.GN3121378@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119115132.GN3121378@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:51:32PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 18, 2020 at 08:48:43PM +0100, Thomas Gleixner wrote:
> 
> > @@ -4073,6 +4089,7 @@ prepare_task_switch(struct rq *rq, struc
> >  	perf_event_task_sched_out(prev, next);
> >  	rseq_preempt(prev);
> >  	fire_sched_out_preempt_notifiers(prev, next);
> > +	kmap_local_sched_out();
> >  	prepare_task(next);
> >  	prepare_arch_switch(next);
> >  }
> > @@ -4139,6 +4156,7 @@ static struct rq *finish_task_switch(str
> >  	finish_lock_switch(rq);
> >  	finish_arch_post_lock_switch();
> >  	kcov_finish_switch(current);
> > +	kmap_local_sched_in();
> >  
> >  	fire_sched_in_preempt_notifiers(current);
> >  	/*
> 
> > +void __kmap_local_sched_out(void)
> > +{
> > +	struct task_struct *tsk = current;
> > +	pte_t *kmap_pte = kmap_get_pte();
> > +	int i;
> > +
> > +	/* Clear kmaps */
> > +	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
> > +	}
> > +}
> > +
> > +void __kmap_local_sched_in(void)
> > +{
> > +	struct task_struct *tsk = current;
> > +	pte_t *kmap_pte = kmap_get_pte();
> > +	int i;
> > +
> > +	/* Restore kmaps */
> > +	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
> > +	}
> > +}
> 
> So even in the optimal case, this adds an unconditional load of
> tsk->kmap_ctrl.idx to schedule() (2 misses, one pre and one post).
> 
> Munging preempt-notifiers behind a static_branch, which in that same
> optimal case, avoided touching curr->preempt_notifier, resulted in a
> measurable performance improvement. See commit:
> 
>   1cde2930e154 ("sched/preempt: Add static_key() to preempt_notifiers")
> 
> Can we fudge some state in a cacheline we're already touching to avoid
> this?

The only state we seem to consistently look at after schedule() is
need_resched()'s TIF_NEED_RESCHED.

But adding a TIF_flag to all archs and setting/clearing it from
kmap_local might be a bit daft.. :/

