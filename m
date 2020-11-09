Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56C2AB1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgKIHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:51:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:33750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgKIHvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:51:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604908259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qg5Pi+sMAA7PwXHi8JkHRstYeV1aftzdzAHHAsIIAtQ=;
        b=MhURRHaVmstXZXNgSFKtAk7ca7t+TSOfXWrVZwYRchDM0keBxmMEmUXOTZjVO3xNvgQoEm
        bYKI9gk9CBuZiHgPjHkX5o6eYw537WrX3vUzqAYn4XRvR39Hp87TSOTagGwjkodSvcOjT9
        GhzVvld2ARF7iEov7ecElQMdiimyEGE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24C7FABCC;
        Mon,  9 Nov 2020 07:50:59 +0000 (UTC)
Date:   Mon, 9 Nov 2020 08:50:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <20201109075058.GC12240@dhcp22.suse.cz>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9efp7cs.fsf@notabene.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-11-20 13:54:59, Neil Brown wrote:
> 
> If a worker task for a normal (bound, non-CPU-intensive) calls
> cond_resched(), this allows other non-workqueue processes to run, but
> does *not* allow other workqueue workers to run.  This is because
> workqueue will only attempt to run one task at a time on each CPU,
> unless the current task actually sleeps.
> 
> This is already a problem for should_reclaim_retry() in mm/page_alloc.c,
> which inserts a small sleep just to convince workqueue to allow other
> workers to run.
> 
> It can also be a problem for NFS when closing a very large file (e.g.
> 100 million pages in memory).  NFS can call the final iput() from a
> workqueue, which can then take long enough to trigger a workqueue-lockup
> warning, and long enough for performance problems to be observed.
> 
> I added a WARN_ON_ONCE() in cond_resched() to report when it is run from
> a workqueue, and got about 20 hits during boot, many of system_wq (aka
> "events") which suggests there is a real chance that worker are being
> delayed unnecessarily be tasks which are written to politely relinquish
> the CPU.
> 
> I think that once a worker calls cond_resched(), it should be treated as
> though it was run from a WQ_CPU_INTENSIVE queue, because only cpu-intensive
> tasks need to call cond_resched().  This would allow other workers to be
> scheduled.
> 
> The following patch achieves this I believe.

I cannot really judge the implementation because my understanding of the
WQ concurrency control is very superficial but I echo that the existing
behavior is really nonintuitive. It certainly burnt me for the oom
situations where the page allocator cannot make much progress to reclaim
memory and it has to retry really hard. Having to handle worker context
explicitly/differently is error prone and as your example of final iput
in NFS shows that the allocator is not the only path affected so having
a general solution is better.

That being said I would really love to see cond_resched to work
transparently.

Thanks!
-- 
Michal Hocko
SUSE Labs
