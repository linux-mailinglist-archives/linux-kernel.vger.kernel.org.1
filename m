Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF02D6DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbgLKBli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390557AbgLKBlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:41:15 -0500
Date:   Fri, 11 Dec 2020 02:40:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607650834;
        bh=Pi8JYKpDMe2dYTrk3VK79ij+Nm186HVdVz+CuU1p+y8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBCRt8YSazpURt+11Y8ThFZ4URuDBGT/OphWGDuqDfQwJGVhZUiGND+Jn74OE9iP5
         JT1Utxhxe2rVmdlot1phYslWSXGqe9xe8LuFlYIqsdDTB8bOgdXpaUN2IF8S+6i99A
         v+7sJ97KIdB8Hi9MeUZzvZHOF2vP3ZCnAfUExR1lvXp955PWunZ+GppoS1C0VY/2Ab
         jfRNi36y34duLY1JXcS8U6O7LVrFeIaTs2mIXPoT1PN5PG2pRNaP75x5Lx3pgpZLlE
         MY9j2xNkO5X8yxHNZKMoNIFX0gtLRgcIaLCPgogIZ8QyqjOKADMICTndMxLPcknTza
         zldBqZOFy2HhA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201211014031.GB580714@lothringen>
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
 <20201210145637.GA164661@lothringen>
 <20201210211756.GZ2657@paulmck-ThinkPad-P72>
 <20201211001515.GA580714@lothringen>
 <20201211004638.GB2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211004638.GB2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 04:46:38PM -0800, Paul E. McKenney wrote:
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 09229ad82209..7d558cb7a037 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -650,7 +650,9 @@ static void run_ksoftirqd(unsigned int cpu)
> >  		 * We can safely run softirq on inline stack, as we are not deep
> >  		 * in the task stack here.
> >  		 */
> > -		__do_softirq();
> > +		do {
> > +			__do_softirq();
> > +		} while (kthread_should_park() && local_softirq_pending());
> >  		local_irq_enable();
> >  		cond_resched();
> >  		return;
> 
> Huh.  I guess that self-propagating timers, RCU callbacks, and the
> like are non-problems because they cannot retrigger while interrupts
> are disabled?  But can these things reappear just after the
> local_irq_enable()?

Exactly, unless those things have been disabled in CPU hotplug callbacks
before smpboot_park_threads() (and we are not too deep in CPU hotplug at that
stage, cpu_online() is still true), they should be able to raise again
the softirqs. Yeah I'm pretty sure the above won't be enough.

> In the case of RCU, softirq would need to run on this CPU, which it won't,
> so we are good in that case.  (Any stranded callbacks will be requeued
> onto some other CPU later in the CPU-hotplug offline processing.)

Ah that's good, so at least we shouldn't worry about pending RCU softirqs
after ksoftirqd has parked. But I also see at least SCHED_SOFTIRQ and
TIMER_SOFTIRQ in your list.

Perhaps we should have some flush_softirq() somewhere late in cpu hotplug,
assuming this is actually necessary and none of these will requeue themselves...

Thanks.

> 
> 							Thanx, Paul
> 
> > Thanks!
