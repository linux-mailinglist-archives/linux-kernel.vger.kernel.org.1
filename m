Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD8296089
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900544AbgJVN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:59:22 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:21787
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900535AbgJVN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:59:22 -0400
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="362506150"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 22 Oct 2020 15:59:07 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: check for idle core
Date:   Thu, 22 Oct 2020 15:15:50 +0200
Message-Id: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of a thread wakeup, wake_affine determines whether a core
will be chosen for the thread on the socket where the thread ran
previously or on the socket of the waker.  This is done primarily by
comparing the load of the core where th thread ran previously (prev)
and the load of the waker (this).

commit 11f10e5420f6 ("sched/fair: Use load instead of runnable load
in wakeup path") changed the load computation from the runnable load
to the load average, where the latter includes the load of threads
that have already blocked on the core.

When a short-running daemon processes happens to run on prev, this
change raised the situation that prev could appear to have a greater
load than this, even when prev is actually idle.  When prev and this
are on the same socket, the idle prev is detected later, in
select_idle_sibling.  But if that does not hold, prev is completely
ignored, causing the waking thread to move to the socket of the waker.
In the case of N mostly active threads on N cores, this triggers other
migrations and hurts performance.

In contrast, before commit 11f10e5420f6, the load on an idle core
was 0, and in the case of a non-idle waker core, the effect of
wake_affine was to select prev as the target for searching for a core
for the waking thread.

To avoid unnecessary migrations, extend wake_affine_idle to check
whether the core where the thread previously ran is currently idle,
and if so simply return that core as the target.

[1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
load in wakeup path")

This particularly has an impact when using the ondemand power manager,
where kworkers run every 0.004 seconds on all cores, increasing the
likelihood that an idle core will be considered to have a load.

The following numbers were obtained with the benchmarking tool
hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
management were used.  Times are in seconds.  All experiments use all
160 hardware threads.

	v5.9/intel-pstate	v5.9+patch/intel-pstate
bt.C.c	24.725724+-0.962340	23.349608+-1.607214
lu.C.x	29.105952+-4.804203	25.249052+-5.561617
sp.C.x	31.220696+-1.831335	30.227760+-2.429792
ua.C.x	26.606118+-1.767384	25.778367+-1.263850

	v5.9/ondemand		v5.9+patch/ondemand
bt.C.c	25.330360+-1.028316	23.544036+-1.020189
lu.C.x	35.872659+-4.872090	23.719295+-3.883848
sp.C.x	32.141310+-2.289541	29.125363+-0.872300
ua.C.x	29.024597+-1.667049	25.728888+-1.539772

On the smaller data sets (A and B) and on the other NAS benchmarks
there is no impact on performance.

This also has a major impact on the splash2x.volrend benchmark of the
parsec benchmark suite that goes from 1m25 without this patch to 0m45,
in active (intel_pstate) mode.

Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>

---
v2: rewrite the log message, add volrend information

 kernel/sched/fair.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..9b23dad883ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5804,6 +5804,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
 
+	if (available_idle_cpu(prev_cpu))
+		return prev_cpu;
+
 	return nr_cpumask_bits;
 }
 

