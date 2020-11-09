Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD92AB213
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgKIIAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:00:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382BCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8iIxkXsVEnjLH8O2KdGmlm53H1XHzS5qNj1ajXdOjn8=; b=uPB7eLsaOLUGjt9UXc19l1g81H
        JHWiVXpADjnoScmevSF8HKxlHYIX8uZAIJV65LuZgaZEk/4uLpTzyNbheGqFPndhRuyRUnSfcUu40
        jef4gRWjpHUPk3Q9VrI+dbesISQObOuy/KbyI7n4miZRrkQ1leB6AxwF0vWUssCE3ghwKsgmvMt0I
        sWwCaPtuasFgaZrILGe5l2S+1xeJoviYQmmi+QOtY1XSEd82t2w5ujlg9kt/357xdb7ZcgIv2yvdD
        sc7uQYIB20gR3qv/TUB7ogpd5LdF857TbMR3D1wEPkQeoVLrDwGchqa9Bffcxt+Upok2oDdrUslpN
        KssAn3rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc26U-0003iM-Ds; Mon, 09 Nov 2020 08:00:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BF213006E0;
        Mon,  9 Nov 2020 09:00:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 209E42C356C8E; Mon,  9 Nov 2020 09:00:38 +0100 (CET)
Date:   Mon, 9 Nov 2020 09:00:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <20201109080038.GY2594@hirez.programming.kicks-ass.net>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87v9efp7cs.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 01:54:59PM +1100, NeilBrown wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4418f5cb8324..728870965df1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1784,7 +1784,12 @@ static inline int test_tsk_need_resched(struct tas=
k_struct *tsk)
>  #ifndef CONFIG_PREEMPTION
>  extern int _cond_resched(void);
>  #else
> -static inline int _cond_resched(void) { return 0; }
> +static inline int _cond_resched(void)
> +{
> +	if (current->flags & PF_WQ_WORKER)
> +		workqueue_cond_resched();
> +	return 0;
> +}
>  #endif
> =20
>  #define cond_resched() ({			\

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..5b2e38567a0c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5620,6 +5620,8 @@ SYSCALL_DEFINE0(sched_yield)
>  #ifndef CONFIG_PREEMPTION
>  int __sched _cond_resched(void)
>  {
> +	if (current->flags & PF_WQ_WORKER)
> +		workqueue_cond_resched();
>  	if (should_resched(0)) {
>  		preempt_schedule_common();
>  		return 1;


Much hate for this.. :/ cond_resched() should be a NOP on !PREEMPT and
you wreck that. Also, you call into that workqueue_cond_resched()
unconditionally, even when it wouldn't have rescheduled, which seems
very wrong too.

On top of all that, you're adding an extra load to the funcion :/

At some poine Paul tried to frob cond_resched() for RCU and ran into all
sorts of performance issues, I'm thinking this will too.


Going by your justification for all this:

> I think that once a worker calls cond_resched(), it should be treated as
> though it was run from a WQ_CPU_INTENSIVE queue, because only cpu-intensi=
ve
> tasks need to call cond_resched().  This would allow other workers to be
> scheduled.

I'm thinking the real problem is that you're abusing workqueues. Just
don't stuff so much work into it that this becomes a problem. Or rather,
if you do, don't lie to it about it.
