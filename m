Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBC29B2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765072AbgJ0Ori (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:47:38 -0400
Received: from mail.efficios.com ([167.114.26.124]:36814 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764807AbgJ0Or3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:47:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 87E5C2C2DAF;
        Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kzEGE0NLNsJq; Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0F5692C2F97;
        Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0F5692C2F97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603810047;
        bh=TzMEYIOL3OHjX7xt3kzSpUtR8OlsCf+hO0BtG/uqtSE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n8/70wcOMT/NsfZ9JYXSfjZ0sXRSoL2LLeCm8dZpwAuXZBz/Ffn5RUz2OWPMQiAL0
         sWGfZw279Nmsrg5fYnlOpzu+TTFnXTueXjoVDeUJdrIeP0ZHE4L8pnNHwe/JOceInF
         A8Muol4HYmtLa9VHj0wzI31UMFvsk2vIIxiPxLL1QPX96IadibvbQAH+e3btQHCKAK
         XuOmYvinrtnpWar0ClOIn6gYhJ2jppC6lziU0fbbxU9yyKO34AbmdQEuj5Owu0Bhml
         2MwyMGm+chE+yDNLGtp4LXlhRlgEenCxyBDGuhSB8UyNrItniFz58m8kPgh1aoydRi
         oCWVCHvgCD+gg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pMc0e0RSVB_Z; Tue, 27 Oct 2020 10:47:27 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F38812C2F39;
        Tue, 27 Oct 2020 10:47:26 -0400 (EDT)
Date:   Tue, 27 Oct 2020 10:47:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <272247506.38717.1603810046973.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201026205320.GT3249@paulmck-ThinkPad-P72>
References: <20201022223021.GA8535@paulmck-ThinkPad-P72> <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com> <20201026205320.GT3249@paulmck-ThinkPad-P72>
Subject: Re: [PATCH] call_rcu: Fix race between rcu_barrier() and
 call_rcu_data_free()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3968)
Thread-Topic: call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()
Thread-Index: W1lGg2TNSwQepZBTRfmC1fHV9JDNFQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 26, 2020, at 4:53 PM, paulmck paulmck@kernel.org wrote:

> On Mon, Oct 26, 2020 at 03:58:11PM -0400, Mathieu Desnoyers wrote:
>> ----- On Oct 22, 2020, at 6:30 PM, paulmck paulmck@kernel.org wrote:
>> 
>> > The current code can lose RCU callbacks at shutdown time, which can
>> > result in hangs.  This lossage can happen as follows:
>> > 
>> > o       A thread invokes call_rcu_data_free(), which executes up through
>> >        the wake_call_rcu_thread().  At this point, the call_rcu_data
>> >        structure has been drained of callbacks, but is still on the
>> >        call_rcu_data_list.  Note that this thread does not hold the
>> >        call_rcu_mutex.
>> > 
>> > o       Another thread invokes rcu_barrier(), which traverses the
>> >        call_rcu_data_list under the protection of call_rcu_mutex,
>> >        a list which still includes the above newly drained structure.
>> >        This thread therefore adds a callback to the newly drained
>> >        call_rcu_data structure.  It then releases call_rcu_mutex and
>> >        enters a mystifying loop that does futex stuff.
>> > 
>> > o       The first thread finishes executing call_rcu_data_free(),
>> >        which acquires call_rcu_mutex just long enough to remove the
>> >        newly drained call_rcu_data structure from call_rcu_data_list.
>> >        Which causes one of the rcu_barrier() invocation's callbacks to
>> >        be leaked.
>> > 
>> > o       The second thread's rcu_barrier() invocation never returns
>> >        resulting in a hang.
>> > 
>> > This commit therefore changes call_rcu_data_free() to acquire
>> > call_rcu_mutex before checking the call_rcu_data structure for callbacks.
>> > In the case where there are no callbacks, call_rcu_mutex is held across
>> > both the check and the removal from call_rcu_data_list, thus preventing
>> > rcu_barrier() from adding a callback in the meantime.  In the case where
>> > there are callbacks, call_rcu_mutex must be momentarily dropped across
>> > the call to get_default_call_rcu_data(), which can itself acquire
>> > call_rcu_mutex.  This momentary drop is not a problem because any
>> > callbacks that rcu_barrier() might queue during that period of time will
>> > be moved to the default call_rcu_data structure, and the lock will be
>> > held across the full time including moving those callbacks and removing
>> > the call_rcu_data structure that was passed into call_rcu_data_free()
>> > from call_rcu_data_list.
>> > 
>> > With this fix, a several-hundred-CPU test successfully completes more
>> > than 5,000 executions.  Without this fix, it fails within a few tens
>> > of executions.  Although the failures happen more quickly on larger
>> > systems, in theory this could happen on a single-CPU system, courtesy
>> > of preemption.
>> 
>> I agree with this fix, will merge in liburcu master, stable-0.12, and
>> stable-2.11.
>> Out of curiosity, which test is hanging ?  Is it a test which is part of the
>> liburcu
>> tree or some out-of-tree test ? I wonder why we did not catch it in our CI [1].
> 
> The hung test was from perfbook [1] in the CodeSamples/datastruct/hash
> directory.  A repeat-by is as follows:
> 
> # Have userspace RCU preinstalled as you wish.
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
> cd CodeSamples
> make pthreads
> cd datastruct/hash
> make
> time for ((i = 0; i < 2000; i++)); do echo $i; ./hash_bkt_rcu --schroedinger
> --nreaders 444 --nupdaters 4 --duration 1000 --updatewait 1 --nbuckets 262144
> --elems/writer 65536; done
> 
> This normally hangs within a few tens of iterations.  With this patch,
> the passes more than 6,000 iterations.
> 
> I have smaller tests that produce this same hang on my 12-CPU laptop,
> but with much lower probability.  Here is one example that did hang on
> my laptop, and which could be placed into a similar bash loop as above:
> 
> hash_bkt_rcu --schroedinger --nreaders 10 --nupdaters 2 --duration 1000
> --updatewait 1 --nbuckets 8192 --elems/writer 4096
> 
> But I don't have a good estimate of the hang probability, except a
> suspicion that it is lower than would be convenient for a CI test.
> Attaching to the hung process using gdb did confirm the type of hang,
> however.
> 
> It might be possible to create a focused test that races rcu_barrier()
> against thread exit, where threads are created and exit repeatedly,
> and make a per-thread call_rcu() worker in the meantime..
> 
> Thoughts?

We'll try to come up with a narrowed-down test-case which reproduce the issue.
We may get some inspiration from your test-case. I'll ask Michael Jeanson
to add this to our backlog.

Thanks,

Mathieu

> 
>							Thanx, Paul
> 
> [1]	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/perfbook.git
> 
>> Thanks,
>> 
>> Mathieu
>> 
>> [1] https://ci.lttng.org/view/Liburcu/
>> 
>> > 
>> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> > Cc: Stephen Hemminger <stephen@networkplumber.org>
>> > Cc: Alan Stern <stern@rowland.harvard.edu>
>> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>> > Cc: <lttng-dev@lists.lttng.org>
>> > Cc: <linux-kernel@vger.kernel.org>
>> > 
>> > ---
>> > 
>> > urcu-call-rcu-impl.h |    7 +++++--
>> > 1 file changed, 5 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
>> > index b6ec6ba..18fd65a 100644
>> > --- a/src/urcu-call-rcu-impl.h
>> > +++ b/src/urcu-call-rcu-impl.h
>> > @@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
>> > 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
>> > 			(void) poll(NULL, 0, 1);
>> > 	}
>> > +	call_rcu_lock(&call_rcu_mutex);
>> > 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
>> > -		/* Create default call rcu data if need be */
>> > +		call_rcu_unlock(&call_rcu_mutex);
>> > +		/* Create default call rcu data if need be. */
>> > +		/* CBs queued here will be handed to the default list. */
>> > 		(void) get_default_call_rcu_data();
>> > +		call_rcu_lock(&call_rcu_mutex);
>> > 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
>> > 			&default_call_rcu_data->cbs_tail,
>> > 			&crdp->cbs_head, &crdp->cbs_tail);
>> > @@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
>> > 		wake_call_rcu_thread(default_call_rcu_data);
>> > 	}
>> > 
>> > -	call_rcu_lock(&call_rcu_mutex);
>> > 	cds_list_del(&crdp->list);
>> >  	call_rcu_unlock(&call_rcu_mutex);
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
