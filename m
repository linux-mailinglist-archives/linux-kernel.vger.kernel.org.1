Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BF7296BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461358AbgJWJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:22:22 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5252 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461313AbgJWJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:22:21 -0400
X-IronPort-AV: E=Sophos;i="5.77,407,1596492000"; 
   d="scan'208";a="474003322"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 11:21:51 +0200
Date:   Fri, 23 Oct 2020 11:21:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mel Gorman <mgorman@suse.de>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: check for idle core
In-Reply-To: <20201023084016.GP32041@suse.de>
Message-ID: <alpine.DEB.2.22.394.2010231121200.2707@hadrien>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr> <20201023084016.GP32041@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Oct 2020, Mel Gorman wrote:

> On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > In the case of a thread wakeup, wake_affine determines whether a core
> > will be chosen for the thread on the socket where the thread ran
> > previously or on the socket of the waker.  This is done primarily by
> > comparing the load of the core where th thread ran previously (prev)
> > and the load of the waker (this).
> >
> > commit 11f10e5420f6 ("sched/fair: Use load instead of runnable load
> > in wakeup path") changed the load computation from the runnable load
> > to the load average, where the latter includes the load of threads
> > that have already blocked on the core.
> >
> > When a short-running daemon processes happens to run on prev, this
> > change raised the situation that prev could appear to have a greater
> > load than this, even when prev is actually idle.  When prev and this
> > are on the same socket, the idle prev is detected later, in
> > select_idle_sibling.  But if that does not hold, prev is completely
> > ignored, causing the waking thread to move to the socket of the waker.
> > In the case of N mostly active threads on N cores, this triggers other
> > migrations and hurts performance.
> >
> > In contrast, before commit 11f10e5420f6, the load on an idle core
> > was 0, and in the case of a non-idle waker core, the effect of
> > wake_affine was to select prev as the target for searching for a core
> > for the waking thread.
> >
> > To avoid unnecessary migrations, extend wake_affine_idle to check
> > whether the core where the thread previously ran is currently idle,
> > and if so simply return that core as the target.
> > target
> > [1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
> > load in wakeup path")
> >
> > This particularly has an impact when using the ondemand power manager,
> > where kworkers run every 0.004 seconds on all cores, increasing the
> > likelihood that an idle core will be considered to have a load.
> >
> > The following numbers were obtained with the benchmarking tool
> > hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
> > benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
> > tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
> > 2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
> > management were used.  Times are in seconds.  All experiments use all
> > 160 hardware threads.
> >
> > 	v5.9/intel-pstate	v5.9+patch/intel-pstate
> > bt.C.c	24.725724+-0.962340	23.349608+-1.607214
> > lu.C.x	29.105952+-4.804203	25.249052+-5.561617
> > sp.C.x	31.220696+-1.831335	30.227760+-2.429792
> > ua.C.x	26.606118+-1.767384	25.778367+-1.263850
> >
> > 	v5.9/ondemand		v5.9+patch/ondemand
> > bt.C.c	25.330360+-1.028316	23.544036+-1.020189
> > lu.C.x	35.872659+-4.872090	23.719295+-3.883848
> > sp.C.x	32.141310+-2.289541	29.125363+-0.872300
> > ua.C.x	29.024597+-1.667049	25.728888+-1.539772
> >
> > On the smaller data sets (A and B) and on the other NAS benchmarks
> > there is no impact on performance.
> >
> > This also has a major impact on the splash2x.volrend benchmark of the
> > parsec benchmark suite that goes from 1m25 without this patch to 0m45,
> > in active (intel_pstate) mode.
> >
> > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> >
>
> In principal, I think the patch is ok after the recent discussion. I'm
> holding off an ack until a battery of tests on loads with different
> levels of utilisation and wakeup patterns makes its way through a test
> grid. It's based on Linus's tree mid-merge window that includes what is
> in the scheduler pipeline

OK, if it doesn't work out, it would be interesting to know what goes
badly.

thanks,
julia
