Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB12D75E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436468AbgLKMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395446AbgLKMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:42:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B0C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HxtMe2RTWBXgte/NUjhtB27MhatjqegNu+Wg57ON0ic=; b=2Rx8vacsSZoms3TLOdPMTD3xSQ
        ps2aQyzaafbbTnWlWOjytns9jgHCKtCra7YKnwCHvR2mriaVtrdTi0gGDMMzLQhg6SHUso5PIN2RH
        h03Px7URCYBXOK8HG/+F0BIX8l5LCUkeeNUiWJnzBDeAytbZSivUj9a1blziDAqzjlbCtK61+LJVX
        HLVpUBzjehk7cgFnsANe2D89xaEn7WTq7NUXW/iipYXYeWXTllwQdK5LnDdNgWoCgCnAaewh8YSp8
        JUZPK39A9yHWm5o0o4nQzKkhuLqEZR25gGC44EOL61S0O7oaZUzTMmaLjTLE2B9f6G4o1GLV+Nmv4
        AQ8DBfaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knhk6-0002Iq-KX; Fri, 11 Dec 2020 12:41:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C87E23003D8;
        Fri, 11 Dec 2020 13:41:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A943421BE8D82; Fri, 11 Dec 2020 13:41:48 +0100 (CET)
Date:   Fri, 11 Dec 2020 13:41:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during
 late hotplug
Message-ID: <20201211124148.GW2414@hirez.programming.kicks-ass.net>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
 <20201210163830.21514-3-valentin.schneider@arm.com>
 <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:39:21AM +0000, Vincent Donnefort wrote:
> Hi Valentin,
> 
> On Thu, Dec 10, 2020 at 04:38:30PM +0000, Valentin Schneider wrote:
> > Per-CPU kworkers forcefully migrated away by hotplug via
> > workqueue_offline_cpu() can end up spawning more kworkers via
> > 
> >   manage_workers() -> maybe_create_worker()
> > 
> > Workers created at this point will be bound using
> > 
> >   pool->attrs->cpumask
> > 
> > which in this case is wrong, as the hotplug state machine already migrated
> > all pinned kworkers away from this CPU. This ends up triggering the BUG_ON
> > condition is sched_cpu_dying() (i.e. there's a kworker enqueued on the
> > dying rq).
> > 
> > Special-case workers being attached to DISASSOCIATED pools and bind them to
> > cpu_active_mask, mimicking them being present when workqueue_offline_cpu()
> > was invoked.
> > 
> > Link: https://lore.kernel.org/r/ff62e3ee994efb3620177bf7b19fab16f4866845.camel@redhat.com
> > Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
> 
> Isn't the problem introduced by 1cf12e0 ("sched/hotplug: Consolidate
> task migration on CPU unplug") ?
> 
> Previously we had:
> 
>  AP_WORKQUEUE_ONLINE -> set POOL_DISASSOCIATED
>    ...
>  TEARDOWN_CPU -> clear CPU in cpu_online_mask
>    |
>    |-AP_SCHED_STARTING -> migrate_tasks()
>    |
>   AP_OFFLINE
> 
> worker_attach_to_pool(), is "protected" by the cpu_online_mask in
> set_cpus_allowed_ptr(). IIUC, now, the tasks being migrated before the
> cpu_online_mask is actually flipped, there's a window, between
> CPUHP_AP_SCHED_WAIT_EMPTY and CPUHP_TEARDOWN_CPU where a kworker can wake-up
> a new one, for the hotunplugged pool that wouldn't be caught by the
> hotunplug migration.

Yes, very much so, however the commit Valentin picked was supposed to
preemptively fix this. So we can consider this a fix for the fix.

But I don't mind an alternative or perhaps even second Fixes tag on
this.
