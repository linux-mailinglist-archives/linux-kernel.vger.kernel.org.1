Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4065F2AFB55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgKKWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 17:22:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgKKWWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:22:42 -0500
Received: from localhost (unknown [176.177.123.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23E4208FE;
        Wed, 11 Nov 2020 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605133361;
        bh=ImNxlyAjJTegTBwA4FTvPm9Lo+Se6ym6Dyb0QhUgXiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPdglktB+ckt5B/6My4oBVWBFUs95i2UJiC8d9MpvtBtsuEFSEOG7OJG0O6Vah/Jo
         lFOVd6uua1kDHXgVpXqUiKm0J3t1nxMA2mZs4duhMz13seOszsM+V7POKEvYC5PV37
         LufyhrDnoT7bgL95k2WOsnIKdWJ3c0m+2sYUG7kM=
Date:   Wed, 11 Nov 2020 23:22:38 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 4/5] context_tracking: Only define schedule_user() on
 !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Message-ID: <20201111222238.GB73739@lothringen>
References: <20201027150827.148821-1-frederic@kernel.org>
 <20201027150827.148821-5-frederic@kernel.org>
 <20201111143458.GV2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111143458.GV2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 03:34:58PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 27, 2020 at 04:08:26PM +0100, Frederic Weisbecker wrote:
> > schedule_user() was traditionally used by the entry code's tail to
> > preempt userspace after the call to user_enter(). Indeed the call to
> > user_enter() used to be performed upon syscall exit slow path which was
> > right before the last opportunity to schedule() while resuming to
> > userspace. The context tracking state had to be saved on the task stack
> > and set back to CONTEXT_KERNEL temporarily in order to safely switch to
> > another task.
> > 
> > Only a few archs use it now and those implementing
> > HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.
> 
> powerpc64 and sparc64 only, right?

Exactly! I can precise that in the changelog.

Thanks.

> 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Phil Auld <pauld@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/sched/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index c23d7cb5aee3..44426e5acde2 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4631,7 +4631,7 @@ void __sched schedule_idle(void)
> >  	} while (need_resched());
> >  }
> >  
> > -#ifdef CONFIG_CONTEXT_TRACKING
> > +#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
> >  asmlinkage __visible void __sched schedule_user(void)
> >  {
> >  	/*
> > -- 
> > 2.25.1
> > 
