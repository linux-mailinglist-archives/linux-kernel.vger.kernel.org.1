Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B72FD3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbhATPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:19:34 -0500
Received: from foss.arm.com ([217.140.110.172]:39586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390940AbhATPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:18:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5D431B;
        Wed, 20 Jan 2021 07:17:30 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D330C3F68F;
        Wed, 20 Jan 2021 07:17:29 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:17:24 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/4] cpu/hotplug: CPUHP_BRINGUP_CPU exception in fail
 injection
Message-ID: <20210120151723.GA284273@e120877-lin.cambridge.arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-3-git-send-email-vincent.donnefort@arm.com>
 <YAgo+zMrbFjJ/meF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAgo+zMrbFjJ/meF@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:58:35PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 05:10:45PM +0000, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
> > triggered by the CPUHP_BRINGUP_CPU step. If the latter doesn't run, none
> > of the atomic can. Hence, rollback is not possible after a hotunplug
> > CPUHP_BRINGUP_CPU step failure and the "fail" interface shouldn't allow
> > it. Moreover, the current CPUHP_BRINGUP_CPU teardown callback
> > (finish_cpu()) cannot fail anyway.
> > 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > ---
> >  kernel/cpu.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 9121edf..bcd7b2a 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2216,9 +2216,14 @@ static ssize_t write_cpuhp_fail(struct device *dev,
> >  		return -EINVAL;
> >  
> >  	/*
> > -	 * Cannot fail STARTING/DYING callbacks.
> > +	 * Cannot fail STARTING/DYING callbacks. Also, those callbacks are
> > +	 * triggered by BRINGUP_CPU bringup callback. Therefore, the latter
> > +	 * can't fail during hotunplug, as it would mean we have no way of
> > +	 * rolling back the atomic states that have been previously teared
> > +	 * down.
> >  	 */
> > -	if (cpuhp_is_atomic_state(fail))
> > +	if (cpuhp_is_atomic_state(fail) ||
> > +	    (fail == CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU))
> >  		return -EINVAL;
> 
> Should we instead disallow failing any state that has .cant_stop ?

We would reduce the scope of what can be tested: bringup_cpu() and
takedown_cpu() are both marked as "cant_stop". Still, those callbacks are
allowed to fail.

Checking for cant_stop, made me also see that write_cpuhp_target() is probably
missing a check for cpuhp_is_atomic_state(). For the same reason as this patch,
when doing cpu_down(), we can't stop in one of these states.

-- 
Vincent
