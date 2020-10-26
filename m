Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA329983E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgJZUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbgJZUxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:53:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C29E720829;
        Mon, 26 Oct 2020 20:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603745600;
        bh=y1D9L8E6J/uuNCluazyQzJ3Y4QFpeS8HDgm2/3UsqVI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jj0Lx1iGs1yyEs2+ciPZF5rVOKKclBgRVVCXZq58KgwMWsx8dY77/jlhyinU6sk97
         3tluyFX9q+so6Yk4lFnWXj1B7YdOQKzCYQ+9CUDuNKjw50zubNY57zP3PQ/kEC5Y6m
         rblOyFpQsQggIEXdWRTMs8VfF0lS9xpe/W1d1d38=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6ABA335207A6; Mon, 26 Oct 2020 13:53:20 -0700 (PDT)
Date:   Mon, 26 Oct 2020 13:53:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call_rcu: Fix race between rcu_barrier() and
 call_rcu_data_free()
Message-ID: <20201026205320.GT3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201022223021.GA8535@paulmck-ThinkPad-P72>
 <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:58:11PM -0400, Mathieu Desnoyers wrote:
> ----- On Oct 22, 2020, at 6:30 PM, paulmck paulmck@kernel.org wrote:
> 
> > The current code can lose RCU callbacks at shutdown time, which can
> > result in hangs.  This lossage can happen as follows:
> > 
> > o       A thread invokes call_rcu_data_free(), which executes up through
> >        the wake_call_rcu_thread().  At this point, the call_rcu_data
> >        structure has been drained of callbacks, but is still on the
> >        call_rcu_data_list.  Note that this thread does not hold the
> >        call_rcu_mutex.
> > 
> > o       Another thread invokes rcu_barrier(), which traverses the
> >        call_rcu_data_list under the protection of call_rcu_mutex,
> >        a list which still includes the above newly drained structure.
> >        This thread therefore adds a callback to the newly drained
> >        call_rcu_data structure.  It then releases call_rcu_mutex and
> >        enters a mystifying loop that does futex stuff.
> > 
> > o       The first thread finishes executing call_rcu_data_free(),
> >        which acquires call_rcu_mutex just long enough to remove the
> >        newly drained call_rcu_data structure from call_rcu_data_list.
> >        Which causes one of the rcu_barrier() invocation's callbacks to
> >        be leaked.
> > 
> > o       The second thread's rcu_barrier() invocation never returns
> >        resulting in a hang.
> > 
> > This commit therefore changes call_rcu_data_free() to acquire
> > call_rcu_mutex before checking the call_rcu_data structure for callbacks.
> > In the case where there are no callbacks, call_rcu_mutex is held across
> > both the check and the removal from call_rcu_data_list, thus preventing
> > rcu_barrier() from adding a callback in the meantime.  In the case where
> > there are callbacks, call_rcu_mutex must be momentarily dropped across
> > the call to get_default_call_rcu_data(), which can itself acquire
> > call_rcu_mutex.  This momentary drop is not a problem because any
> > callbacks that rcu_barrier() might queue during that period of time will
> > be moved to the default call_rcu_data structure, and the lock will be
> > held across the full time including moving those callbacks and removing
> > the call_rcu_data structure that was passed into call_rcu_data_free()
> > from call_rcu_data_list.
> > 
> > With this fix, a several-hundred-CPU test successfully completes more
> > than 5,000 executions.  Without this fix, it fails within a few tens
> > of executions.  Although the failures happen more quickly on larger
> > systems, in theory this could happen on a single-CPU system, courtesy
> > of preemption.
> 
> I agree with this fix, will merge in liburcu master, stable-0.12, and stable-2.11.
> Out of curiosity, which test is hanging ?  Is it a test which is part of the liburcu
> tree or some out-of-tree test ? I wonder why we did not catch it in our CI [1].

The hung test was from perfbook [1] in the CodeSamples/datastruct/hash
directory.  A repeat-by is as follows:

# Have userspace RCU preinstalled as you wish.
git clone git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
cd CodeSamples
make pthreads
cd datastruct/hash
make
time for ((i = 0; i < 2000; i++)); do echo $i; ./hash_bkt_rcu --schroedinger --nreaders 444 --nupdaters 4 --duration 1000 --updatewait 1 --nbuckets 262144 --elems/writer 65536; done

This normally hangs within a few tens of iterations.  With this patch,
the passes more than 6,000 iterations.

I have smaller tests that produce this same hang on my 12-CPU laptop,
but with much lower probability.  Here is one example that did hang on
my laptop, and which could be placed into a similar bash loop as above:

hash_bkt_rcu --schroedinger --nreaders 10 --nupdaters 2 --duration 1000 --updatewait 1 --nbuckets 8192 --elems/writer 4096

But I don't have a good estimate of the hang probability, except a
suspicion that it is lower than would be convenient for a CI test.
Attaching to the hung process using gdb did confirm the type of hang,
however.

It might be possible to create a focused test that races rcu_barrier()
against thread exit, where threads are created and exit repeatedly,
and make a per-thread call_rcu() worker in the meantime..

Thoughts?

							Thanx, Paul

[1]	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git

> Thanks,
> 
> Mathieu
> 
> [1] https://ci.lttng.org/view/Liburcu/
> 
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Stephen Hemminger <stephen@networkplumber.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: <lttng-dev@lists.lttng.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > 
> > ---
> > 
> > urcu-call-rcu-impl.h |    7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
> > index b6ec6ba..18fd65a 100644
> > --- a/src/urcu-call-rcu-impl.h
> > +++ b/src/urcu-call-rcu-impl.h
> > @@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> > 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
> > 			(void) poll(NULL, 0, 1);
> > 	}
> > +	call_rcu_lock(&call_rcu_mutex);
> > 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
> > -		/* Create default call rcu data if need be */
> > +		call_rcu_unlock(&call_rcu_mutex);
> > +		/* Create default call rcu data if need be. */
> > +		/* CBs queued here will be handed to the default list. */
> > 		(void) get_default_call_rcu_data();
> > +		call_rcu_lock(&call_rcu_mutex);
> > 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
> > 			&default_call_rcu_data->cbs_tail,
> > 			&crdp->cbs_head, &crdp->cbs_tail);
> > @@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> > 		wake_call_rcu_thread(default_call_rcu_data);
> > 	}
> > 
> > -	call_rcu_lock(&call_rcu_mutex);
> > 	cds_list_del(&crdp->list);
> >  	call_rcu_unlock(&call_rcu_mutex);
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
