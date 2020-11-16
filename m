Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD332B4477
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgKPNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgKPNLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:11:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E3CA22240;
        Mon, 16 Nov 2020 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605532267;
        bh=9rGOvbCfiLF/GQwf1J/wo0b6buym/fyVMAzI0egjfu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UB2vADxMRH7gfS3gHVRdEtS4Y/UhMUeUrUBJKzYM9nnzp7k1ybm82AmYSQFTvJZRs
         JDkolwBFUQQcY1B7VPpuCXEi0Df5ffFPeiZ+2qFuAAhFmMknU0EbPDqWa7S+ntjf5k
         6Us+VyhSzVP0DXYEYwOw4tt9JwfkeBPWjg2cODn0=
Date:   Mon, 16 Nov 2020 13:11:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116131102.GA29992@willie-the-truck>
References: <20201116091054.GL3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116091054.GL3371@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> I got cc'd internal bug report filed against a 5.8 and 5.9 kernel
> that loadavg was "exploding" on arch64 on a machines acting as a build
> servers. It happened on at least two different arm64 variants. That setup
> is complex to replicate but fortunately can be reproduced by running
> hackbench-process-pipes while heavily overcomitting a machine with 96
> logical CPUs and then checking if loadavg drops afterwards. With an
> MMTests clone, I reproduced it as follows
> 
> ./run-mmtests.sh --config configs/config-workload-hackbench-process-pipes --no-monitor testrun; \
>     for i in `seq 1 60`; do cat /proc/loadavg; sleep 60; done
> 
> Load should drop to 10 after about 10 minutes and it does on x86-64 but
> remained at around 200+ on arm64.

Do you think you could use this to bisect the problem? Also, are you able
to reproduce the issue on any other arm64 machines, or just this one?

> The reproduction case simply hammers the case where a task can be
> descheduling while also being woken by another task at the same time. It
> takes a long time to run but it makes the problem very obvious. The
> expectation is that after hackbench has been running and saturating the
> machine for a long time.
> 
> Commit dbfb089d360b ("sched: Fix loadavg accounting race") fixed a loadavg
> accounting race in the generic case. Later it was documented why the
> ordering of when p->sched_contributes_to_load is read/updated relative
> to p->on_cpu.  This is critical when a task is descheduling at the same
> time it is being activated on another CPU. While the load/stores happen
> under the RQ lock, the RQ lock on its own does not give any guarantees
> on the task state.
> 
> Over the weekend I convinced myself that it must be because the
> implementation of smp_load_acquire and smp_store_release do not appear
> to implement acquire/release semantics because I didn't find something
> arm64 that was playing with p->state behind the schedulers back (I could
> have missed it if it was in an assembly portion as I can't reliablyh read
> arm assembler). Similarly, it's not clear why the arm64 implementation
> does not call smp_acquire__after_ctrl_dep in the smp_load_acquire
> implementation. Even when it was introduced, the arm64 implementation
> differed significantly from the arm implementation in terms of what
> barriers it used for non-obvious reasons.

Why would you expect smp_acquire__after_ctrl_dep() to be called as part of
the smp_load_acquire() implementation?

FWIW, arm64 has special instructions for acquire and release (and they
actually provide more order than is strictly needed by Linux), so we
just map acquire/release to those instructions directly. Since these
instructions are not available on most 32-bit cores, the arm implementation
just uses the fence-based implementation.

Anyway, setting all that aside, I do agree with you that the bitfield usage
in task_struct looks pretty suspicious. For example, in __schedule() we
have:

	rq_lock(rq, &rf);
	smp_mb__after_spinlock();
	...
	prev_state = prev->state;

	if (!preempt && prev_state) {
		if (signal_pending_state(prev_state, prev)) {
			prev->state = TASK_RUNNING;
		} else {
			prev->sched_contributes_to_load =
				(prev_state & TASK_UNINTERRUPTIBLE) &&
				!(prev_state & TASK_NOLOAD) &&
				!(prev->flags & PF_FROZEN);
			...
			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);

where deactivate_task() updates p->on_rq directly:

	p->on_rq = (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING;

so this is _not_ ordered wrt sched_contributes_to_load. But then over in
__ttwu_queue_wakelist() we have:

	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);

which can be invoked on the try_to_wake_up() path if p->on_rq is first read
as zero and then p->on_cpu is read as 1. Perhaps these non-atomic bitfield
updates can race and cause the flags to be corrupted?

Then again, I went through the list of observed KCSAN splats and don't
see this race showing up in there, so perhaps it's serialised by something
I haven't spotted.

Will
