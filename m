Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A571B46BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDVN7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 09:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:59:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3091C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=011gFebrmxXRYEXt4RNpm5unCWoPnjApvPM7qbHME3g=; b=uNjs9/Qgo6yEl0AgQ/W+KtDZAg
        TYKY9IZkfFt1SBniPO0QmaK3+uzi6LEW3sOzC/1WfIu0J/a2VGRhuvO0YS+nA0riwcd4PJ1FzZ+PD
        myHh519LNmzrHULTi7CRZQX6LQzL9rQ8Si6r5XhoTQx25DYZyTP6AWCC6huGxktV1U2b86ZhgNCk0
        loC6eFMwFWBcs9bJN+PMcCui5VLd7kfBWjE12b9mYn5bHAZax9+xyVo0QrJUnza9Zeu2fd1wP12ul
        ySoZkzJ/WVP27x85El/mLucyYEXIa7pWWNUwZ/JiCGSaCVuG7ViHPr3xYKT7MU2FDqLYYD0Um0+0c
        XmoVo0aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRFuN-0005G5-FN; Wed, 22 Apr 2020 13:59:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32FEC304CFD;
        Wed, 22 Apr 2020 15:59:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16A69286A6E59; Wed, 22 Apr 2020 15:59:21 +0200 (CEST)
Date:   Wed, 22 Apr 2020 15:59:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
Message-ID: <20200422135921.GL20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net>
 <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:36:22PM +0200, Vincent Guittot wrote:
> On Wed, 22 Apr 2020 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Apr 22, 2020 at 03:21:45PM +0200, Vincent Guittot wrote:
> > > On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > In an attempt to take away sched_setscheduler() from modules, change
> > > > this into sched_set_normal(.nice = 19).
> > > >
> > > > Cc: john.stultz@linaro.org
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > > > ---
> > > >  drivers/staging/android/ion/ion_heap.c |    3 ---
> > > >  1 file changed, 3 deletions(-)
> > > >
> > > > --- a/drivers/staging/android/ion/ion_heap.c
> > > > +++ b/drivers/staging/android/ion/ion_heap.c
> > > > @@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
> > > >
> > > >  int ion_heap_init_deferred_free(struct ion_heap *heap)
> > > >  {
> > > > -       struct sched_param param = { .sched_priority = 0 };
> > > > -
> > > >         INIT_LIST_HEAD(&heap->free_list);
> > > >         init_waitqueue_head(&heap->waitqueue);
> > > >         heap->task = kthread_run(ion_heap_deferred_free, heap,
> > > > @@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
> > > >                        __func__);
> > > >                 return PTR_ERR_OR_ZERO(heap->task);
> > > >         }
> > > > -       sched_setscheduler(heap->task, SCHED_IDLE, &param);
> > > > +       sched_set_normal(heap->task, 19);
> > >
> > > Would it make sense to have a sched_set_idle(task) to enable kernel
> > > setting SCHED_IDLE task ?
> > >
> > > SCHED_NORMAL w/ nice 19 and SCHED_IDLE tasks are not treated in the
> > > same way when checking for preemption at  wakeup
> >
> > Yeah, but does it really matter? I did indeed consider it, but got
> > lazy. Is there a definite need for IDLE?
> 
> John is the best to answer this for this driver but SCHED_IDLE will
> let other tasks which might be involved in end user interaction like
> on Android to run first

So I don't much like SCHED_IDLE because it introduces some pretty
horrible tail latencies. Consider the IDLE task holding a lock, then the
lock waiter will have to wait until the task gets around to running.

It's not unbounded, like a true idle-time scheduler would be, but it can
still be pretty horrible. nice19 has some of that too of course, but
idle has it worse, esp. also because it begs others to preempt it.

I should get back to proxy execution I suppose...
