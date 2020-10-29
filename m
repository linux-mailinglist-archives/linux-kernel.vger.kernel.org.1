Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E088329F0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJ2QEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ2QEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:04:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED9F52075E;
        Thu, 29 Oct 2020 16:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603987489;
        bh=Dc4WpDoHFlb2Xx04MjvhCqXYIYmM+TFLsOHCC0y4DLI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rTgG/kdaDag1WCvymvCOomZ1djX1RPHCnsL2e7CB9UlcCepTwf29BWvoFqGd5Bi8b
         K8PzXlJKr60bZzPPmuXOwM5/OAsxE0p/IdhMNfTNQSiomKxrS9khUnNqRg2Y2dXk99
         KObwyiA50gmSgvDVEckMFUozgLZ2ISvWpD5yBwyc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8583D3522778; Thu, 29 Oct 2020 09:04:48 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:04:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        hch@lst.de, axboe@kernel.dk, chris@chris-wilson.co.uk,
        davem@davemloft.net, kuba@kernel.org, fweisbec@gmail.com,
        oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH v3 6/6] rcu/tree: Use irq_work_queue_remote()
Message-ID: <20201029160448.GL3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028110707.971887448@infradead.org>
 <20201028111221.584884062@infradead.org>
 <20201028145428.GE2628@hirez.programming.kicks-ass.net>
 <20201028200243.GJ2651@hirez.programming.kicks-ass.net>
 <20201028201554.GE3249@paulmck-ThinkPad-P72>
 <20201029091053.GG2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029091053.GG2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:10:53AM +0100, Peter Zijlstra wrote:
> On Wed, Oct 28, 2020 at 01:15:54PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 28, 2020 at 09:02:43PM +0100, Peter Zijlstra wrote:
> 
> > > Subject: rcu/tree: Use irq_work_queue_remote()
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Wed Oct 28 11:53:40 CET 2020
> > > 
> > > All sites that consume rcu_iw_gp_seq seem to have rcu_node lock held,
> > > so setting it probably should too. Also the effect of self-IPI here
> > > would be setting rcu_iw_gp_seq to the value we just set it to
> > > (pointless) and clearing rcu_iw_pending, which we just set, so don't
> > > set it.
> > > 
> > > Passes TREE01.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/rcu/tree.c |   10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1308,14 +1308,16 @@ static int rcu_implicit_dynticks_qs(stru
> > >  			resched_cpu(rdp->cpu);
> > >  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> > >  		}
> > > -#ifdef CONFIG_IRQ_WORK
> > > +		raw_spin_lock_rcu_node(rnp);
> > 
> > The caller of rcu_implicit_dynticks_qs() already holds this lock.
> > Please see the force_qs_rnp() function and its second call site,
> > to which rcu_implicit_dynticks_qs() is passed as an argument.
> > 
> > But other than that, this does look plausible.  And getting rid of
> > that #ifdef is worth something.  ;-)
> 
> Dang, clearly TREE01 didn't actually hit any of this code :/ Is there
> another test I should be running?

TREE01 is fine, but you have to tell rcutorture to actually generate an
RCU CPU stall warning.  Like this for a 25-second stall with interrupts
disabled:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "10*TREE04" --bootargs "rcutorture.stall_cpu=25 rcutorture.stall_cpu_irqsoff=1" --trust-make

And like this to stall with interrupts enabled:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs "10*TREE04" --bootargs "rcutorture.stall_cpu=25" --trust-make

I use TREE04 instead of TREE01 because I have recently seen the pattern
you are looking for in a similar configuration.  But any of the TREE
scenarios should work.

And you need a bit of luck.  The CPU that rcutorture forces to stall
needs to be blocking the current grace period at the beginning of that
stall, or, alternatively, another grace period needs to start while
the CPU is stalled.  But the first command (with stall_cpu_irqsoff=1)
will sometimes get you something like this:

rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu:     3-...0: (1 GPs behind) idle=156/1/0x4000000000000000 softirq=493/494 fqs=4570 last_accelerate: 0000/eaad dyntick_enabled: 0
 (detected by 7, t=21003 jiffies, g=693, q=35687)

The zero in "...0" on the second line indicates that the RCU CPU stall
warning found that the stalled CPU had its interrupts disabled for the
last portion of that stall.

This is probabilistic.  Much depends on the state of both RCU and
rcutorture at the time that the stall starts.  I got the above results
once in 20 attempts, with other attempts having variously prevented
RCU's grace-period kthread from running, gotten the irq-work executed
just before the stall was reported, and so on.

Of course, to test your change, you also need the grace-period kthread to
migrate to the stalled CPU just after interrupts are enabled.  For this,
you need something like an 11-second stall plus something to move the
grace-period kthread at the right (wrong?) time.  Or just run the above
commands in a loop on a system with ample storage over night or some such.
I see about 70MB of storage per run, so disk size shouldn't be too much
of a problem.

If you do wish to muck with RCU and rcutorture to migrate
RCU's grace-period kthread, look for uses of stall_cpu_irqsoff in
kernel/rcu/rcutorture.c on the one hand and rcu_gp_kthread() along with
the functions that it calls in kernel/rcu/tree.c on the other.
For the latter, maybe force_qs_rnp() would be a good choice.

						Thanx, Paul
