Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF0829414A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395347AbgJTRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:21:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16622
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390715AbgJTRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:21:19 -0400
X-IronPort-AV: E=Sophos;i="5.77,398,1596492000"; 
   d="scan'208";a="362325547"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Oct 2020 19:21:16 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles.Muller@inria.fr
Subject: [PATCH] sched/fair: check for idle core
Date:   Tue, 20 Oct 2020 18:37:59 +0200
Message-Id: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a thread wakeup, the change [1] from runnable load average to load
average for comparing candidate cores means that recent short-running
daemons on the core where a thread ran previously can be considered to
have a higher load than the core performing the wakeup, even when the
core where the thread ran previously is currently idle.  This can
cause a thread to migrate, taking the place of some other thread that
is about to wake up, and so on.  To avoid unnecessary migrations,
extend wake_affine_idle to check whether the core where the thread
previously ran is currently idle, and if so return that core as the
target.

[1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
load in wakeup path")

This particularly has an impact when using passive (intel_cpufreq)
power management, where kworkers run every 0.004 seconds on all cores,
increasing the likelihood that an idle core will be considered to have
a load.

The following numbers were obtained with the benchmarking tool
hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
management were used.  Times are in seconds.  All experiments use all
160 hardware threads.

	v5.9/active		v5.9+patch/active
bt.C.c	24.725724+-0.962340	23.349608+-1.607214
lu.C.x	29.105952+-4.804203	25.249052+-5.561617
sp.C.x	31.220696+-1.831335	30.227760+-2.429792
ua.C.x	26.606118+-1.767384	25.778367+-1.263850

	v5.9/passive		v5.9+patch/passive
bt.C.c	25.330360+-1.028316	23.544036+-1.020189
lu.C.x	35.872659+-4.872090	23.719295+-3.883848
sp.C.x	32.141310+-2.289541	29.125363+-0.872300
ua.C.x	29.024597+-1.667049	25.728888+-1.539772

On the smaller data sets (A and B) and on the other NAS benchmarks
there is no impact on performance.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
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
 

