Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E42CF9FA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 07:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLEGPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 01:15:50 -0500
Received: from m12-17.163.com ([220.181.12.17]:36312 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgLEGPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 01:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2/jhAwMajH8k2J2ZK9
        X/1hEzEK4bVDfiEmqV5lNgiHE=; b=iTCK4M7+GHaYvTW6aReSaT88Fx5roEdGtZ
        cfFVF4FLlx9hHp18SOPmck0lD0vT/+SGVqWTOzNCUXSSo4EZDeGgVRQPjvptgdW4
        3jEHTRJBMtuJRGTQwyqnog0YxMD0p9sLjmZS6eAY30vXind9oE1hmUbJ91Sl1Vck
        zmsSiEnyw=
Received: from localhost.localdomain (unknown [223.87.230.17])
        by smtp13 (Coremail) with SMTP id EcCowAC3tIygAMtfds9_Xw--.30129S2;
        Sat, 05 Dec 2020 11:38:10 +0800 (CST)
From:   carver4lio@163.com
To:     mingo@redhat.com
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        carver4lio@163.com, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] sched/rt:fix the missing of rt_rq runtime check in rt-period timer
Date:   Sat,  5 Dec 2020 11:38:01 +0800
Message-Id: <20201205033801.6924-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowAC3tIygAMtfds9_Xw--.30129S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4DGF13WFykXry8tr13Jwb_yoW5JFy3pF
        ZrX34xGa1vy3WUKa48A3s7WryFgws5try7J3WDt3yxA3W5Wrn0qr1rtFs3KFW0gFn3CFWx
        AF1DG34fua1DtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U04EiUUUUU=
X-Originating-IP: [223.87.230.17]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/1tbiWBHwnVuHujdBTAADs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

The rq->rd->span of a cpu in a system with isolated cpus splited into two
different parts: one is for isolated cpus, another for non-isolated cpus.

When CONFIG_RT_GROUP_SCHED enabled, the handler of sched_rt_period_timer
updates rt_time and rt_runtime for every cpus in rq(this_cpu)->rd->span.

It means that other parts cpus out of this_cpu's rd->span will be missed
by sched_rt_period_timer handler, when CONFIG_RT_GROUP_SCHED enabled and
isolated cpus presents in system.

E.g problem will be triggered as follows on my 8 cores machine:
1 enable  CONFIG_RT_GROUP_SCHED=y, and boot kernel with command-line
  "isolcpus=4-7"
2 create a child group and init it:
  mount -t cgroup -o cpu cpu /sys/fs/cgruop
  mkdir /sys/fs/cgroup/child0
  echo 950000 > /sys/fs/cgroup/child0/cpu.rt_runtime_us
3 run two rt-loop tasks, assume their pids are $pid1 and $pid2
4 affinity a rt task to the isolated cpu-sets
  taskset -p 0xf0 $pid2
5 add tasks created above into child cpu-group
  echo $pid1 > /sys/fs/cgroup/child0/tasks
  echo $pid2 > /sys/fs/cgroup/child0/tasks
6 check wat happened:
  "top": one of the task will fail to has cpu usage, but its stat is "R"
  "kill": the task on the problem rt_rq can't be killed

This patch will fix this problem.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 kernel/sched/rt.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8..c5c39695c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -855,19 +855,10 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	int i, idle = 1, throttled = 0;
 	const struct cpumask *span;
 
-	span = sched_rt_period_mask();
 #ifdef CONFIG_RT_GROUP_SCHED
-	/*
-	 * FIXME: isolated CPUs should really leave the root task group,
-	 * whether they are isolcpus or were isolated via cpusets, lest
-	 * the timer run on a CPU which does not service all runqueues,
-	 * potentially leaving other CPUs indefinitely throttled.  If
-	 * isolation is really required, the user will turn the throttle
-	 * off to kill the perturbations it causes anyway.  Meanwhile,
-	 * this maintains functionality for boot and/or troubleshooting.
-	 */
-	if (rt_b == &root_task_group.rt_bandwidth)
-		span = cpu_online_mask;
+	span = cpu_online_mask;
+#else
+	span = sched_rt_period_mask();
 #endif
 	for_each_cpu(i, span) {
 		int enqueue = 0;
-- 
2.17.1


