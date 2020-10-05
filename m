Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21A22834D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJELYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJELYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:24:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9D7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=56mM22kzYtImOdjW/+Rpj2jvvHcFVcVx6JvTR748x/Q=; b=I07L5yCq6cc3H+yBEBdhUdXHbF
        wnx1Xg5OsuFLq/B1EYDEkcrzW3ciXhJRgdj07nkBVkJpCCpjM9NkONzL14xIEnCcbmPPrEk2Zhpcl
        uVUc6hnZ7j+Ix4+zAv5j7V7oeW1WQc9kmPJMTnSfo5mJVLCSh1PpsWC2QaN1feJ3gB9BFBXlUNU1d
        PqWNJcfAQN2MslmAYOzca5wSf79i72rmNsI+iqePrNbUli+XfvFnZJm1/vMPAaA69sVYMTOd6K6De
        EJbqxOvhQIhsicjM6sS2LKWuSeZqlEzKexT2/aFhl++ke6YYKvnFYNJFUXvKx8cvF045oncB/psVR
        RcrI2qPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPOax-0006yR-TD; Mon, 05 Oct 2020 11:23:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C67B3013E5;
        Mon,  5 Oct 2020 13:23:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17125286F7D81; Mon,  5 Oct 2020 13:23:53 +0200 (CEST)
Date:   Mon, 5 Oct 2020 13:23:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 3/5] sched: Detect call to schedule from critical entry
 code
Message-ID: <20201005112353.GI2628@hirez.programming.kicks-ass.net>
References: <20201005104919.5250-1-frederic@kernel.org>
 <20201005104919.5250-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005104919.5250-4-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:49:17PM +0200, Frederic Weisbecker wrote:
> Detect calls to schedule() between user_enter() and user_exit(). Those
> are symptoms of early entry code that either forgot to protect a call
> to schedule() inside exception_enter()/exception_exit() or, in the case
> of HAVE_CONTEXT_TRACKING_OFFSTACK, enabled interrupts or preemption in
> a wrong spot.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/sched/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..d31a79e073e3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4295,6 +4295,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  		preempt_count_set(PREEMPT_DISABLED);
>  	}
>  	rcu_sleep_check();
> +	WARN_ON_ONCE(ct_state() == CONTEXT_USER);

	SCHED_WARN_ON() ?

No point in unconditionally polluting that path. Although, per MeL, we
should probably invest in CONFIG_SCHED_DEBUG_I_MEANS_IT :/
