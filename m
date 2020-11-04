Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3395C2A66A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgKDOp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbgKDOpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:45:25 -0500
Received: from localhost (bag30-h01-176-173-247-136.dsl.sta.abo.bbox.fr [176.173.247.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36B22074B;
        Wed,  4 Nov 2020 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604501124;
        bh=8TcJJOeVYQ+GDNNIiJiZDhzBACLQibcif/NnVi8cl4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gJJf+WvE8SB/vXz47At22PG2b4xbNqLVhnoQwMt2kYiR40GPzh1WaqyYOejDJK1k
         axGC0A7pDhDZFUwv4eEzv7HXDKkjRiW1IjrT1gXlk+2Xp/9UwKspp4GB6vFt7FRwxH
         3WvtE3y5MmTES6CL3P7ao4LBPggo8M47wuTykF30=
Date:   Wed, 4 Nov 2020 15:45:21 +0100
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
Message-ID: <20201104144521.GD467220@lothringen>
References: <20201023144649.53046-1-frederic@kernel.org>
 <20201023144649.53046-6-frederic@kernel.org>
 <20201102133824.GA2661878@boqun-archlinux>
 <20201104143135.GB467220@lothringen>
 <20201104144209.GA2748545@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104144209.GA2748545@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:42:09PM +0800, Boqun Feng wrote:
> On Wed, Nov 04, 2020 at 03:31:35PM +0100, Frederic Weisbecker wrote:
> [...]
> > > 
> > > > +	rcu_segcblist_offload(cblist, false);
> > > > +	raw_spin_unlock_rcu_node(rnp);
> > > > +
> > > > +	if (rdp->nocb_cb_sleep) {
> > > > +		rdp->nocb_cb_sleep = false;
> > > > +		wake_cb = true;
> > > > +	}
> > > > +	rcu_nocb_unlock_irqrestore(rdp, flags);
> > > > +
> > > > +	if (wake_cb)
> > > > +		swake_up_one(&rdp->nocb_cb_wq);
> > > > +
> > > > +	swait_event_exclusive(rdp->nocb_state_wq,
> > > > +			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static long rcu_nocb_rdp_deoffload(void *arg)
> > > > +{
> > > > +	struct rcu_data *rdp = arg;
> > > > +
> > > > +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> > > 
> > > I think this warning can actually happen, if I understand how workqueue
> > > works correctly. Consider that the corresponding cpu gets offlined right
> > > after the rcu_nocb_cpu_deoffloaed(), and the workqueue of that cpu
> > > becomes unbound, and IIUC, workqueues don't do migration during
> > > cpu-offlining, which means the worker can be scheduled to other CPUs,
> > > and the work gets executed on another cpu. Am I missing something here?.
> > 
> > We are holding cpus_read_lock() in rcu_nocb_cpu_offload(), this should
> > prevent from that.
> > 
> 
> But what if the work doesn't get executed until we cpus_read_unlock()
> and someone offlines that CPU?

work_on_cpu() waits for completion before returning.

> Regards,
> Boqun
> 
> > Thanks!
