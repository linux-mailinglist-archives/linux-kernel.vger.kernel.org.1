Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89E729F381
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgJ2Rnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgJ2RnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:43:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJcCXXH6uTkPu39GG3ZWtoFwOzJiDkN83u9UnA4WVP8=; b=2+MdtFb9Wb8uHJzjSnoFSeYIZI
        QG4g5h7XCOjQmwRyF7IUFg5rg9cXAwa+qRpEI2sSijeiARTYSs0lOGqhaAWEzFm/vIiA3gMt4rVJu
        7fDogNyraeeKccmWlTbdDAAQMA8Gv4SjPbnEkNcSyPVQOtR7mYW2/nG7MIDQnQxjPjPj/tej4A2u6
        Ta9vnbTMdnEfTOuZFBNCX2oBIVkzEPwQ2R2qmGU746xezrvXOZXLragCsLBOaAEdli+pAuS8wnshD
        4XP/UredyZVoOYNg4eW2CUwtBAGyDF7ihIWTDZb8axHLxFYv0P2c3dFZkTHwnnHVAPapvOeVjMtTF
        o/UvqwmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYBx2-00029Z-FN; Thu, 29 Oct 2020 17:43:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C665F3006D0;
        Thu, 29 Oct 2020 18:43:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADF7D20315047; Thu, 29 Oct 2020 18:43:02 +0100 (CET)
Date:   Thu, 29 Oct 2020 18:43:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 17/19] sched: Add migrate_disable() tracepoints
Message-ID: <20201029174302.GV2628@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.697960969@infradead.org>
 <jhja6w5ov4h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhja6w5ov4h.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 04:27:26PM +0000, Valentin Schneider wrote:
> 
> On 23/10/20 11:12, Peter Zijlstra wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1732,6 +1732,8 @@ void migrate_disable(void)
> >               return;
> >       }
> >
> > +	trace_sched_migrate_disable_tp(p);
> > +
> >       preempt_disable();
> >       this_rq()->nr_pinned++;
> >       p->migration_disabled = 1;
> > @@ -1764,6 +1766,8 @@ void migrate_enable(void)
> >       p->migration_disabled = 0;
> >       this_rq()->nr_pinned--;
> >       preempt_enable();
> > +
> > +	trace_sched_migrate_enable_tp(p);
> 
> Don't you want those directly after the ->migration_disabled write?
> esp. for migrate_enable(), if that preempt_enable() leads to a context
> switch then the disable->enable deltas won't reflect the kernel view.
> 
> That delta may indeed include the time it took to run the stopper and
> fix the task's affinity on migrate_enable(), but it could include all
> sorts of other higher-priority tasks.

I can put them in the preempt_disable() section I suppose, but these
tracers should be looking at task_sched_runtime(), not walltime, and
then the preemption doesn't matter.

Also, a distinct lack of actual users atm.. :/
