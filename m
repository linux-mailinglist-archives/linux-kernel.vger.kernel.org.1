Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9812A6667
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgKDObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKDObj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:31:39 -0500
Received: from localhost (bag30-h01-176-173-247-136.dsl.sta.abo.bbox.fr [176.173.247.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C116720709;
        Wed,  4 Nov 2020 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604500298;
        bh=5Y5EUvdN2VpE7CNTOydj35CJiL0x0Q0aUsLXovkGDyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXkKphzUP8poLtJBhGP9+kOLtJsuD2nRNN365pAxfGscdf298KS5JfKyj7HlsdY3O
         qEXZzSUTnQRpNfx6UADjoEv561tNiSD4SymVtQmB7ekxZExvlBmZucPfJ4EKAznZH0
         4/7vcDnD+paHnMX0GldL9bepVs00B3eHtfYZ1TiE=
Date:   Wed, 4 Nov 2020 15:31:35 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 05/16] rcu: De-offloading CB kthread
Message-ID: <20201104143135.GB467220@lothringen>
References: <20201023144649.53046-1-frederic@kernel.org>
 <20201023144649.53046-6-frederic@kernel.org>
 <20201102133824.GA2661878@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102133824.GA2661878@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:38:24PM +0800, Boqun Feng wrote:
> Hi Frederic,
> 
> Could you copy the rcu@vger.kernel.org if you have another version, it
> will help RCU hobbyists like me to catch up news in RCU, thanks! ;-)

Sure! Will do!

> > +static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> > +{
> > +	struct rcu_segcblist *cblist = &rdp->cblist;
> > +	struct rcu_node *rnp = rdp->mynode;
> > +	bool wake_cb = false;
> > +	unsigned long flags;
> > +
> > +	printk("De-offloading %d\n", rdp->cpu);
> > +
> > +	rcu_nocb_lock_irqsave(rdp, flags);
> > +	raw_spin_lock_rcu_node(rnp);
> 
> Could you explain why both nocb_lock and node lock are needed here?

So here is the common scheme with rcu nocb locking:

rcu_nocb_lock(rdp) {
   if (rcu_segcblist_is_offloaded(rdp->cblist))
       raw_spin_lock(rdp->nocb_lock)
}
....

rcu_nocb_unlock(rdp) {
   if (rcu_segcblist_is_offloaded(rdp->cblist))
       raw_spin_unlock(rdp->nocb_lock)
}

Here we first need to check rdp->cblist offloaded state locklessly.
This is dangerous because we now can switch that offloaded state remotely.
So we may run some code under rcu_nocb_lock() without actually locking while at
the same time we switch to offloaded mode and we must run things under the
lock.

Fortunately, rcu_nocb_lock(), and rcu_segcblist_is_offloaded() in general,
is only called under either of the following situations (for which I need to
add debug assertions, but that will be in a subsequent patchset):

   1) hotplug write lock held
   2) rcu_barrier mutex held
   3) nocb lock held
   4) rnp lock held
   5) rdp is local
   6) we run the nocb timer

1) and 2) are covered because we hold them while calling work_on_cpu().
3) and 4) are held when we change the flags of the rdp->cblist.
5) is covered by the fact we are modifying the rdp->cblist state only
   locally (using work_on_cpu()) with irqs disabled.
6) we cancel/rearm the timer before it can see half states.

But you make me realize one thing: we must protect against these situations
especially when we switch the flags:

   a) From SEGCBLIST_SOFTIRQ_ONLY to SEGCBLIST_OFFLOADED (switch from no locking to locking)
   b) From 0 to SEGCBLIST_SOFTIRQ_ONLY (switch from locking to no locking)

Those are the critical state changes that modify the locking behaviour
and we have to hold both rdp->nocb_lock and the rnp lock on these state changes.

Unfortunately in the case b) I omitted the rnp lock. So I need to fix that.

> Besides rcu_nocb_{un}lock_* can skip the lock part based on the offload
> state, which gets modified right here (in a rcu_nocb_{un}lock_* critical
> secion), and I think this is error-prone, because you may get a unpaired
> lock-unlock (not in this patch though). Maybe just use node lock?

So that's why case 1 to 6 must be covered.

> 
> > +	rcu_segcblist_offload(cblist, false);
> > +	raw_spin_unlock_rcu_node(rnp);
> > +
> > +	if (rdp->nocb_cb_sleep) {
> > +		rdp->nocb_cb_sleep = false;
> > +		wake_cb = true;
> > +	}
> > +	rcu_nocb_unlock_irqrestore(rdp, flags);
> > +
> > +	if (wake_cb)
> > +		swake_up_one(&rdp->nocb_cb_wq);
> > +
> > +	swait_event_exclusive(rdp->nocb_state_wq,
> > +			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> > +
> > +	return 0;
> > +}
> > +
> > +static long rcu_nocb_rdp_deoffload(void *arg)
> > +{
> > +	struct rcu_data *rdp = arg;
> > +
> > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> 
> I think this warning can actually happen, if I understand how workqueue
> works correctly. Consider that the corresponding cpu gets offlined right
> after the rcu_nocb_cpu_deoffloaed(), and the workqueue of that cpu
> becomes unbound, and IIUC, workqueues don't do migration during
> cpu-offlining, which means the worker can be scheduled to other CPUs,
> and the work gets executed on another cpu. Am I missing something here?.

We are holding cpus_read_lock() in rcu_nocb_cpu_offload(), this should
prevent from that.

Thanks!
