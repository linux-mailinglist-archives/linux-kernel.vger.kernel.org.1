Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2177B29978C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJZT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:58:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:60334 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJZT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:58:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1B5CD243704;
        Mon, 26 Oct 2020 15:58:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZL3Q0D64S4Pw; Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BB44024322C;
        Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BB44024322C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603742291;
        bh=6bDfcNuSHP++VXZbWaV+GtEV59HKlNd9sGnU/eDxTPo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hWmRMomF+g5hzWDAt5usEi1hee/PZxxwyaP8NVUgqyYM56jFryFjGl2EMgEwRtBK8
         xoQy+BClCPI1H2wzGiTS3Tbdeor4DHrnnws9DRpbcQ2HB0ifor7pKnxd2kCKwZabiB
         jBG4sgAMARUN2EvEXtoR90sjQaqZA+zrFXlCm3OOdwx5hk4GoqBk/w02hsWgG97qqw
         isyfeTTjiTR1rzayCP4J712yuLRDvocMIxeOdLQ7U7zsNRhcUDDQPftzIUGXuTRKps
         DfIel7WsPtCFvBV4ujKnnwSJ8PSOXOO70RaVS6SZfVZ6GsVzsdQTv50QzpetnndpSu
         uUGPdwgqOvkkQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LiksraaO4Ybn; Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id ADC0F243624;
        Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
Date:   Mon, 26 Oct 2020 15:58:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1576751762.38206.1603742291604.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201022223021.GA8535@paulmck-ThinkPad-P72>
References: <20201022223021.GA8535@paulmck-ThinkPad-P72>
Subject: Re: [PATCH] call_rcu: Fix race between rcu_barrier() and
 call_rcu_data_free()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: call_rcu: Fix race between rcu_barrier() and call_rcu_data_free()
Thread-Index: rMNXOOdfGCDrW92dFjPnT/ePYC8HIQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 22, 2020, at 6:30 PM, paulmck paulmck@kernel.org wrote:

> The current code can lose RCU callbacks at shutdown time, which can
> result in hangs.  This lossage can happen as follows:
> 
> o       A thread invokes call_rcu_data_free(), which executes up through
>        the wake_call_rcu_thread().  At this point, the call_rcu_data
>        structure has been drained of callbacks, but is still on the
>        call_rcu_data_list.  Note that this thread does not hold the
>        call_rcu_mutex.
> 
> o       Another thread invokes rcu_barrier(), which traverses the
>        call_rcu_data_list under the protection of call_rcu_mutex,
>        a list which still includes the above newly drained structure.
>        This thread therefore adds a callback to the newly drained
>        call_rcu_data structure.  It then releases call_rcu_mutex and
>        enters a mystifying loop that does futex stuff.
> 
> o       The first thread finishes executing call_rcu_data_free(),
>        which acquires call_rcu_mutex just long enough to remove the
>        newly drained call_rcu_data structure from call_rcu_data_list.
>        Which causes one of the rcu_barrier() invocation's callbacks to
>        be leaked.
> 
> o       The second thread's rcu_barrier() invocation never returns
>        resulting in a hang.
> 
> This commit therefore changes call_rcu_data_free() to acquire
> call_rcu_mutex before checking the call_rcu_data structure for callbacks.
> In the case where there are no callbacks, call_rcu_mutex is held across
> both the check and the removal from call_rcu_data_list, thus preventing
> rcu_barrier() from adding a callback in the meantime.  In the case where
> there are callbacks, call_rcu_mutex must be momentarily dropped across
> the call to get_default_call_rcu_data(), which can itself acquire
> call_rcu_mutex.  This momentary drop is not a problem because any
> callbacks that rcu_barrier() might queue during that period of time will
> be moved to the default call_rcu_data structure, and the lock will be
> held across the full time including moving those callbacks and removing
> the call_rcu_data structure that was passed into call_rcu_data_free()
> from call_rcu_data_list.
> 
> With this fix, a several-hundred-CPU test successfully completes more
> than 5,000 executions.  Without this fix, it fails within a few tens
> of executions.  Although the failures happen more quickly on larger
> systems, in theory this could happen on a single-CPU system, courtesy
> of preemption.

I agree with this fix, will merge in liburcu master, stable-0.12, and stable-2.11.
Out of curiosity, which test is hanging ?  Is it a test which is part of the liburcu
tree or some out-of-tree test ? I wonder why we did not catch it in our CI [1].

Thanks,

Mathieu

[1] https://ci.lttng.org/view/Liburcu/

> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: <lttng-dev@lists.lttng.org>
> Cc: <linux-kernel@vger.kernel.org>
> 
> ---
> 
> urcu-call-rcu-impl.h |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
> index b6ec6ba..18fd65a 100644
> --- a/src/urcu-call-rcu-impl.h
> +++ b/src/urcu-call-rcu-impl.h
> @@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
> 			(void) poll(NULL, 0, 1);
> 	}
> +	call_rcu_lock(&call_rcu_mutex);
> 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
> -		/* Create default call rcu data if need be */
> +		call_rcu_unlock(&call_rcu_mutex);
> +		/* Create default call rcu data if need be. */
> +		/* CBs queued here will be handed to the default list. */
> 		(void) get_default_call_rcu_data();
> +		call_rcu_lock(&call_rcu_mutex);
> 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
> 			&default_call_rcu_data->cbs_tail,
> 			&crdp->cbs_head, &crdp->cbs_tail);
> @@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
> 		wake_call_rcu_thread(default_call_rcu_data);
> 	}
> 
> -	call_rcu_lock(&call_rcu_mutex);
> 	cds_list_del(&crdp->list);
>  	call_rcu_unlock(&call_rcu_mutex);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
