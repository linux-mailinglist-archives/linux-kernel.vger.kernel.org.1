Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3869D28151C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbgJBOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:30:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PjNw33aLdANmms3dj8/kpRTu9mB/VfG1NrhurP/wbG0=; b=aLjuB+7UL07DQFGyR6tABTlKR9
        gkG1mHS525OLM8HdEGnk+h1sncSLVo8qTYtyqathRB191a8IRaf0GQTJf0c5hD7gFgfpFZf5ksRRQ
        dkfdY8xVagZybz9Zy506zd+Vx66Ah+oszXa5bA5Rtvh1nBkLIs33AKoSPiQM3MGJvyTuKvlVYxvtd
        OHYQgxU06OkWaMZ8KFDGABb6QDUrnFmef/a9sKe9k+USNsRJephcvzko5muY8xIBwXSAvHiO8TPe1
        eo/mZAbWFRPt9ztCepfa4C8z3zu2CQVYzu7/YSJ5WQdn1e1xncRFBBo9xGzjsAkjWG64AMf56Bv1Z
        BVLek3SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOM4k-0003H8-70; Fri, 02 Oct 2020 14:30:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E19B3006D0;
        Fri,  2 Oct 2020 16:30:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8302203A8F66; Fri,  2 Oct 2020 16:30:20 +0200 (CEST)
Date:   Fri, 2 Oct 2020 16:30:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 0/9] sched: Migrate disable support
Message-ID: <20201002143020.GA2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200925181727.ryuacrsipyaz65z7@linutronix.de>
 <jhjzh5dmz3r.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjzh5dmz3r.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 08:32:24PM +0100, Valentin Schneider wrote:

> The IRC handout so far is:

I meant to go post a new version today; but of course cleanup took
longer than expected.

In any case, there's a slightly updated version here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip2

it has push/pull balancer changes that sorta work. There's still
something funny with the NO_RT_PUSH_IPI case (and concequently also the
deadline code, which is an exact mirror of that code).

(it looks like it ends up migrating things in circles due to the for
loop in pull_rt_task)

> As for your splat, I think this is what I was worrying about wrt
> suppressing callbacks in the switch but not preventing them from being
> queued. Perhaps the below is "better" than what I previously sent.
> 
> Technically should be doable with a cpu_active() check instead given this
> all gets flipped in sched_cpu_deactivate(), but at least this makes it
> obvious that PUSH suppresses any other callback.
> 
> ---
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 50aac5b6db26..40d78a20fbcb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1403,7 +1403,7 @@ queue_balance_callback(struct rq *rq,
>  {
>         lockdep_assert_held(&rq->lock);
> 
> -	if (unlikely(head->next))
> +	if (unlikely(head->next) || (rq->balance_flags & BALANCE_PUSH))
>                 return;

Yeah, I like that. Let me go add it.
