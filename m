Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3428D01A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgJMOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgJMOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:21:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3CC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5X9x6sA1HPZKGi4HmuNe3XasDgdbZwe5ZtBJ6ONT/aY=; b=dXm97LGy0aiO1z3LlggPQV3BNo
        oesBHINUG7IKZoM5+rLhr9BwyI5vaNgdxmT8cuy87cBX+MGAc8/epryk0xFZc2rPKrxOC+WPSDfZU
        gyN0mFB97gzcQAnI5de907+pwCb1UgaGMSbcgs+qhcxgK6YcAV6cwzz9LUJzycLr7OPNn2VJ/ydlI
        8+kc/8Gk3PIGWnChn1vIkXpHr1fvFYbNqM6jpj+PBovNcgeb/Z+n41MvAtTHBCB1LRoOOUybMo7ez
        w7pmWpqpHNdsAtacEobt09l5aptbEwY5d4CLWzMsCaZg3TdO6NLUUVYrvjKjWblQFucI601MjNL+o
        4iNhD/hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSLAr-0004fO-0Z; Tue, 13 Oct 2020 14:21:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CCDD301959;
        Tue, 13 Oct 2020 16:21:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DCAE2BFFEAE4; Tue, 13 Oct 2020 16:21:08 +0200 (CEST)
Date:   Tue, 13 Oct 2020 16:21:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH 1/2] sched: Deny self-issued __set_cpus_allowed_ptr()
 when migrate_disable()
Message-ID: <20201013142108.GD2594@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201013140116.26651-1-valentin.schneider@arm.com>
 <20201013141508.u7saiudjyuvihvcx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013141508.u7saiudjyuvihvcx@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:15:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-13 15:01:15 [+0100], Valentin Schneider wrote:
> >   migrate_disable();
> >   set_cpus_allowed_ptr(current, {something excluding task_cpu(current)});
> >   affine_move_task(); <-- never returns
> > 
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> > ---
> >  kernel/sched/core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4ccd1099adaa..7f4e38819de1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2189,6 +2189,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
> >  		goto out;
> >  
> > +	if (p == current &&
> > +	    is_migration_disabled(p) &&
> > +	    !cpumask_test_cpu(task_cpu(p), new_mask))
> > +		ret = -EBUSY;
> > +
> 
> This shouldn't happen, right? The function may sleep so it shouldn't be
> entered with disabled migration. A WARN_ON might spot the bad caller.

So yeah, I like detecting the case but agree with bigeasy that an
additional WARN would make sense, lemme go add that.
